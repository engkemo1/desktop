import 'dart:ui' as ui;
import 'package:desktop_app/constants.dart';
import 'package:desktop_app/view/screens/add_screen/add_screen.dart';
import 'package:desktop_app/view/screens/delivery_list_screen.dart';
import 'package:desktop_app/view/screens/home_screen.dart';
import 'package:desktop_app/view/screens/main_screen.dart';
import 'package:desktop_app/view/screens/pdf_invoice/file_handeler.dart';
import 'package:desktop_app/view/screens/pdf_invoice/pdf.dart';
import 'package:desktop_app/view/widgets/customTextField.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hovering/hovering.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../Model/products_model.dart';
import 'empty_widget.dart';


class ArrivedListScreen extends StatefulWidget {
  @override
  State<ArrivedListScreen> createState() => _ArrivedListScreenState();
}

class _ArrivedListScreenState extends State<ArrivedListScreen> {
  var searchController = TextEditingController();
  List<ProductsModel> productsSearchList = [];

  List<ProductsModel> productModelList=[];


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
          var productList =   data.productsModelList.where((element) {
            return   DateTime.now().difference(DateTime.parse(element.deliveryTime!)).inDays.abs()<=5  ;
          } ).toList();
          print(productList);
          return state is GetProductsLoadingState
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : productList.isEmpty
              ? isSmallScreen?            SafeArea(
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
                              hoverDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red.withOpacity(0.8),
                              ),
                              margin: EdgeInsets.only(left: 5, right: 5),
                              width: 110,
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
                                        fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => AddInvoiceScreen()));
                            },
                            child: HoverAnimatedContainer(
                              hoverWidth: 140,
                              height: 50,
                              hoverDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red.withOpacity(0.8),
                              ),
                              margin: EdgeInsets.only(left: 5, right: 5),
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBCEFC2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "images/report.png",
                                    height: 25,
                                  ),
                                  Text(
                                    "  اضافة فاتورة",
                                    style: TextStyle(
                                        fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => DeliveryListScreen()));
                            },
                            child: HoverAnimatedContainer(
                              hoverWidth: 140,
                              height: 50,
                              hoverDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red.withOpacity(0.8),
                              ),
                              margin: EdgeInsets.only(left: 5, right: 5),
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBCEFC2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "images/clock.png",
                                    height: 25,
                                  ),
                                  Text(
                                    "قوائم التسليم",
                                    style: TextStyle(
                                        fontSize: 13, fontWeight: FontWeight.bold),
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
                            "قائمةالفواتير المستلمة",
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
                            "images/clock.png",
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
                                  searchCode(val, productList);
                                });
                              } else {
                                setState(() {
                                  search(val, productList);
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
                Expanded(child:                    Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  alignment: Alignment.center,
                  child: EmptyWidget(
                    // Image from project assets
                    image:"images/rb_1188.png",
                    title: 'لايوجد فواتير',
                    subTitle: 'لايوجد فواتير قيد التسليم بعد',
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
                )
              ],
            ),
          )
              :Container(
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
                                  "قائمة الفواتير المستلمة",
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
                                  searchCode(val, productList);
                                });
                              } else {
                                setState(() {
                                  search(val, productList);
                                });                                    }


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
                SizedBox(height: 20,),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  alignment: Alignment.center,
                  child: EmptyWidget(
                    // Image from project assets
                    image:"images/rb_1188.png",
                    title: 'لايوجد فواتير',
                    subTitle: 'لايوجد فواتير قيد التسليم بعد',
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



  buildCardDesktop(ProductCubit data, BuildContext context)   {
    bool isSub=false;

    var productList =   data.productsModelList.where((element) => element.isDelliverd==true).toList();

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
                        hoverWidth: 210,
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DeliveryListScreen(
                                )));
                      },
                      child: HoverAnimatedContainer(
                        hoverWidth: 210,
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
                              "images/clock.png",
                              height: 30,
                            ),
                            Text(
                              "   قوائم التسليم ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
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
                        hoverWidth: 210,
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
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "قائمة الفواتير المستلمة",
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
                      "images/delivered.png",

                      height: 70,
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
                          searchCode(val, productList);
                        });
                      } else {
                        setState(() {
                          search(val, productList);
                        });                                    }


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
                Row(
                  children: [
                    Container(
                      height:50,
                      width: 200,
                      padding: const EdgeInsets.all(8.0),

                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                        onPressed: (){
                          if(productModelList.isNotEmpty){
                            print(productModelList[0].isDelliverd);

                            ProductCubit().updateProduct(context,productModelList[0]);
                          }



                          print(productModelList);
                        }, child: Text("تأكيد التسليم"),),
                    ),
                    Spacer(),

                  ],
                ),
                Container(
                  width: double.infinity,

                  padding: EdgeInsets.all(20),
                  child: productsSearchList.isEmpty
                      ? searchController.text.isEmpty
                      ? DataTable(
                    headingTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    headingRowColor:
                    MaterialStateProperty.all(accentCanvasColor),
                    dataRowColor: MaterialStateProperty.all(
                        Colors.white.withOpacity(0.9)),
                    border: TableBorder.all(color: Colors.black),
                    rows: List.generate(
                      productList.length,
                          (index) {
                        var deliveryDate = DateFormat("yyyy/MM/dd").format(
                            DateTime.parse(productList[index].deliveryTime!));
                        var date = DateFormat("yyyy/MM/dd").format(
                            DateTime.parse(
                                productList[index].date!));
                        var time = DateFormat("HH:mm a").format(
                            DateTime.parse(
                                productList[index].createdAt!));
                        return buildDataRow(
                          deliveryDate,
                          DateTime.parse(productList[index].deliveryTime!),

                          index,
                          data,
                          date,
                          productList[index],
                          time,
                          context,
                        );
                      },
                    ),
                    columns: const [
                      DataColumn(
                        label: Center(child: Text('تم التسليم')),
                      ),
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
                        label: Center(child: Text('تاريخ الاستلام')),
                      ),
                      DataColumn(
                        label: Center(child: Text('الايام المتبقية')),
                      ),
                      DataColumn(
                        label: Center(child: Text('المبلغ المتبقي')),
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
                      image:"images/rb_1188.png",
                      title: "لا يوجد فواتير", subTitle: '',
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
                            DateTime.parse(productsSearchList[index].date!));
                        var deliveryDate = DateFormat("yyyy/MM/dd").format(
                            DateTime.parse(productsSearchList[index].deliveryTime!));
                        var time = DateFormat("HH:mm a").format(DateTime.parse(
                            productsSearchList[index].createdAt!));
                        return buildDataRow(

                          deliveryDate,
                          DateTime.parse(productsSearchList[index].deliveryTime!),
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
                        label: Center(child: Text('تم التسليم')),
                      ),
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
                        label: Center(child: Text('تاريخ الاستلام')),
                      ),
                      DataColumn(
                        label: Center(child: Text('الايام المتبقية')),
                      ),
                      DataColumn(
                        label: Center(child: Text('المبلغ المتبقي')),
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
  buildCardMobile(ProductCubit data, BuildContext context) {
    bool isSub=false;

    var productList =   data.productsModelList.where((element) => element.isDelliverd==true).toList();

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
                          hoverDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red.withOpacity(0.8),
                          ),
                          margin: EdgeInsets.only(left: 5, right: 5),
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffBCEFC2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.home,
                                size: 18,
                              ),
                              Text(
                                "الصفحة الرئيسية",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => DeliveryListScreen()));
                        },
                        child: HoverAnimatedContainer(
                          hoverWidth: 100,
                          height: 50,
                          hoverDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red.withOpacity(0.8),
                          ),
                          margin: EdgeInsets.only(left: 5, right: 5),
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffBCEFC2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/clock.png",
                                height: 20,
                              ),
                              Text(
                                "  قوائم التسليم ",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => AddInvoiceScreen()));
                        },
                        child: HoverAnimatedContainer(
                          hoverWidth: 100,
                          height: 50,
                          hoverDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red.withOpacity(0.8),
                          ),
                          margin: EdgeInsets.only(left: 5, right: 5),
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffBCEFC2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/report.png",
                                height: 25,
                              ),
                              Text(
                                "  اضافة فاتورة",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
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
                        "قائمة الفواتير المستلمة",
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
                        "images/delivered.png",
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
                              searchCode(val, productList);
                            });
                          } else {
                            setState(() {
                              search(val, productList);
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
            Row(
              children: [
                Container(
                  height:50,
                  width: 120,
                  padding: const EdgeInsets.all(8.0),

                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(accentCanvasColor)),
                    onPressed: (){
                      if(productModelList.isNotEmpty){
                        print(productModelList[0].isDelliverd);

                        ProductCubit().updateProduct(context,productModelList[0]);
                      }



                      print(productModelList);
                    }, child: Row(
                    children: [
                      Text("تأكيد ",style: TextStyle(color: Colors.white),),
                      Icon(Icons.check,color: Colors.white,),

                    ],
                  ),),
                ),
                Spacer(),

              ],
            ),

            Expanded(
                child: productsSearchList.isEmpty
                    ? searchController.text.isEmpty
                    ? ListView.builder(
                    itemBuilder: (context, index) {
                      bool isSub=productList[index].isDelliverd??false;
                      print(isSub);
                      var deliveryDate = DateFormat("yyyy/MM/dd").format(
                          DateTime.parse(productList[index].deliveryTime!));
                      var date = DateFormat("yyyy/MM/dd").format(
                          DateTime.parse(productList[index].deliveryTime!));
                      var dateD=   DateTime.now().difference(DateTime.parse(productList[index].deliveryTime!)).abs();

                      return  Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: dateD.inDays==1?Colors.red:Colors.white.withOpacity(0.9)),
                        child: ListTile(
                      leading: Image.asset("images/receipt.png"),

                      title:
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("تم التسليم :",style: TextStyle(fontSize: 20),),
                                  StatefulBuilder(
                                      builder: (context,setState) {
                                        return Checkbox(value: isSub, onChanged: (bool? value) {
                                          var product=productList[index];
                                          setState(() {
                                            product.isDelliverd=value!;
                                            productModelList.add(product);


                                            isSub =value;
                                          });
                                        },);
                                      }
                                  )
                                ],),
                              Divider(),
                              Text(
                                "رقم الفاتورة: ${productList[index].code.toString()} ",
                                style: TextStyle(fontSize: 16),
                              ),

                              Text("الايام المتبقية: ${dateD.inDays} ",
                                  style: TextStyle(fontSize: 16)),
                              Text("تاريخ الاستلام: ${date} ",
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                  "هاتف العميل: ${productList[index].phone.toString()} ",
                                  style: TextStyle(fontSize: 16)),


                              Text(
                                  "الاسم: ${productList[index].name.toString()} ",
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                  "المبلغ المتبقي : ${productList[index].remainingAmount.toString()} ",
                                  style: TextStyle(fontSize: 16)),

                              Text(
                                  "نوع التفصيل: ${productList[index].type.toString()} ",
                                  style: TextStyle(fontSize: 16)),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      data.deleteProduct(productList[index].sId
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
                                          productList[index], null);

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
                    itemCount: productList.length
                ):SizedBox(
                  height: 300,
                  child: EmptyWidget(
                    image:"images/rb_1188.png",
                    title: "لا يوجد فواتير", subTitle: '',
                  ),
                ):ListView.builder(
                    itemBuilder: (context, index) {
                      bool isSub=productsSearchList[index].isDelliverd??false;

                      var deliveryDate = DateFormat("yyyy/MM/dd").format(
                          DateTime.parse(productsSearchList[index].deliveryTime!));
                      var date = DateFormat("yyyy/MM/dd").format(
                          DateTime.parse(productsSearchList[index].date!));
                      var dateD=   DateTime.now().difference(DateTime.parse(productsSearchList[index].deliveryTime!)).abs();


                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: dateD.inDays==1?Colors.red:Colors.white.withOpacity(0.9)),
                        child: ListTile(
                      leading: Image.asset("images/receipt.png"),

                      title:
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("تم التسليم :",style: TextStyle(fontSize: 20),),
                                  StatefulBuilder(
                                      builder: (context,setState) {
                                        return Checkbox(value: isSub, onChanged: (bool? value) {
                                          var product=data.productsModelList[index];
                                          setState(() {
                                            product.isDelliverd=value!;
                                            productModelList.add(product);


                                            isSub =value;
                                          });
                                        },);
                                      }
                                  )
                                ],),
                              Divider(),
                              Text(
                                "رقم الفاتورة: ${productsSearchList[index].code.toString()} ",
                                style: TextStyle(fontSize: 16),
                              ),


                              Text("الايام المتبقية: ${dateD.inDays} ",
                                  style: TextStyle(fontSize: 16)),
                              Text("تاريخ الاستلام: ${date} ",
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                  "هاتف العميل: ${productsSearchList[index].phone.toString()} ",
                                  style: TextStyle(fontSize: 16)),

                              Text(
                                  "الاسم: ${productsSearchList[index].name.toString()} ",
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                  "المبلغ المتبقي : ${productsSearchList[index].remainingAmount.toString()} ",
                                  style: TextStyle(fontSize: 16)),

                              Text(
                                  "نوع التفصيل: ${productList[index].type.toString()} ",
                                  style: TextStyle(fontSize: 16)),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      data.deleteProduct(productsSearchList[index].sId
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

  DataRow buildDataRow(String deliveryDate,DateTime dateTime,int index, ProductCubit data, String date,
      var productsModelList, String time, BuildContext context) {
    print(productsModelList.isDelliverd);
    bool isSub=productsModelList.isDelliverd??false;
    var dateD=   DateTime.now().difference(dateTime);
    return DataRow(
        color: dateD.inDays.abs()==1?MaterialStatePropertyAll(Colors.redAccent):MaterialStatePropertyAll(Colors.white.withOpacity(0.9)),

        cells: [
          DataCell(Center(child: StatefulBuilder(
              builder: (context,setState) {
                return Checkbox(value: isSub, onChanged: (bool? value) {
                  var product=productsModelList;
                  setState(() {
                    product.isDelliverd=value!;
                    productModelList.add(product);


                    isSub =value;
                  });
                },);
              }
          )),onTapDown: (t){
          }),
          DataCell(Center(child: Text(productsModelList.code.toString())),onTapDown: (t){
            t.localPosition.distance;
          }),
          DataCell(Center(child: Text(productsModelList.name!))),
          DataCell(Center(child: Text(productsModelList.phone!))),
          DataCell(Center(child: Text("${deliveryDate}"))),

          DataCell(Center(child: Text("${dateD.inDays.abs()} ايام "))),

          DataCell(Center(child: Text(productsModelList.prize.toString()))),
          DataCell(Center(
            child: IconButton(
                onPressed: () async {
                  final pdfFile =
                  await PdfInvoiceApi.generate2(productsModelList, null);

                  // opening the pdf file
                  FileHandleApi.openFile(pdfFile);
                },
                icon: Icon(Icons.print,color: accentCanvasColor,)),
          )),
          DataCell(Center(
            child: IconButton(
                onPressed: () {
                  data.deleteProduct(productsModelList.sId.toString());
                },
                icon: Icon(Icons.delete,color:dateD.inDays.abs()==1?accentCanvasColor :Colors.red,)),
          )),
        ]);
  }
}
