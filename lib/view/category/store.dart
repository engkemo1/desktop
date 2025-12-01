import 'dart:ui' as ui;
import 'package:desktop_app/Model/category_model.dart';
import 'package:desktop_app/constants.dart';
import 'package:desktop_app/view/category/add_category.dart';
import 'package:desktop_app/view/screens/home_screen.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hovering/hovering.dart';
import '../empty_widget.dart';
import '../screens/main_screen.dart';
import '../widgets/customTextField.dart';

class Store extends StatefulWidget {
  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController typeController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  TextEditingController prizeController = TextEditingController();

  TextEditingController remainingAmountController = TextEditingController();

  var searchController = TextEditingController();

  List<CategoryModel> categorySearchList = [];

  void search(var searchName, var list) {
    searchName = searchName.toLowerCase();
    categorySearchList = list.where((search) {
      var searchTitle = search.type!.toString().toLowerCase();
      print(searchTitle.contains(searchName));
      return searchTitle.contains(searchName);
    }).toList();

    if (searchName == "") {
      categorySearchList.clear();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var isSmallScreen = MediaQuery
        .of(context)
        .size
        .width < 700;

    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) =>
          ProductCubit()
            ..getDataCategory(),
          child: BlocConsumer<ProductCubit, ProductsMainState>(
              listener: (BuildContext context, state) async {
                if (state is GetCategoryLoadingState) {
                  SmartDialog.showLoading();
                  await Future.delayed(Duration(seconds: 2));
                  SmartDialog.dismiss();
                }
              }, builder: (BuildContext context, state) {
            var data = ProductCubit.get(context);
      
            return state is GetCategoryLoadingState
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : data.categoryList.isEmpty
                ? Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: EmptyWidget(
                // Image from project assets
                image:"images/rb_1188.png",
                title: 'لا يوجد اصناف',
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
                    ? buildCardMobile(data, context, isSmallScreen)
                    : buildCardDesktop(data, context, isSmallScreen));
          }),
        ),
      ),
    );
  }

  buildCardDesktop(ProductCubit data, BuildContext context, var isSmallScreen) {
    return Container(

      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login.jpg",), fit: BoxFit.cover,)),
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
                        Navigator.push(context, MaterialPageRoute(builder: (
                            _) => MainScreen(index: 0,)));
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
                                  fontSize: 18, fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'بيانات القماش',
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
                          "images/fabric-pattern.png",
                          height: 70,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            _) => AddCategory()));
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
                            Image.asset("images/fabric-pattern.png",
                              height: 30,),
                            Text(
                              "  اضافة قماش ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold
                              ),
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
                      setState(() {
                        search(val, data.categoryList);
                      });
                    },
                    hintText: 'ابحث عن نوع قماش',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: categorySearchList.isEmpty
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
                    data.categoryList.length,
                        (index) {
                      return buildDataRow(
                          index,
                          data,
                          data.categoryList[index],
                          context,
                          isSmallScreen);
                    },
                  ),
                  columns: const [
                    DataColumn(
                      label: Center(child: Text('كود ')),
                    ),
                    DataColumn(
                      label: Center(child: Text('النوع')),
                    ),
                    DataColumn(
                      label: Center(child: Text('الكمية')),
                    ),

                    DataColumn(
                      label: Center(child: Text('السعر')),
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
                    categorySearchList.length,
                        (index) {
                      return buildDataRow(index, data,
                          categorySearchList[index], context, isSmallScreen);
                    },
                  ),
                  columns: const [
                    DataColumn(
                      label: Center(child: Text('كود ')),
                    ),
                    DataColumn(
                      label: Center(child: Text('النوع')),
                    ),
                    DataColumn(
                      label: Center(child: Text('الكمية')),
                    ),

                    DataColumn(
                      label: Center(child: Text('السعر')),
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
          ),
        ],
      ),
    );
  }

  buildCardMobile(ProductCubit data, BuildContext context, var isSmallScreen) {
    return Container(

      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login.jpg",), fit: BoxFit.cover,)),
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
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) => HomeScreen()));
                  },
                  child: HoverAnimatedContainer(
                    hoverWidth: 140,
                    hoverDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.withOpacity(0.8),
                    ),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: 130,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffBCEFC2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5,),

                        Image.asset("images/home-button.png", height: 25,),
                        Text(
                          "الصفحة الرئيسية",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AddCategory()));
                  },
                  child: HoverAnimatedContainer(
                    hoverWidth: 140,
                    hoverDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.withOpacity(0.8),
                    ),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: 130,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffBCEFC2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5,),
                        Image.asset("images/fabric-pattern.png",
                          height: 25,),
                        Text(
                          "  اضافة قماش ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'بيانات القماش',
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
                  "images/fabric-pattern.png",
                  height: 50,
                ),
              ],
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: CustomTextField(

                  controller: searchController,
                  prefix: Icon(Icons.search),
                  onChanged: (val) {
                    setState(() {
                      search(val, data.categoryList);
                    });
                  },
                  hintText: 'ابحث عن نوع قماش',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),

      Expanded(
        child: categorySearchList.isEmpty
            ? searchController.text.isEmpty
            ?  ListView.builder(
          itemCount: data.categoryList.length,
          itemBuilder: (context,index) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.9))
              , child: ListTile(
              leading: Image.asset("images/fabric-pattern.png",height: 30,)
              ,
              trailing: IconButton(
                  onPressed: () {
                    SmartDialog.show(
                        backDismiss: true,
                        onDismiss: () {},
                        builder: (context) {
                          return Container(
                            margin: EdgeInsets.only(left: 20,right: 20,top: 70,bottom: 70),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: accentCanvasColor.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Directionality(
                                textDirection: ui.TextDirection.rtl,
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset("images/fabric-pattern.png",
                                                height: 100,),
                                              const Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'بيانات الصنف',
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 30,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: isSmallScreen ? null : 400,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      const Text(
                                                        'النوع',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 18,
                                                            color: Colors.white),
                                                      ),
                                                      CustomTextField(
                                                        suffix: Icon(Icons.category),
                                                        controller: typeController
                                                          ..text = data.categoryList[index]
                                                              .type!,
                                                        isFormField: true,
                                                        hintText: 'ادخل النوع ',
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
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      const Text(
                                                        'الكمية',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 18,
                                                            color: Colors.white),
                                                      ),
                                                      CustomTextField(
                                                        suffix:
                                                        Icon(Icons
                                                            .production_quantity_limits),
                                                        controller: quantityController
                                                          ..text = data.categoryList[index]
                                                              .quantity.toString(),
                                                        isPhoneNumber: true,
                                                        textInputType: TextInputType
                                                            .number,
                                                        hintText: 'ادخل الكمية',
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
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      const Text(
                                                        'سعر المتر',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 18,
                                                            color: Colors.white),
                                                      ),
                                                      CustomTextField(
                                                        suffix: Icon(Icons.money),
                                                        controller: priceController
                                                          ..text = data.categoryList[index]
                                                              .price.toString(),
                                                        textInputType: TextInputType
                                                            .number,
                                                        isFormField: true,
                                                        hintText: 'ادخل سعر المتر ',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                  width: 150,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      var category = CategoryModel(
                                                          type:
                                                          typeController.text,
                                                          price:
                                                          priceController.text,

                                                          quantity:
                                                          quantityController
                                                              .text);

                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        data.
                                                        UpdateCategory(
                                                            context,
                                                            category,
                                                            data.categoryList[index]
                                                                .sId!)
                                                            .then((value) {
                                                          data.getDataCategory();
                                                          Navigator.of(context);
                                                        });
                                                      }
                                                    },
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                        MaterialStateProperty.all(
                                                            backgroundColor)),
                                                    child: const Text(
                                                      'تحديث',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ));
                        });
                  },
                  icon: Icon(Icons.menu)),
              subtitle: Text("الكمية: ${data.categoryList[index].quantity}") ,

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("النوع: ${data.categoryList[index].type}")
                ],
              ),
            ),);
          }
        ):SizedBox(
          height: 300,
          child: EmptyWidget(
            image:"images/rb_1188.png",
            title: "لا يوجد فواتير", subTitle: '',
          ),
        )
            :  ListView.builder(
            itemCount: categorySearchList.length,
            itemBuilder: (context,index) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.9))
                , child: ListTile(
                leading: Image.asset("images/fabric-pattern.png",height: 30,)
                ,
                trailing: IconButton(
                    onPressed: () {
                      SmartDialog.show(
                          backDismiss: true,
                          onDismiss: () {},
                          builder: (context) {
                            return Container(
                                margin: EdgeInsets.only(left: 20,right: 20,top: 70,bottom: 70),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: accentCanvasColor.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Directionality(
                                  textDirection: ui.TextDirection.rtl,
                                  child: Center(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset("images/fabric-pattern.png",
                                                  height: 100,),
                                                const Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'بيانات الصنف',
                                                      style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 30,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: isSmallScreen ? null : 400,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                          'النوع',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              fontSize: 18,
                                                              color: Colors.white),
                                                        ),
                                                        CustomTextField(
                                                          suffix: Icon(Icons.category),
                                                          controller: typeController
                                                            ..text = categorySearchList[index]
                                                                .type!,
                                                          isFormField: true,
                                                          hintText: 'ادخل النوع ',
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
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                          'الكمية',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              fontSize: 18,
                                                              color: Colors.white),
                                                        ),
                                                        CustomTextField(
                                                          suffix:
                                                          Icon(Icons
                                                              .production_quantity_limits),
                                                          controller: quantityController
                                                            ..text = categorySearchList[index]
                                                                .quantity.toString(),
                                                          isPhoneNumber: true,
                                                          textInputType: TextInputType
                                                              .number,
                                                          hintText: 'ادخل الكمية',
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
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                          'سعر المتر',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              fontSize: 18,
                                                              color: Colors.white),
                                                        ),
                                                        CustomTextField(
                                                          suffix: Icon(Icons.money),
                                                          controller: priceController
                                                            ..text = categorySearchList[index]
                                                                .price.toString(),
                                                          textInputType: TextInputType
                                                              .number,
                                                          isFormField: true,
                                                          hintText: 'ادخل سعر المتر ',
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                    width: 150,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        var category = CategoryModel(
                                                            type:
                                                            typeController.text,
                                                            price:
                                                            priceController.text,

                                                            quantity:
                                                            quantityController
                                                                .text);

                                                        if (_formKey.currentState!
                                                            .validate()) {
                                                          data.
                                                          UpdateCategory(
                                                              context,
                                                              category,
                                                              categorySearchList[index]
                                                                  .sId!)
                                                              .then((value) {
                                                            data.getDataCategory();
                                                            Navigator.of(context);
                                                          });
                                                        }
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                          MaterialStateProperty.all(
                                                              backgroundColor)),
                                                      child: const Text(
                                                        'تحديث',
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ));
                          });
                    },
                    icon: Icon(Icons.menu)),
                subtitle: Text("الكمية: ${categorySearchList[index].quantity}") ,

                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("النوع: ${categorySearchList[index].type}")
                  ],
                ),
              ),);
            }
        )),
        ],
      ),
    );
  }

  DataRow buildDataRow(int index, ProductCubit data, var categoryModelList,
      BuildContext context, var isSmallScreen) {
    return DataRow(cells: [
      DataCell(Center(child: Text(index.toString()))),

      DataCell(Center(child: Text(categoryModelList.type ?? ''))),
      DataCell(Center(child: Text(categoryModelList.quantity.toString()!))),
      DataCell(Center(child: Text(categoryModelList.price.toString()!))),


      DataCell(Center(
        child: IconButton(
            onPressed: () {
              SmartDialog.show(
                  backDismiss: true,
                  onDismiss: () {},
                  builder: (context) {
                    return Container(
                        padding: EdgeInsets.all(20),
                        width: isSmallScreen ? 200 : 600,
                        height: isSmallScreen ? 200 : 600,
                        decoration: BoxDecoration(
                          color: accentCanvasColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Directionality(
                          textDirection: ui.TextDirection.rtl,
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Image.asset("images/fabric-pattern.png",
                                          height: 100,),
                                        const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'بيانات الصنف',
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 30,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: isSmallScreen ? null : 400,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                const Text(
                                                  'النوع',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w500,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                CustomTextField(
                                                  suffix: Icon(Icons.category),
                                                  controller: typeController
                                                    ..text = categoryModelList
                                                        .type,
                                                  isFormField: true,
                                                  hintText: 'ادخل النوع ',
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
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                const Text(
                                                  'الكمية',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w500,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                CustomTextField(
                                                  suffix:
                                                  Icon(Icons
                                                      .production_quantity_limits),
                                                  controller: quantityController
                                                    ..text = categoryModelList
                                                        .quantity.toString(),
                                                  isPhoneNumber: true,
                                                  textInputType: TextInputType
                                                      .number,
                                                  hintText: 'ادخل الكمية',
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
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                const Text(
                                                  'سعر المتر',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w500,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                CustomTextField(
                                                  suffix: Icon(Icons.money),
                                                  controller: priceController
                                                    ..text = categoryModelList
                                                        .price.toString(),
                                                  textInputType: TextInputType
                                                      .number,
                                                  isFormField: true,
                                                  hintText: 'ادخل سعر المتر ',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                            width: 150,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                var category = CategoryModel(
                                                    type:
                                                    typeController.text,
                                                    price:
                                                    priceController.text,

                                                    quantity:
                                                    quantityController
                                                        .text);

                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  data.
                                                  UpdateCategory(
                                                      context,
                                                      category,
                                                      categoryModelList
                                                          .sId!)
                                                      .then((value) {
                                                    data.getDataCategory();
                                                    Navigator.of(context);
                                                  });
                                                }
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                      backgroundColor)),
                                              child: const Text(
                                                'تحديث',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ))
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ));
                  });
            },
            icon: Icon(Icons.update)),
      )),
      DataCell(
          Center(child: IconButton(
              onPressed: () {
                data.deleteCategory(categoryModelList.sId.toString());
              },
              icon: Icon(Icons.delete, color: Colors.red,)),
          )),
    ]);
  }


}
