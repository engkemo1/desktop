import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../../../../view_model/cubit/products_cubit/add_state.dart';
import '../../../../view_model/cubit/products_cubit/products_cubit.dart';
import 'package:printing/printing.dart';

import '../../pdf_invoice/pdf.dart';
import '../cubit/add_invoice_cubit.dart';

class AdditionsBottomButtons extends StatelessWidget {
  const AdditionsBottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddInvoiceCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 200,
          height: 50,
          child: BlocProvider(
            create: (context) => ProductCubit(),
            child: BlocConsumer<ProductCubit, ProductsMainState>(
              listener: (context, state) async {
                if (state is AddProductsLoadingState) {
                  // show your loading (SmartDialog used in original)
                }
              },
              builder: (context, state) {
                final product = ProductCubit.get(context);
                return ElevatedButton(
                  onPressed: () async {
                    // Build product model from cubit
                    final model = cubit.buildProductModel(createdById: "");
                    // Save to server/db
                    await product.postProduct(context, model).then((value) {
                      // original code updated customer here — you can replicate that logic
                      // Clear fields (as original)
                      _clearAfterAdd(cubit, context);
                    });
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColor)),
                  child: const Text('اضافة', style: TextStyle(color: Colors.white)),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              // Use the last built product model (or build again)
              final model = cubit.buildProductModel(createdById: "");
              final pdfFile = await PdfInvoiceApi.generate(model, null);
              await Printing.layoutPdf(onLayout: (format) async => pdfFile.save());
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColor)),
            child: const Text('طباعة', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  void _clearAfterAdd(AddInvoiceCubit cubit, BuildContext context) {
    // clear just a minimal set (mirror your original clearing)
    cubit.nameController.clear();
    cubit.addressController.clear();
    cubit.phoneController.clear();
    cubit.totalController.text = "0.0";
    cubit.amountPaidController.clear();
    cubit.remainingAmountController.clear();

    // also clear addition fields
    cubit.field1Controller.clear();
    cubit.field2Controller.clear();
    cubit.field3Controller.clear();
    cubit.field4Controller.clear();
    cubit.fieldKom1Controller.clear();
    cubit.fieldKom2Controller.clear();
    cubit.fieldKom3Controller.clear();
    cubit.fieldKom4Controller.clear();

    // reset selections (optional)
    cubit.selectSadr(0);
    cubit.selectKom(0);
    cubit.selectGlab(0);
    cubit.selectGanb(0);
    cubit.selectGyb(0);
    cubit.selectTaqwera(0);
    cubit.selectYaqa(0);

    // notify listeners
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تمت الإضافة')));
  }
}
