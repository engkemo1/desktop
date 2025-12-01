// lib/screens/add_screen/widgets/customer_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../cubit/add_invoice_cubit.dart';

class CustomerSection extends StatelessWidget {
  const CustomerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddInvoiceCubit>();

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0,4))
        ],
      ),
      child: Column(
        children: [
          // header
          Row(
            children: const [
              Expanded(child: Divider(color: Colors.white70)),
              SizedBox(width: 8),
              Text("بيانات العميل", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(width: 8),
              Expanded(child: Divider(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 12),

          // fields
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildField("رقم الفاتورة", cubit.codeController, icon: Icons.confirmation_number),
              _buildField("اسم المشتري", cubit.nameController, icon: Icons.person),
              _buildField("رقم الهاتف", cubit.phoneController, icon: Icons.phone_android, keyboard: TextInputType.phone),
              _buildField("العنوان", cubit.addressController, icon: Icons.home_outlined, keyboard: TextInputType.streetAddress),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {IconData? icon, TextInputType keyboard = TextInputType.text}) {
    return SizedBox(
      width: 320,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboard,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,
            filled: true,
            fillColor: buttonColor,
            hintText: label,
            hintStyle: const TextStyle(color: Colors.black54),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          style: const TextStyle(color: Colors.black87),
        ),
      ]),
    );
  }
}
