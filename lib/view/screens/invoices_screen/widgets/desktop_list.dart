import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Model/products_model.dart';
import '../../../../constants.dart';
import 'invoice_row_desktop.dart';

class DesktopList extends StatelessWidget {
  final TextEditingController searchController;
  final List<ProductsModel> products;
  final List<ProductsModel> productsSearchList;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onDelete;
  final ValueChanged<ProductsModel> onEdit;

  const DesktopList({
    Key? key,
    required this.searchController,
    required this.products,
    required this.productsSearchList,
    required this.onSearchChanged,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showSearchResults = productsSearchList.isNotEmpty;
    final isSearchEmpty = searchController.text.isEmpty;

    final rowsSource = showSearchResults ? productsSearchList : products;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("images/login.jpg"), fit: BoxFit.fill),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: rowsSource.isEmpty && isSearchEmpty
                  ? const Center(child: Text("لا يوجد فواتير"))
                  : Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingTextStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    headingRowColor: MaterialStateProperty.all(accentCanvasColor),
                    dataRowColor:
                    MaterialStateProperty.all(Colors.white.withOpacity(0.9)),
                    border: TableBorder.all(color: Colors.black),
                    columns: const [
                      DataColumn(label: Center(child: Text('رقم الفاتورة'))),
                      DataColumn(label: Center(child: Text('الاسم'))),
                      DataColumn(label: Center(child: Text('رقم الهاتف'))),
                      DataColumn(label: Center(child: Text('تاريخ الفاتورة'))),
                      DataColumn(label: Center(child: Text('قيمة الفاتورة'))),
                      DataColumn(label: Center(child: Text('نوع التفصيل'))),
                      DataColumn(label: Center(child: Text('تعديل'))),
                      DataColumn(label: Center(child: Text('طباعة'))),
                      DataColumn(label: Center(child: Text('حذف'))),
                    ],
                    rows: List.generate(
                      rowsSource.length,
                          (index) {
                        final item = rowsSource[index];
                        final date = item.date != null && item.date!.isNotEmpty
                            ? DateFormat("yyyy/MM/dd")
                            .format(DateTime.parse(item.date!))
                            : '';
        
                        final time = item.createdAt != null && item.createdAt!.isNotEmpty
                            ? DateFormat("HH:mm a")
                            .format(DateTime.parse(item.createdAt!))
                            : '';
        
                        return InvoiceRowDesktop.buildDataRow(
                          index: index,
                          item: item,
                          date: date,
                          time: time,
                          onDelete: onDelete,
                          onEdit: onEdit,   // ← أضفناه هنا
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
