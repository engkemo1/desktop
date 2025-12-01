import 'package:flutter/material.dart';

import '../../../../Model/products_model.dart';
import '../../../../constants.dart';

import '../../pdf_invoice/file_handeler.dart';
import '../../pdf_invoice/pdf.dart';

class InvoiceCardMobile extends StatelessWidget {
  final ProductsModel product;
  final String date;
  final ValueChanged<String> onDelete;

  const InvoiceCardMobile({
    Key? key,
    required this.product,
    required this.date,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Adapted UI from original; kept all actions identical
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.9),
      ),
      child: ListTile(
        leading: Image.asset("images/receipt.png"),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("رقم الفاتورة: ${product.code.toString()} ", style: const TextStyle(fontSize: 16)),
            Text("الاسم: ${product.name.toString()} ", style: const TextStyle(fontSize: 16)),
            Text("تاريخ الفاتورة: ${date} ", style: const TextStyle(fontSize: 16)),
            Text("هاتف العميل: ${product.phone.toString()} ", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text("قيمة الفاتورة: ${product.total.toString()} ", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text("نوع التفصيل: ${product.type.toString()} ", style: const TextStyle(fontSize: 16)),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    final id = product.sId ?? product.code.toString();
                    onDelete(id);
                  },
                  child: Container(
                    height: 35,
                    width: 100,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: accentCanvasColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.delete, color: Colors.red, size: 20),
                        SizedBox(width: 6),
                        Text(' مسح', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final pdfFile = await PdfInvoiceApi.generate2(product, null);
                    FileHandleApi.openFile(pdfFile);
                  },
                  child: Container(
                    height: 35,
                    width: 100,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: accentCanvasColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.print, color: Colors.white),
                        SizedBox(width: 6),
                        Text(' طباعة', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
