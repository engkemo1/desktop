import 'dart:ui' as ui;
import 'package:collection/collection.dart';
import 'package:desktop_app/Model/category_model.dart';
import 'package:desktop_app/view/category/store.dart';
import 'package:desktop_app/view_model/cubit/customer_cubit/customer_state.dart';
import 'package:desktop_app/view_model/cubit/customer_cubit/customers_cubit.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hovering/hovering.dart';
import 'package:toast/toast.dart';

import '../../../Model/customer_model.dart';
import '../../../Model/products_model.dart';
import '../../../constants.dart';
import '../screens/main_screen.dart';
import '../widgets/customTextField.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var isSmallScreen = MediaQuery.of(context).size.width < 700;

    return SafeArea(
      child: Scaffold(
        body:isSmallScreen? Mobile():Desktop(),
      ),
    );
  }

  Directionality Desktop() {
    var width = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "images/login.jpg",
          ),
          fit: BoxFit.cover,
        )),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  color: accentCanvasColor.withOpacity(0.9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "اضافة نوع جديد قماش",
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Store(
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
                                    "images/store.png",
                                    height: 30,
                                  ),
                                  Text(
                                    " الى المخزن",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: accentCanvasColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          width: isSmallScreen ? null : 400,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'النوع',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                CustomTextField(
                                  suffix: Icon(Icons.category),
                                  controller: typeController,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الكمية',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                CustomTextField(
                                  suffix:
                                      Icon(Icons.production_quantity_limits),
                                  controller: quantityController,
                                  isPhoneNumber: true,
                                  textInputType: TextInputType.number,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'سعر المتر',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                CustomTextField(
                                  suffix: Icon(Icons.money),
                                  controller: priceController,
                                  textInputType: TextInputType.number,
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
                        SizedBox(
                            width: 150,
                            child: BlocProvider(
                                create: (context) => ProductCubit(),
                                child: BlocConsumer<ProductCubit,
                                        ProductsMainState>(
                                    listener:
                                        (BuildContext context, state) async {
                                  if (state is AddCategoryLoadingState) {
                                    SmartDialog.showLoading();
                                    await Future.delayed(Duration(seconds: 2));
                                    SmartDialog.dismiss();
                                  }
                                }, builder: (BuildContext context, state) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      ToastContext().init(context);

                                      var category = CategoryModel(
                                        type: typeController.text,
                                        price:
                                            priceController.text,
                                        quantity:
                                            quantityController.text,
                                      );

                                      if (_formKey.currentState!.validate()) {
                                            ProductCubit.get(context)
                                                .postCategory(context, category)
                                                .then((value) {
                                              typeController.clear();
                                              priceController.clear();
                                              quantityController.clear();
                                            });
                                          }

                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xff27D8D8))),
                                    child: const Text(
                                      'اضافة',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                })))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   Mobile() {
    var width = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "images/login.jpg",
              ),
              fit: BoxFit.cover,
            )),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  color: accentCanvasColor.withOpacity(0.9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
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
                              hoverWidth: 120,
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
                                  SizedBox(width: 10,),

                                  Image.asset("images/home-button.png",height: 20,),
                                  Text(
                                    "الصفحة الرئيسية",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
                                      builder: (_) => Store(
                                      )));
                            },
                            child: HoverAnimatedContainer(
                              hoverWidth: 140,
                              hoverDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red.withOpacity(0.8),
                              ),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: 130,height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBCEFC2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10,),
                                  Image.asset(
                                    "images/store.png",
                                    height: 20,
                                  ),
                                  Text(
                                    " الى المخزن",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
                            "اضافة نوع جديد قماش",
                            style: TextStyle(
                                fontSize: 30,
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

                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: accentCanvasColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          width: isSmallScreen ? null : 400,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'النوع',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                CustomTextField(
                                  suffix: Icon(Icons.category),
                                  controller: typeController,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الكمية',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                CustomTextField(
                                  suffix:
                                  Icon(Icons.production_quantity_limits),
                                  controller: quantityController,
                                  isPhoneNumber: true,
                                  textInputType: TextInputType.number,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'سعر المتر',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                CustomTextField(
                                  suffix: Icon(Icons.money),
                                  controller: priceController,
                                  textInputType: TextInputType.number,
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
                        SizedBox(
                            width: 150,
                            child: BlocProvider(
                                create: (context) => ProductCubit(),
                                child: BlocConsumer<ProductCubit,
                                    ProductsMainState>(
                                    listener:
                                        (BuildContext context, state) async {
                                      if (state is AddCategoryLoadingState) {
                                        SmartDialog.showLoading();
                                        await Future.delayed(Duration(seconds: 2));
                                        SmartDialog.dismiss();
                                      }
                                    }, builder: (BuildContext context, state) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      ToastContext().init(context);

                                      var category = CategoryModel(
                                        type: typeController.text,
                                        price:
                                        priceController.text,
                                        quantity:
                                        quantityController.text,
                                      );

                                      if (_formKey.currentState!.validate()) {
                                        ProductCubit.get(context)
                                            .postCategory(context, category)
                                            .then((value) {
                                          typeController.clear();
                                          priceController.clear();
                                          quantityController.clear();
                                        });
                                      }

                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Color(0xff27D8D8))),
                                    child: const Text(
                                      'اضافة',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                })))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
