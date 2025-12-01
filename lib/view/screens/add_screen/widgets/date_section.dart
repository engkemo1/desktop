// lib/screens/add_screen/widgets/date_section.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../cubit/add_invoice_cubit.dart';

class DateSection extends StatelessWidget {
  const DateSection({super.key});

  Future<void> _pickDate(BuildContext context, TextEditingController controller, Function(String) onPicked) async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: primaryColor)), child: child!),
    );
    if (selected != null) {
      final formatted = DateFormat.yMd().format(selected);
      controller.text = formatted;
      onPicked(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddInvoiceCubit>();

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.8), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(children: const [
          Expanded(child: Divider(color: Colors.white70)),
          SizedBox(width: 8),
          Text("التاريخ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(width: 8),
          Expanded(child: Divider(color: Colors.white70)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: _datePickerField(context, 'تاريخ الفاتوره', cubit.dateController, (v) => cubit.selectDate(v))),
          const SizedBox(width: 12),
          Expanded(child: _datePickerField(context, 'تاريخ الاستلام', cubit.dateDeliveryController, (v) => cubit.selectDeliveryDate(v))),
        ])
      ]),
    );
  }

  Widget _datePickerField(BuildContext context, String label, TextEditingController controller, Function(String) onPicked) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Colors.white70)),
      const SizedBox(height: 6),
      InkWell(
        onTap: () => _pickDate(context, controller, onPicked),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            const Icon(Icons.date_range_outlined, color: Colors.white70),
            const SizedBox(width: 12),
            Text(controller.text.isNotEmpty ? controller.text : label, style: const TextStyle(color: Colors.black87)),
            const Spacer(),
            const Icon(Icons.arrow_drop_down, color: Colors.white70)
          ]),
        ),
      )
    ]);
  }
}
