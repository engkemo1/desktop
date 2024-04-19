import 'dart:ui' as ui;
import 'package:desktop_app/constants.dart';
import 'package:desktop_app/view/screens/add_screen/add_screen.dart';
import 'package:desktop_app/view/screens/home_screen.dart';
import 'package:desktop_app/view/screens/pdf_invoice/file_handeler.dart';
import 'package:desktop_app/view/screens/pdf_invoice/pdf.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hovering/hovering.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../Model/products_model.dart';
import '../widgets/customTextField.dart';
import 'main_screen.dart';

class AllDataScreen extends StatefulWidget {
  @override
  State<AllDataScreen> createState() => _AllDataScreenState();
}

class _AllDataScreenState extends State<AllDataScreen> {
  var searchController = TextEditingController();
  List<ProductsModel> productsSearchList = [];

  void search(var searchName, var list) {
    searchName = searchName.toLowerCase();
    productsSearchList = list.where((search) {
      var searchTitle = search.name!.toString().toLowerCase();
      print(searchTitle.contains(searchName));
      return searchTitle.contains(searchName);
    }).toList();

    if (searchName == "") {
      productsSearchList.clear();
    } else {}
  }

  void searchCode(var code, var list) {
    code = code.toLowerCase();
    productsSearchList = list.where((search) {
      var searchTitle = search.code!.toString().toLowerCase();
      print(searchTitle.contains(code));
      return searchTitle.contains(code);
    }).toList();

    if (code == "") {
      productsSearchList.clear();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: Color(0xff27D8D8),
      body: BlocProvider(
        create: (context) => ProductCubit()..getData(),
        child: BlocConsumer<ProductCubit, ProductsMainState>(
            listener: (BuildContext context, state) async {
          if (state is GetProductsLoadingState) {
            SmartDialog.showLoading();
            await Future.delayed(Duration(seconds: 2));
            SmartDialog.dismiss();
          }
        }, builder: (BuildContext context, state) {
          var data = ProductCubit.get(context);
          return state is GetProductsLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : data.productsModelList.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          "images/login.jpg",
                        ),
                        fit: BoxFit.cover,
                      )),
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: ui.TextDirection.rtl,
                            child: Container(
                              width: double.infinity,
                              color: accentCanvasColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => MainScreen(
                                                        index: 0,
                                                      )));
                                        },
                                        child: HoverAnimatedContainer(
                                          hoverWidth: 200,
                                          padding: EdgeInsets.all(20),
                                          hoverDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red.withOpacity(0.8),
                                          ),
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20),
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xffBCEFC2),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.home),
                                              Text(
                                                "الصفحة الرئيسية",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "قائمة تسليم الفواتير",
                                            style: TextStyle(
                                                fontSize: 35,
                                                wordSpacing: 2,
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            "images/receipt.png",
                                            height: 70,
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => MainScreen(
                                                        index: 2,
                                                      )));
                                        },
                                        child: HoverAnimatedContainer(
                                          hoverWidth: 200,
                                          padding: EdgeInsets.all(20),
                                          hoverDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red.withOpacity(0.8),
                                          ),
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20),
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xffBCEFC2),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                "images/report.png",
                                                height: 30,
                                              ),
                                              Text(
                                                "  اضافة فاتورة",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 100,
                                        right: 100,
                                        bottom: 20,
                                        top: 20),
                                    child: CustomTextField(
                                      controller: searchController,
                                      prefix: Icon(Icons.search),
                                      onChanged: (val) {
                                        var result =
                                            int.tryParse(searchController.text);
                                        if (result != null) {
                                          setState(() {
                                            searchCode(
                                                val, data.productsModelList);
                                          });
                                        } else {
                                          setState(() {
                                            search(val, data.productsModelList);
                                          });
                                        }
                                      },
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            searchController.clear();
                                            productsSearchList.clear();
                                          });
                                        },
                                      ),
                                      hintText: ' ابحث عن فاتورة ',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            alignment: Alignment.center,
                            child: EmptyWidget(
                              // Image from project assets
                              image: null,
                              packageImage: PackageImage.Image_3,
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
                              // Uncomment below statement to hide background animation
                              // hideBackgroundAnimation: true,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: isSmallScreen
                          ? buildCardMobile(data, context)
                          : buildCardDesktop(data, context));
        }),
      ),
    );
  }

  buildCard(int index, ProductCubit data, String date, String time,
      bool isSmallScreen, ProductsMainState state, var productsModelList) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "images/login.jpg",
        ),
        fit: BoxFit.cover,
      )),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(right: 10, bottom: 5, left: 10, top: 10),
        child: SizedBox(
          child: ExpansionTile(
            tilePadding: EdgeInsets.only(left: 2, right: 2),
            title: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                      child: Text(
                    (index + 1).toString(),
                    style: TextStyle(fontSize: 13),
                  )),
                ),
                Text(
                  ' الاسم : ${productsModelList.name} ',
                  style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'القيمة: ${productsModelList.prize} ',
                      style: TextStyle(fontSize: isSmallScreen ? 9 : 15),
                    ),
                    Text(
                      'المبلغ المدفوع: ${productsModelList.prize}',
                      style: TextStyle(fontSize: isSmallScreen ? 9 : 15),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'المبلغ المتبقي:${productsModelList.prize}',
                      style: TextStyle(fontSize: isSmallScreen ? 9 : 15),
                    ),
                    Text(
                      'عدد الاثواب:${productsModelList.numDresses}',
                      style: TextStyle(fontSize: isSmallScreen ? 9 : 15),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    date,
                    style: TextStyle(color: Colors.grey, fontSize: 9),
                  ),
                ),
              ],
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: EdgeInsets.all(10),
            collapsedIconColor: Colors.grey,
            children: [
              DataTable(
                horizontalMargin: 20,
                columnSpacing: 20,
                dataRowMaxHeight: 100,
                headingRowColor: MaterialStateProperty.all(Colors.black26),
                dataTextStyle: TextStyle(fontSize: 12),
                border: TableBorder.all(color: Colors.black),
                rows: [
                  DataRow(cells: [
                    DataCell(Column(children: [
                      SvgPicture.asset(
                        "images/${productsModelList.kom}.svg",
                        height: 40,
                      ),
                      Text(
                        productsModelList.kom.toString(),
                        textAlign: TextAlign.center,
                      )
                    ])),
                    DataCell(Column(children: [
                      SvgPicture.asset(
                        "images/${productsModelList.glab}.svg",
                        height: 40,
                      ),
                      Text(
                        productsModelList.glab.toString(),
                        textAlign: TextAlign.center,
                      )
                    ])),
                    DataCell(Column(children: [
                      SvgPicture.asset(
                        "images/${productsModelList.ganb}.svg",
                        height: 40,
                      ),
                      Text(
                        productsModelList.ganb.toString(),
                        textAlign: TextAlign.center,
                      )
                    ])),
                    DataCell(Column(children: [
                      SvgPicture.asset(
                        "images/${productsModelList.gayb}.svg",
                        height: 30,
                      ),
                      Text(
                        productsModelList.gayb.toString(),
                        textAlign: TextAlign.center,
                      )
                    ])),
                  ])
                ],
                columns: const [
                  DataColumn(
                    label: Center(child: Text('الكم')),
                  ),
                  DataColumn(
                    label: Center(child: Text('جلاب')),
                  ),
                  DataColumn(
                    label: Center(child: Text('جانب')),
                  ),
                  DataColumn(
                    label: Center(child: Text('الجيب')),
                  ),
                ],
              ),
              DataTable(
                horizontalMargin: 25,
                columnSpacing: 25,
                dataRowMaxHeight: 100,
                headingRowColor: MaterialStateProperty.all(Colors.black26),
                dataTextStyle: TextStyle(fontSize: 12),
                border: TableBorder.all(color: Colors.black),
                rows: [
                  DataRow(cells: [
                    DataCell(Column(children: [
                      SvgPicture.asset(
                        "images/${productsModelList.taqwera}.svg",
                        height: 40,
                      ),
                      Text(
                        productsModelList.taqwera.toString(),
                        textAlign: TextAlign.center,
                      )
                    ])),
                    DataCell(Column(children: [
                      SvgPicture.asset(
                        "images/${productsModelList.yaqa}.svg",
                        height: 40,
                      ),
                      Text(
                        productsModelList.yaqa.toString(),
                        textAlign: TextAlign.center,
                      )
                    ])),
                    DataCell(Column(children: [
                      SvgPicture.asset(
                        "images/${productsModelList.sadr}.svg",
                        height: 40,
                      ),
                      Text(
                        productsModelList.sadr.toString(),
                        textAlign: TextAlign.center,
                      )
                    ])),
                  ])
                ],
                columns: const [
                  DataColumn(
                    label: Center(child: Text('التقويرة')),
                  ),
                  DataColumn(
                    label: Center(child: Text('الياقة')),
                  ),
                  DataColumn(
                    label: Center(child: Text('الصدر')),
                  ),
                ],
              ),
              Table(
                border: TableBorder.all(color: Colors.black),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('التاريخ'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(date, textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('الوقت'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(time, textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('الاسم'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.name!,
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('رقم الهاتف'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.phone!,
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('القيمة'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.prize.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('المبلغ المدفوع'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.amountPaid.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('المبلغ المتبقي'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.remainingAmount.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('عدد الاثواب'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.numDresses.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('الطول'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.length.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('وسع الصدر'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.chestLength.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('الرقبة'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.neck.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('وسع اليد'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.handLength.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'طول الكيك',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.kLength.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('المفصل'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.mLength.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('ملاجظات', textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(productsModelList.details.toString(),
                          textAlign: TextAlign.center),
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        data.deleteProduct(productsModelList.sId.toString());
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                  IconButton(
                      onPressed: () async {
                        final pdfFile = await PdfInvoiceApi.generate2(
                            productsModelList, null);

                        // opening the pdf file
                        FileHandleApi.openFile(pdfFile);
                      },
                      icon: Icon(Icons.picture_as_pdf_outlined)),
                  IconButton(
                      onPressed: () async {
                        final pdfFile = await PdfInvoiceApi.generate(
                            productsModelList, null);

                        await Printing.layoutPdf(
                            onLayout: (PdfPageFormat format) async =>
                                pdfFile.save());
                      },
                      icon: const Icon(Icons.print)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCardMobile(ProductCubit data, BuildContext context) {
    if (productsSearchList.isNotEmpty) {
      print(productsSearchList.first.name);
    }
    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "images/login.jpg",
          ),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: accentCanvasColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        },
                        child: HoverAnimatedContainer(
                          hoverWidth: 140,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          hoverDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red.withOpacity(0.8),
                          ),
                          margin: EdgeInsets.only(left: 10, right: 10),
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffBCEFC2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.home,
                                size: 20,
                              ),
                              Text(
                                "الصفحة الرئيسية",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => AddScreen()));
                        },
                        child: HoverAnimatedContainer(
                          hoverWidth: 140,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          hoverDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red.withOpacity(0.8),
                          ),
                          margin: EdgeInsets.only(left: 10, right: 10),
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffBCEFC2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/report.png",
                                height: 40,
                              ),
                              Text(
                                "  اضافة فاتورة",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "الفواتير",
                        style: TextStyle(
                            fontSize: 25,
                            wordSpacing: 2,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        "images/receipt.png",
                        height: 50,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 10),
                    child: SizedBox(
                      height: 50,
                      child: CustomTextField(
                        controller: searchController,
                        prefix: Icon(Icons.search),
                        onChanged: (val) {
                          var result = int.tryParse(searchController.text);
                          if (result != null) {
                            setState(() {
                              searchCode(val, data.productsModelList);
                            });
                          } else {
                            setState(() {
                              search(val, data.productsModelList);
                            });
                          }
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 15,
                          ),
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              productsSearchList.clear();
                            });
                          },
                        ),
                        hintText: ' ابحث عن فاتورة ',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: productsSearchList.isEmpty
                  ? searchController.text.isEmpty
                  ? ListView.builder(
                  itemBuilder: (context, index) {
                    var date = DateFormat("yyyy/MM/dd").format(
                        DateTime.parse(data.productsModelList[index].date!));
                    return  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.9)),
                      child: ListTile(
                        leading: Image.asset("images/receipt.png"),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                                Text(
                                  "رقم الفاتورة: ${data.productsModelList[index].code.toString()} ",
                                  style: TextStyle(fontSize: 16),
                                ),
                            Text(
                                "الاسم: ${data.productsModelList[index].name.toString()} ",
                                style: TextStyle(fontSize: 16)),
                                Text("تاريخ الفاتورة: ${date} ",
                                    style: TextStyle(fontSize: 16)),


                                Text(
                                    "هاتف العميل: ${data.productsModelList[index].phone.toString()} ",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(
                                  width: 20,
                                ),


                            Text(
                                "قيمة الفاتورة: ${data.productsModelList[index].total.toString()} ",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                                "نوع التفصيل: ${data.productsModelList[index].type.toString()} ",
                                style: TextStyle(fontSize: 16)),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    data.deleteProduct(data
                                        .productsModelList[index].sId
                                        .toString());
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: accentCanvasColor),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        Text(
                                          ' مسح',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final pdfFile = await PdfInvoiceApi.generate2(
                                        data.productsModelList[index], null);

                                    // opening the pdf file
                                    FileHandleApi.openFile(pdfFile);
                                  },
                                  child: Container(
                                      height: 35,
                                      width: 100,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: accentCanvasColor),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.print,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            ' طباعة',
                                            style: TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: productsSearchList.isEmpty
                      ? data.productsModelList.length
                      : productsSearchList.length):SizedBox(
                height: 300,
                child: EmptyWidget(
                  packageImage: PackageImage.Image_2,
                  title: "لا يوجد فواتير",
                ),
              ):ListView.builder(
                  itemBuilder: (context, index) {
                    var date = DateFormat("yyyy/MM/dd").format(
                        DateTime.parse(productsSearchList[index].date!));
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.9)),
                      child: ListTile(
                        leading: Image.asset("images/receipt.png"),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "رقم الفاتورة: ${productsSearchList[index].code.toString()} ",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                "الاسم: ${productsSearchList[index].name.toString()} ",
                                style: TextStyle(fontSize: 16)),
                            Text("تاريخ الفاتورة: ${date} ",
                                style: TextStyle(fontSize: 16)),
                            Text(
                                "هاتف العميل: ${productsSearchList[index].phone.toString()} ",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 20,
                            ),

                            Text(
                                "قيمة الفاتورة: ${productsSearchList[index].total.toString()} ",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                                "نوع التفصيل: ${productsSearchList[index].type.toString()} ",
                                style: TextStyle(fontSize: 16)),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    data.deleteProduct(data
                                        .productsSearchList[index].sId
                                        .toString());
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: accentCanvasColor),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        Text(
                                          ' مسح',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final pdfFile = await PdfInvoiceApi.generate2(
                                        productsSearchList[index], null);

                                    // opening the pdf file
                                    FileHandleApi.openFile(pdfFile);
                                  },
                                  child: Container(
                                      height: 35,
                                      width: 100,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: accentCanvasColor),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.print,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            ' طباعة',
                                            style: TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount:
                      productsSearchList.length)
            )
          ],
        ),
      ),
    );
  }

  buildCardDesktop(ProductCubit data, BuildContext context) {
    if (productsSearchList.isNotEmpty) {
      print(productsSearchList.first.name);
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "images/login.jpg",
        ),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: accentCanvasColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MainScreen(
                                      index: 0,
                                    )));
                      },
                      child: HoverAnimatedContainer(
                        hoverWidth: 200,
                        padding: EdgeInsets.all(20),
                        hoverDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.withOpacity(0.8),
                        ),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffBCEFC2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.home),
                            Text(
                              "الصفحة الرئيسية",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "الفواتير",
                          style: TextStyle(
                              fontSize: 35,
                              wordSpacing: 2,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          "images/receipt.png",
                          height: 70,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MainScreen(
                                      index: 2,
                                    )));
                      },
                      child: HoverAnimatedContainer(
                        hoverWidth: 200,
                        padding: EdgeInsets.all(20),
                        hoverDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.withOpacity(0.8),
                        ),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffBCEFC2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "images/report.png",
                              height: 30,
                            ),
                            Text(
                              "  اضافة فاتورة",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 100, right: 100, bottom: 20, top: 20),
                  child: CustomTextField(
                    controller: searchController,
                    prefix: Icon(Icons.search),
                    onChanged: (val) {
                      var result = int.tryParse(searchController.text);
                      if (result != null) {
                        setState(() {
                          searchCode(val, data.productsModelList);
                        });
                      } else {
                        setState(() {
                          search(val, data.productsModelList);
                        });
                      }
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 15,
                      ),
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                          productsSearchList.clear();
                        });
                      },
                    ),
                    hintText: ' ابحث عن فاتورة ',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: productsSearchList.isEmpty
                      ? searchController.text.isEmpty
                          ? DataTable(
                              headingTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              headingRowColor:
                                  MaterialStateProperty.all(accentCanvasColor),
                              dataRowColor: MaterialStateProperty.all(
                                  Colors.white.withOpacity(0.9)),
                              border: TableBorder.all(color: Colors.black),
                              rows: List.generate(
                                data.productsModelList.length,
                                (index) {
                                  var date = DateFormat("yyyy/MM/dd").format(
                                      DateTime.parse(
                                          data.productsModelList[index].date!));
                                  var time = DateFormat("HH:mm a").format(
                                      DateTime.parse(data
                                          .productsModelList[index]
                                          .createdAt!));
                                  return buildDataRow(
                                    index,
                                    data,
                                    date,
                                    data.productsModelList[index],
                                    time,
                                    context,
                                  );
                                },
                              ),
                              columns: const [
                                DataColumn(
                                  label: Center(child: Text('رقم الفاتورة')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('الاسم')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('رقم الهاتف')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('تاريخ الفاتورة')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('قيمة الفاتورة')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('نوع التفصيل')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('طباعة')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('حذف')),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 300,
                              child: EmptyWidget(
                                packageImage: PackageImage.Image_2,
                                title: "لا يوجد فواتير",
                              ),
                            )
                      : DataTable(
                          headingTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          headingRowColor:
                              MaterialStateProperty.all(accentCanvasColor),
                          dataRowColor: MaterialStateProperty.all(
                              Colors.white.withOpacity(0.9)),
                          border: TableBorder.all(color: Colors.black),
                          rows: List.generate(
                            productsSearchList.length,
                            (index) {
                              var date = DateFormat("yyyy/MM/dd").format(
                                  DateTime.parse(
                                      productsSearchList[index].date!));
                              var time = DateFormat("HH:mm a").format(
                                  DateTime.parse(
                                      productsSearchList[index].createdAt!));
                              return buildDataRow(
                                index,
                                data,
                                date,
                                productsSearchList[index],
                                time,
                                context,
                              );
                            },
                          ),
                          columns: const [
                            DataColumn(
                              label: Center(child: Text('رقم الفاتورة')),
                            ),
                            DataColumn(
                              label: Center(child: Text('الاسم')),
                            ),
                            DataColumn(
                              label: Center(child: Text('رقم الهاتف')),
                            ),
                            DataColumn(
                              label: Center(child: Text('تاريخ الفاتورة')),
                            ),
                            DataColumn(
                              label: Center(child: Text('قيمة الفاتورة')),
                            ),
                            DataColumn(
                              label: Center(child: Text('نوع التفصيل')),
                            ),
                            DataColumn(
                              label: Center(child: Text('طباعة')),
                            ),
                            DataColumn(
                              label: Center(child: Text('حذف')),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  DataRow buildDataRow(int index, ProductCubit data, String date,
      var productsModelList, String time, BuildContext context) {
    return DataRow(cells: [
      DataCell(Center(child: Text((productsModelList.code).toString()))),
      DataCell(Center(child: Text(productsModelList.name!))),
      DataCell(Center(child: Text(productsModelList.phone!))),
      DataCell(Center(child: Text("${date}\n ${time}"))),
      DataCell(Center(child: Text(productsModelList.prize.toString()))),
      DataCell(Center(child: Text(productsModelList.type.toString()))),
      DataCell(Center(
        child: IconButton(
            onPressed: () async {
              final pdfFile =
                  await PdfInvoiceApi.generate2(productsModelList, null);

              // opening the pdf file
              FileHandleApi.openFile(pdfFile);
            },
            icon: Icon(
              Icons.print,
              color: accentCanvasColor,
            )),
      )),
      DataCell(Center(
        child: IconButton(
            onPressed: () {
              data.deleteProduct(productsModelList.sId.toString());
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      )),
    ]);
  }
}
