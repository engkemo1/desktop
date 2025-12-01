import 'package:flutter/material.dart';
import '../../../../Model/products_model.dart';
import '../../../../constants.dart';
import '../../pdf_invoice/file_handeler.dart';
import '../../pdf_invoice/pdf.dart';

class InvoiceRowDesktop {
  static DataRow buildDataRow({
    required int index,
    required ProductsModel item,
    required String date,
    required String time,
    required ValueChanged<String> onDelete,
    required ValueChanged<ProductsModel> onEdit,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(item.code.toString())),
        DataCell(Text(item.name ?? "")),
        DataCell(Text(item.phone ?? "")),
        DataCell(Text(date)),
        DataCell(Text(item.total?.toString() ?? "")),
        DataCell(Text(item.type ?? "")),

        /// زر التعديل
        DataCell(
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => onEdit(item),
          ),
        ),

        /// زر الطباعة (كما هو)
        DataCell(
          Center(
            child: IconButton(
              onPressed: () async {
                final pdfFile = await PdfInvoiceApi.generate2(item, null);
                FileHandleApi.openFile(pdfFile);
              },
              icon: const Icon(Icons.print, color: accentCanvasColor),
            ),
          ),
        ),

        /// زر الحذف
        DataCell(
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDelete(item.sId ?? ""),
          ),
        ),
      ],
    );
  }
}
