import 'dart:ui' as ui;
import 'package:collection/collection.dart';
import 'package:desktop_app/view_model/cubit/customer_cubit/customer_state.dart';
import 'package:desktop_app/view_model/cubit/customer_cubit/customers_cubit.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:toast/toast.dart';

import '../../../Model/customer_model.dart';
import '../../../Model/products_model.dart';
import '../../../constants.dart';
import '../../../random.dart';
import '../../widgets/customTextField.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  TextEditingController _dateController = TextEditingController();
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

  TextEditingController codeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Desktop(),
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 800,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: accentCanvasColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: backgroundColor.withOpacity(0.5)),
                              child: Icon(
                                Icons.add_reaction,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'اضافة عميل جديد',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                              ],
                            ),
SizedBox(height: 30,),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Expanded(child: Divider()),
                                        Text(" تفاصيل العميل ",style: TextStyle(fontSize: 15,color: Colors.white),),
                                        Expanded(child: Divider())
                                      ],),


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
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              CustomTextField(
                                                controller: nameController,
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
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              CustomTextField(
                                                controller: phoneController,
                                                isPhoneNumber: true,
                                                textInputType: TextInputType.phone,
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
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'كود العميل',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                  CustomTextField(
                                                    controller: codeController,
                                                    isFormField: true,
                                                    textInputType: TextInputType.number,
                                                    hintText: 'ادخل كود العميل ',
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
                                                    'العنوان',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                  CustomTextField(
                                                    controller: addressController,
                                                    textInputType:
                                                        TextInputType.streetAddress,
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
                                VerticalDivider(color: Colors.white,width: 20,),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Expanded(child: Divider()),
                                        Text("المقاسات ",style: TextStyle(fontSize: 15,color: Colors.white),),
                                        Expanded(child: Divider())
                                      ],),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
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
                                                      'الطول',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18),
                                                    ),
                                                    CustomTextField(                                                    isValidator:false,

                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold),
                                                      controller: lengthController,
                                                      textInputType: TextInputType.number,
                                                      hintText: 'ادخل الطول',
                                                      isFormField: true,
                                                    ),
                                                  ],
                                                ),
                                              )),
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
                                                      'الكتف',
                                                      style: TextStyle(                                                        color: Colors.white,

                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18),
                                                    ),
                                                    CustomTextField(                                                    isValidator:false,

                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold),
                                                      controller: ketfLengthController,
                                                      textInputType: TextInputType.number,
                                                      hintText: 'ادخل الطول',
                                                      isFormField: true,
                                                    ),
                                                  ],
                                                ),
                                              )),

                                        ],
                                      ),
                                      Row(children: [

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
                                                    'طول الكم',
                                                    style: TextStyle(                                                        color: Colors.white,

                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  CustomTextField(                                                    isValidator:false,

                                                    hintStyle: TextStyle(

                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold),
                                                    controller: komLengthController,
                                                    textInputType: TextInputType.number,
                                                    hintText: 'ادخل الطول',
                                                    isFormField: true,
                                                  ),
                                                ],
                                              ),
                                            )),
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
                                                    'وسع الصدر',
                                                    style: TextStyle(                                                        color: Colors.white,

                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  CustomTextField(
                                                    isValidator:false,
                                                    hintStyle: TextStyle(


                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold),
                                                    controller: chestLengthController,
                                                    textInputType: TextInputType.number,
                                                    isFormField: true,
                                                    hintText: ' ادخل وسع الصدر ',
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
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'الرقبة',
                                                      style: TextStyle(                                                        color: Colors.white,

                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18),
                                                    ),
                                                    CustomTextField(                                                    isValidator:false,

                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold),
                                                      controller: neckController,
                                                      textInputType: TextInputType.number,
                                                      hintText: 'الرقبة',
                                                      isFormField: true,
                                                    ),
                                                  ],
                                                ),
                                              )),
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
                                                      'وسع اليد',
                                                      style: TextStyle(                                                        color: Colors.white,

                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18),
                                                    ),
                                                    CustomTextField(                                                    isValidator:false,

                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold),
                                                      controller: handLengthController,
                                                      textInputType: TextInputType.number,
                                                      isFormField: true,
                                                      hintText: ' ادخل وسع اليد ',
                                                    ),
                                                  ],
                                                ),
                                              )),
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
                                                      'طول الكبك ',
                                                      style: TextStyle(                                                        color: Colors.white,

                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18),
                                                    ),
                                                    CustomTextField(                                                    isValidator:false,

                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold),
                                                      controller: kLengthController,
                                                      textInputType: TextInputType.number,
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
                              height: 20,
                            ),
                            SizedBox(
                                width: 150,
                                child: BlocProvider(
                                    create: (context) => CustomersCubit(),
                                    child: BlocConsumer<CustomersCubit,
                                            CustomersMainState>(
                                        listener: (BuildContext context,
                                            state) async {
                                      if (state
                                          is AddCustomersLoadingState) {
                                        SmartDialog.showLoading();
                                        await Future.delayed(
                                            Duration(seconds: 2));
                                        SmartDialog.dismiss();
                                      }
                                    }, builder:
                                            (BuildContext context, state) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          ToastContext().init(context);
                      
                                          var customer = Customer(
                                            code: codeController.text,
                                              length: lengthController.text,
                                              kabkLength: kLengthController.text,
                                              ketfLength: ketfLengthController.text,
                                              komLength: komLengthController.text,
                                              neckLength: neckController.text,
                                              sadrLength: chestLengthController.text,
                                              handLength: handLengthController.text,
                                              userName: nameController.text,
                                              phone: phoneController.text,
                                              address:
                                                  addressController.text,
                                              remainingAmount: 0);
                                          print(customer.userName);
                      
                                          if (_formKey.currentState!
                                              .validate()) {
                                            CustomersCubit()
                                                .getData()
                                                .then((value) {
                                              List<Customer> customerModel =
                                                  value;
                                              Customer? name = customerModel
                                                  .firstWhereOrNull(
                                                      (element) =>
                                                          element
                                                              .code ==
                                                          codeController
                                                              .text);
                                              Customer? code = customerModel
                                                  .firstWhereOrNull(
                                                      (element) =>
                                                  element
                                                      .userName ==
                                                      nameController
                                                          .text);
                      
                                              if (code != null||name!=null) {
                                                Toast.show(
                                                    "العميل موجود بالفعل اضف عميل اخر",
                                                    duration:
                                                        Toast.lengthLong,
                                                    gravity: Toast.bottom);
                                              } else {
                                                CustomersCubit.get(context)
                                                    .postCustomer(
                                                        context, customer)
                                                    .then((value) {
                                                  nameController.clear();
                                                  phoneController.clear();
                                                  addressController.clear();
                                                  codeController.clear();

                                                });
                                              }
                                            });
                                          }
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color(0xff27D8D8))),
                                        child: const Text(
                                          'اضافة',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      );
                                    })))
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
