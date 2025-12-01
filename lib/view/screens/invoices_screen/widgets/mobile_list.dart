import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Model/products_model.dart';
import 'invoice_card_mobile.dart';

class MobileList extends StatelessWidget {
  final TextEditingController searchController;
  final List<ProductsModel> products;
  final List<ProductsModel> productsSearchList;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onDelete;

  const MobileList({
    Key? key,
    required this.searchController,
    required this.products,
    required this.productsSearchList,
    required this.onSearchChanged,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showSearchResults = productsSearchList.isNotEmpty;
    final isSearchEmpty = searchController.text.isEmpty;

    final sourceList = showSearchResults ? productsSearchList : products;

    if (!showSearchResults && isSearchEmpty && products.isEmpty) {
      // handled elsewhere, but keep safe guard
      return const SizedBox.shrink();
    }

    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // header is outside in parent
            Expanded(
              child: sourceList.isEmpty
                  ? const SizedBox(
                height: 300,
                child: Center(child: Text("لا يوجد فواتير")),
              )
                  : ListView.builder(
                itemCount: sourceList.length,
                itemBuilder: (context, index) {
                  final item = sourceList[index];
                  final date = (item.date != null && item.date!.isNotEmpty)
                      ? DateFormat("yyyy/MM/dd").format(DateTime.parse(item.date!))
                      : '';
                  return InvoiceCardMobile(
                    product: item,
                    date: date,
                    onDelete: onDelete,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
