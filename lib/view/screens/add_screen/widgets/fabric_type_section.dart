// lib/screens/add_screen/widgets/fabric_type_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Model/category_model.dart';
import '../../../../constants.dart';
import '../../../../view_model/cubit/products_cubit/products_cubit.dart';
import '../cubit/add_invoice_cubit.dart';

class FabricTypeSection extends StatefulWidget {
  const FabricTypeSection({super.key});

  @override
  State<FabricTypeSection> createState() => _FabricTypeSectionState();
}

class _FabricTypeSectionState extends State<FabricTypeSection> {
  List<CategoryModel> categoryModel = [];
  CategoryModel? category;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AddInvoiceCubit>();

    ProductCubit().getDataCategory().then((value) {
      setState(() {
        categoryModel = value;
        category = categoryModel.firstWhere(
              (element) =>
          element.type == cubit.typeController.text &&
              cubit.typeController.text.isNotEmpty,
          orElse: () =>
          categoryModel.isNotEmpty ? categoryModel.first : CategoryModel(type: ''),
        );

        if (category != null) {
          cubit.selectFabricType(category!);
        }
      });
    });
  }

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
            Text("نوع القماش",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            SizedBox(width: 8),
            Expanded(child: Divider(color: Colors.white70)),
          ]),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              DropdownButtonFormField<CategoryModel>(
                value: category,
                items: categoryModel
                    .map((cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(cat.type ?? ''),
                ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    cubit.selectFabricType(val);
                    setState(() => category = val);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'اختر نوع القماش',
                  filled: true,
                  fillColor: buttonColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                ),
              ),
              _textField('الكمية بالمخزن', cubit.quantityTypeController,
                  hint: 'الكمية المتاحة', width: 200, enabled: false),
              _textField('سعر المتر', cubit.priceTypeController,
                  hint: 'السعر', width: 200),
              _textField(
                'الكمية المطلوبة',
                cubit.quantityController,
                hint: 'كم',
                width: 140,
                onChanged: (_) => cubit.updateFabricTotals(),
              ),
              _textField('الاجمالي', cubit.totalTypeController,
                  hint: 'اجمالي', width: 160, enabled: false),
            ],
          )
        ],
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller,
      {String? hint,
        double width = 200,
        bool enabled = true,
        void Function(String)? onChanged}) {
    return SizedBox(
      width: width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: buttonColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          ),
        )
      ]),
    );
  }
}
