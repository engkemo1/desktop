import 'dart:ui' as ui;
import 'package:collection/collection.dart';
import 'package:desktop_app/constants.dart';
import 'package:desktop_app/view/screens/pdf_invoice/file_handeler.dart';
import 'package:desktop_app/view/screens/pdf_invoice/pdf.dart';
import 'package:desktop_app/view_model/cubit/customer_cubit/customers_cubit.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hovering/hovering.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../../Model/customer_model.dart';
import '../../../view_model/cubit/customer_cubit/customer_state.dart';
import '../../widgets/customTextField.dart';
import '../main_screen.dart';

class CustomerScreen extends StatefulWidget {
  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController prizeController = TextEditingController();

  TextEditingController remainingAmountController = TextEditingController();
  TextEditingController chestLengthController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController kLengthController = TextEditingController();
  TextEditingController ketfLengthController = TextEditingController();
  TextEditingController komLengthController = TextEditingController();
  TextEditingController handLengthController = TextEditingController();
  TextEditingController customerAmountController = TextEditingController();

  TextEditingController codeController = TextEditingController();
  var searchController = TextEditingController();

  List<Customer> customerSearchList = [];

  void search(var searchName, var list) {
    searchName = searchName.toLowerCase();
    customerSearchList = list.where((search) {
      var searchTitle = search.userName!.toString().toLowerCase();
      print(searchTitle.contains(searchName));
      return searchTitle.contains(searchName);
    }).toList();

    if (searchName == "") {
      customerSearchList.clear();
    } else {}
  }
  void searchCode(var code, var list) {
    code = code.toLowerCase();
    customerSearchList = list.where((search) {
      var searchTitle = search.code!.toString().toLowerCase();
      print(searchTitle.contains(code));
      return searchTitle.contains(code);
    }).toList();

    if (code == "") {
      customerSearchList.clear();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      body: BlocProvider(
        create: (context) => CustomersCubit()..getData(),
        child: BlocConsumer<CustomersCubit, CustomersMainState>(
            listener: (BuildContext context, state) async {
          if (state is GetCustomersLoadingState) {
            SmartDialog.showLoading();
            await Future.delayed(Duration(seconds: 2));
            SmartDialog.dismiss();
          }
        }, builder: (BuildContext context, state) {
          var data = CustomersCubit.get(context);

          return state is GetCustomersLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : data.customerModelList.isEmpty
                  ? Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: EmptyWidget(
                        // Image from project assets
                        image: null,
                        packageImage: PackageImage.Image_3,
                        title: 'No Customers',
                        subTitle: 'No  Customers available yet',
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
                    )
                  : Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: isSmallScreen
                          ? Column(children: [
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                "العملاء",
                                style: TextStyle(fontSize: 25),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(),
                              SizedBox(
                                height: 50,
                                child: CustomTextField(
                                  controller: searchController,
                                  prefix: Icon(Icons.search),
                                  onChanged: (val) {
                                    var result = int.tryParse(searchController.text);
                                    if (result != null) {
                                      setState(() {
                                        searchCode(val, data.customerModelList);
                                      });
                                    } else {
                                      setState(() {
                                        search(val, data.customerModelList);
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
                                        customerSearchList.clear();
                                      });
                                    },
                                  ),
                                  hintText: '  ',
                                ),
                              ),
                              Expanded(
                                child: customerSearchList.isEmpty
                                    ? searchController.text.isEmpty
                                        ? ListView.builder(
                                            itemCount:
                                                data.customerModelList.length,
                                            itemBuilder: (context, index) {
                                              return buildCard(
                                                  data,
                                                  isSmallScreen,
                                                  data.customerModelList[
                                                      index]);
                                            })
                                        : SizedBox(
                                            height: 300,
                                            child: EmptyWidget(
                                              packageImage:
                                                  PackageImage.Image_2,
                                              title: "لا يوجد عملاء",
                                            ),
                                          )
                                    : ListView.builder(
                                        itemCount: customerSearchList.length,
                                        itemBuilder: (context, index) {
                                          return buildCard(data, isSmallScreen,
                                              customerSearchList[index]);
                                        }),
                              ),
                            ])
                          : buildCardDesktop(data, context, isSmallScreen));
        }),
      ),
    );
  }

  buildCardDesktop(
      CustomersCubit data, BuildContext context, var isSmallScreen) {
    print(data.customerModelList);
    return Column(
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
                        "العملاء",
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
                        "images/man.png",
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
                          Image.asset(
                            "images/user.png",
                            height: 30,
                          ),
                          Text(
                            "  اضافة عميل ",
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: CustomTextField(
                  controller: searchController,
                  prefix: Icon(Icons.search),
                  onChanged: (val) {
                    var result = int.tryParse(searchController.text);
                    if (result != null) {
                      setState(() {
                        searchCode(val, data.customerModelList);
                      });
                    } else {
                      setState(() {
                        search(val, data.customerModelList);
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
                        customerSearchList.clear();
                      });
                    },
                  ),
                  hintText: 'ابحث عن عميل',
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "images/login.jpg",
              ),
              fit: BoxFit.cover,
            )),
            padding: EdgeInsets.all(20),
            child: customerSearchList.isEmpty
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
                          data.customerModelList.length,
                          (index) {
                            return buildDataRow(
                                index,
                                data,
                                data.customerModelList[index],
                                context,
                                isSmallScreen);
                          },
                        ),
                        columns: const [
                          DataColumn(
                            label: Center(child: Text('كود العميل')),
                          ),
                          DataColumn(
                            label: Center(child: Text('الاسم')),
                          ),
                          DataColumn(
                            label: Center(child: Text('رقم الهاتف')),
                          ),
                          DataColumn(
                            label: Center(child: Text('العنوان')),
                          ),
                          DataColumn(
                            label: Center(child: Text('عليه')),
                          ),
                          DataColumn(
                            label: Center(child: Text('له')),
                          ),
                          DataColumn(
                            label: Center(child: Text('تحديث')),
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
                      customerSearchList.length,
                      (index) {
                        return buildDataRow(index, data,
                            customerSearchList[index], context, isSmallScreen);
                      },
                    ),
                    columns: const [
                      DataColumn(
                        label: Center(child: Text('كود العميل')),
                      ),
                      DataColumn(
                        label: Center(child: Text('الاسم')),
                      ),
                      DataColumn(
                        label: Center(child: Text('رقم الهاتف')),
                      ),
                      DataColumn(
                        label: Center(child: Text('العنوان')),
                      ),
                      DataColumn(
                        label: Center(child: Text('عليه')),
                      ),
                      DataColumn(
                        label: Center(child: Text('له')),
                      ),
                      DataColumn(
                        label: Center(child: Text('تحديث')),
                      ),
                      DataColumn(
                        label: Center(child: Text('حذف')),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  DataRow buildDataRow(int index, CustomersCubit data,
      Customer customerModelList, BuildContext context, var isSmallScreen) {
    return DataRow(cells: [
      DataCell(Center(child: Text(customerModelList.code??index.toString() ))),
      DataCell(Center(child: Text(customerModelList.userName ?? ''))),
      DataCell(Center(child: Text(customerModelList.phone!))),
      DataCell(Center(child: Text(customerModelList.address!))),
      DataCell(
          Center(child: Text(customerModelList.remainingAmount.toString()))),
      DataCell(
          Center(child: Text(customerModelList.customerAmount.toString()))),
      DataCell(Center(
        child: IconButton(
            onPressed: () {
              SmartDialog.show(
                  backDismiss: true,
                  onDismiss: () {},
                  builder: (context) {
                    return Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: Container(
                        width: 700,
                        height: 620,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: accentCanvasColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: backgroundColor.withOpacity(0.5)),
                                child: Icon(
                                  Icons.add_reaction,
                                  size: 70,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'تفاصيل عن العميل',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Divider()),
                                            Text(
                                              " تفاصيل العميل ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            Expanded(child: Divider())
                                          ],
                                        ),
                                        SizedBox(
                                          width: isSmallScreen ? null : 400,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'الاسم',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                CustomTextField(
                                                  controller: nameController
                                                    ..text = customerModelList
                                                        .userName
                                                        .toString(),
                                                  isFormField: true,
                                                  hintText: 'ادخل الاسم ',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isSmallScreen ? null : 400,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'رقم الهاتف',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                CustomTextField(
                                                  controller: phoneController
                                                    ..text = customerModelList
                                                        .phone!,
                                                  isPhoneNumber: true,
                                                  textInputType:
                                                      TextInputType.phone,
                                                  hintText: 'ادخل رقم الهاتف',
                                                  isFormField: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'كود العميل',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                    CustomTextField(
                                                      controller: codeController
                                                        ..text =
                                                            customerModelList
                                                                .code!,
                                                      isFormField: true,
                                                      textInputType:
                                                          TextInputType.number,
                                                      hintText:
                                                          'ادخل كود العميل ',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'العنوان',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                    CustomTextField(
                                                      controller:
                                                          addressController
                                                            ..text =
                                                                customerModelList
                                                                    .address!,
                                                      textInputType:
                                                          TextInputType
                                                              .streetAddress,
                                                      isFormField: true,
                                                      hintText: 'ادخل العنوان ',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white,
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Divider()),
                                            Text(
                                              "المقاسات ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            Expanded(child: Divider())
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'الطول',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  CustomTextField(
                                                    isValidator: false,
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    controller: lengthController
                                                      ..text =  customerModelList
                                                          .length==null?"0":customerModelList
                                                          .length
                                                          .toString(),
                                                    textInputType:
                                                        TextInputType.number,
                                                    hintText: 'ادخل الطول',
                                                    isFormField: true,
                                                  ),
                                                ],
                                              ),
                                            )),
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'الكتف',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  CustomTextField(
                                                    isValidator: false,
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    controller: ketfLengthController
                                                      ..text = customerModelList
                                                                  .ketfLength ==
                                                              null
                                                          ? "0"
                                                          : customerModelList
                                                              .ketfLength
                                                              .toString(),
                                                    textInputType:
                                                        TextInputType.number,
                                                    hintText: 'ادخل الطول',
                                                    isFormField: true,
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'طول الكم',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  CustomTextField(
                                                    isValidator: false,
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    controller: komLengthController
                                                      ..text = customerModelList
                                                                  .komLength ==
                                                              null
                                                          ? "0"
                                                          : customerModelList
                                                              .komLength
                                                              .toString(),
                                                    textInputType:
                                                        TextInputType.number,
                                                    hintText: 'ادخل الطول',
                                                    isFormField: true,
                                                  ),
                                                ],
                                              ),
                                            )),
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'وسع الصدر',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  CustomTextField(
                                                    isValidator: false,
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    controller: chestLengthController
                                                      ..text = customerModelList
                                                                  .sadrLength ==
                                                              null
                                                          ? "0"
                                                          : customerModelList
                                                              .sadrLength
                                                              .toString(),
                                                    textInputType:
                                                        TextInputType.number,
                                                    isFormField: true,
                                                    hintText:
                                                        ' ادخل وسع الصدر ',
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'الرقبة',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  CustomTextField(
                                                    isValidator: false,
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    controller: neckController
                                                      ..text = customerModelList
                                                                  .neckLength ==
                                                              null
                                                          ? "0"
                                                          : customerModelList
                                                              .neckLength
                                                              .toString(),
                                                    textInputType:
                                                        TextInputType.number,
                                                    hintText: 'الرقبة',
                                                    isFormField: true,
                                                  ),
                                                ],
                                              ),
                                            )),
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'وسع اليد',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  CustomTextField(
                                                    isValidator: false,
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    controller: handLengthController
                                                      ..text = customerModelList
                                                                  .handLength ==
                                                              null
                                                          ? "0"
                                                          : customerModelList
                                                              .handLength
                                                              .toString(),
                                                    textInputType:
                                                        TextInputType.number,
                                                    isFormField: true,
                                                    hintText: ' ادخل وسع اليد ',
                                                  ),
                                                ],
                                              ),
                                            )),
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'طول الكبك ',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  CustomTextField(
                                                    isValidator: false,
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    controller: kLengthController
                                                      ..text = customerModelList
                                                                  .kabkLength ==
                                                              null
                                                          ? "0"
                                                          : customerModelList
                                                              .kabkLength
                                                              .toString(),
                                                    textInputType:
                                                        TextInputType.number,
                                                    hintText: 'ادخل طول الكبك',
                                                    isFormField: true,
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Text(
                                    " الدفع",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  Expanded(child: Divider())
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'له',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          CustomTextField(
                                            controller: customerAmountController
                                              ..text = customerModelList
                                                  .customerAmount
                                                  .toString()
                                                  .toString(),
                                            isFormField: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'عليه',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          CustomTextField(
                                            controller:
                                                remainingAmountController
                                                  ..text = customerModelList
                                                      .remainingAmount
                                                      .toString(),
                                            isPhoneNumber: true,
                                            textInputType: TextInputType.phone,
                                            isFormField: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: BlocProvider(
                                              create: (context) =>
                                                  CustomersCubit(),
                                              child: BlocConsumer<
                                                      CustomersCubit,
                                                      CustomersMainState>(
                                                  listener:
                                                      (BuildContext context,
                                                          state) async {
                                              }, builder: (BuildContext context,
                                                      state) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    ToastContext()
                                                        .init(context);

                                                    var customer = Customer(
                                                        code:
                                                            codeController.text,
                                                        length: lengthController
                                                            .text,
                                                        kabkLength:
                                                            kLengthController
                                                                .text,
                                                        ketfLength:
                                                            ketfLengthController
                                                                .text,
                                                        komLength:
                                                            komLengthController
                                                                .text,
                                                        neckLength:
                                                            neckController.text,
                                                        sadrLength:
                                                            chestLengthController
                                                                .text,
                                                        handLength:
                                                            handLengthController
                                                                .text,
                                                        userName:
                                                            nameController.text,
                                                        phone: phoneController
                                                            .text,
                                                        address:
                                                            addressController
                                                                .text,
                                                        customerAmount:
                                                            customerAmountController
                                                                .text,
                                                        remainingAmount: remainingAmountController.text);
                                                    print(customer.userName);

                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      data
                                                          .updateCustomer(
                                                              context,
                                                              customer,
                                                              customerModelList
                                                                  .sId
                                                                  .toString());
                                                    }
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Color(
                                                                  0xff27D8D8))),
                                                  child: const Text(
                                                    'تحديث',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                              }))),
                                    ),
                                    Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              data
                                                  .deleteCustomer(
                                                      customerModelList.sId
                                                          .toString())
                                                  .then((value) =>
                                                      Navigator.of(context));
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red)),
                                            child: const Text(
                                              'ازالة',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            icon: Icon(Icons.update)),
      )),
      DataCell(Center(
        child: IconButton(
            onPressed: () {
              data.deleteCustomer(customerModelList.sId.toString());
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      )),
    ]);
  }

  Card buildCard(CustomersCubit data, bool isSmallScreen, Customer customer) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(right: 10, bottom: 5, left: 10, top: 10),
      child: SizedBox(
        child: ListTile(
          leading: Image.asset(
            "images/man.png",
            height: 40,
          ),
          trailing: IconButton(
            icon: Icon(Icons.more_horiz_outlined),
            onPressed: () {
              SmartDialog.show(
                  backDismiss: true,
                  onDismiss: () {},
                  builder: (context) {
                    return Container(
                        padding: EdgeInsets.all(20),
                        width: 300,
                        height: 600,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Directionality(
                          textDirection: ui.TextDirection.rtl,
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "images/man.png",
                                          height: 70,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'بيانات العميل',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'الاسم',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                                CustomTextField(
                                                  controller: nameController
                                                    ..text = customer.userName!,
                                                  isFormField: true,
                                                  hintText: 'ادخل الاسم ',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'رقم الهاتف',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                                CustomTextField(
                                                  controller: phoneController
                                                    ..text = customer.phone!,
                                                  isPhoneNumber: true,
                                                  textInputType:
                                                      TextInputType.phone,
                                                  hintText: 'ادخل رقم الهاتف',
                                                  isFormField: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isSmallScreen ? null : 400,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'العنوان',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                                CustomTextField(
                                                  controller: addressController
                                                    ..text = customer.address!,
                                                  textInputType: TextInputType
                                                      .streetAddress,
                                                  isFormField: true,
                                                  hintText: 'ادخل العنوان ',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: isSmallScreen ? null : 400,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'المبلغ المديون به',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                                CustomTextField(
                                                  controller:
                                                      remainingAmountController
                                                        ..text = customer
                                                            .remainingAmount
                                                            .toString()!,
                                                  textInputType: TextInputType
                                                      .streetAddress,
                                                  isFormField: true,
                                                  hintText: 'ادخل المبلغ ',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                                width: 80,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    var customerModel = Customer(
                                                        userName:
                                                            nameController.text,
                                                        phone: phoneController
                                                            .text,
                                                        address:
                                                            addressController
                                                                .text,
                                                        remainingAmount: int.parse(
                                                            remainingAmountController
                                                                .text));

                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      data
                                                          .updateCustomer(
                                                              context,
                                                              customerModel,
                                                              customer.sId!)
                                                          .then((value) {
                                                        data.getData();
                                                      });
                                                    }
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                              accentCanvasColor)),
                                                  child: const Text(
                                                    'تحديث',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                )),
                                            SizedBox(
                                                width: 80,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    data
                                                        .deleteCustomer(customer
                                                            .sId
                                                            .toString())
                                                        .then((value) =>
                                                            Navigator.of(
                                                                context));
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.red)),
                                                  child: const Text(
                                                    'ازالة',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ));
                  });
            },
          ),
          title: Text(
            customer.userName!,
            style: TextStyle(
                fontSize: isSmallScreen ? 12 : 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "المبلغ المديون به:   ${customer.remainingAmount}     ",
            style: TextStyle(
                fontSize: isSmallScreen ? 12 : 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
