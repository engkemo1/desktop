// lib/screens/add_screen/widgets/payment_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../cubit/add_invoice_cubit.dart';
import '../cubit/add_invoice_state.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddInvoiceCubit>();

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(children: const [
            Expanded(child: Divider(color: Colors.white70)),
            SizedBox(width: 8),
            Text("الدفع", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(width: 8),
            Expanded(child: Divider(color: Colors.white70)),
          ]),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _labeledField('القيمة', cubit.prizeController, onChanged: (_) => cubit.recalculateTotal()),
              _labeledField('المصنعية', cubit.worker_costController, onChanged: (_) => cubit.recalculateTotal()),
              _labeledField('المبلغ المدفوع', cubit.amountPaidController, onChanged: (_) => cubit.recalculateRemaining()),
              _labeledField('المبلغ المتبقى', cubit.remainingAmountController, enabled: false),
              _labeledField('الاجمالي', cubit.totalController, enabled: false),
            ],
          ),
          const SizedBox(height: 8),
          BlocBuilder<AddInvoiceCubit, AddInvoiceState>(builder: (context, state) {
            if (state.showOverpay) {
              final cub = context.read<AddInvoiceCubit>();
              final paid = double.tryParse(cub.amountPaidController.text) ?? 0;
              final total = double.tryParse(cub.totalController.text) ?? 0;
              final over = (paid - total).toStringAsFixed(2);
              return Text("يوجد $over جنيه زيادة", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _labeledField(String label, TextEditingController ctrl, {bool enabled = true, Function(String)? onChanged}) {
    return SizedBox(
      width: 220,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          enabled: enabled,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.attach_money, color: Colors.white70),
            filled: true,
            fillColor: buttonColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          ),
        )
      ]),
    );
  }
}
