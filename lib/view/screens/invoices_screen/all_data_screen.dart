import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../empty_widget.dart';

import '../../../Model/products_model.dart';
import '../../../view_model/cubit/products_cubit/products_cubit.dart';
import '../../../view_model/cubit/products_cubit/add_state.dart';
import 'edit_invoice.dart';
import 'widgets/header.dart';
import 'widgets/mobile_list.dart';
import 'widgets/desktop_list.dart';

class AllDataScreen extends StatefulWidget {
  const AllDataScreen({Key? key}) : super(key: key);

  @override
  State<AllDataScreen> createState() => _AllDataScreenState();
}

class _AllDataScreenState extends State<AllDataScreen> {
  final TextEditingController searchController = TextEditingController();
  List<ProductsModel> productsSearchList = [];

  // Search by name (case-insensitive)
  void searchByName(String query, List<ProductsModel> list) {
    final search = query.toLowerCase();
    if (search.isEmpty) {
      setState(() {
        productsSearchList.clear();
      });
      return;
    }

    final filtered = list.where((p) {
      final name = (p.name ?? '').toLowerCase();
      return name.contains(search);
    }).toList();

    setState(() {
      productsSearchList = filtered;
    });
  }

  // Search by code (case-insensitive)
  void searchByCode(String query, List<ProductsModel> list) {
    final search = query.toLowerCase();
    if (search.isEmpty) {
      setState(() {
        productsSearchList.clear();
      });
      return;
    }

    final filtered = list.where((p) {
      final code = (p.code ?? '').toString().toLowerCase();
      return code.contains(search);
    }).toList();

    setState(() {
      productsSearchList = filtered;
    });
  }

  void onSearchChanged(String val, List<ProductsModel> list) {
    final parsed = int.tryParse(searchController.text);
    if (parsed != null) {
      searchByCode(val, list);
    } else {
      searchByName(val, list);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: const Color(0xff27D8D8),
      body: BlocProvider(
        create: (context) => ProductCubit()..getData(),
        child: BlocConsumer<ProductCubit, ProductsMainState>(
          listener: (context, state) async {
            if (state is GetProductsLoadingState) {
              SmartDialog.showLoading();
              await Future.delayed(const Duration(seconds: 2));
              SmartDialog.dismiss();
            }
          },
          builder: (context, state) {
            final cubit = ProductCubit.get(context);

            // If loading, show progress indicator
            if (state is GetProductsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            // empty list handling (kept same behavior)
            if (cubit.productsModelList.isEmpty) {
              return SizedBox(
                height: double.infinity,width: double.infinity,
                child: Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: Column(
                    children: [
                      Header(
                        isSmallScreen: isSmallScreen,
                        searchController: searchController,
                        onSearchChanged: (val) =>
                            onSearchChanged(val, cubit.productsModelList),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [


                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  alignment: Alignment.center,
                                  child: EmptyWidget(
                                    image: "images/rb_1188.png",
                                    title: 'لايوجد فواتير',
                                    subTitle: 'لايوجد فواتير محفوظة بعد',
                                    titleTextStyle: TextStyle(
                                      fontSize: isSmallScreen ? 13 : 22,
                                      color: const Color(0xff9da9c7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    subtitleTextStyle: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 22,
                                      color: const Color(0xffabb8d6),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Normal state with data
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: Column(
                    children: [
                      Header(
                        isSmallScreen: isSmallScreen,
                        searchController: searchController,
                        onSearchChanged: (val) =>
                            onSearchChanged(val, cubit.productsModelList),
                      ),
                      const SizedBox(height: 20),
                      isSmallScreen
                          ? Expanded(
                        child: MobileList(
                          searchController: searchController,
                          productsSearchList: productsSearchList,
                          onSearchChanged: (val) => onSearchChanged(val, cubit.productsModelList),
                          products: cubit.productsModelList,
                          onDelete: (id) => cubit.deleteProduct(id),
                        ),
                      )
                          : Expanded(
                        child: DesktopList(
                          searchController: searchController,
                          productsSearchList: productsSearchList,
                          onSearchChanged: (val) =>
                              onSearchChanged(val, cubit.productsModelList),
                          products: cubit.productsModelList,
                          onDelete: (id) => cubit.deleteProduct(id),
                          onEdit: (product) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProductScreen(product: product),
                              ),
                            );
                          },
                        ),
                      )
                            ,
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
