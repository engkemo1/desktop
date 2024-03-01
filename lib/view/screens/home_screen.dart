import 'package:desktop_app/constants.dart';
import 'package:desktop_app/view/category/add_category.dart';
import 'package:desktop_app/view/category/store.dart';
import 'package:desktop_app/view/screens/delivery_list_screen.dart';
import 'package:desktop_app/view/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hovering/hovering.dart';

import '../widgets/customTextField.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff27D8D8),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "images/login.jpg",
          ),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 1000,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MainScreen(
                                    index: 1,
                                  )));
                    },
                    child: HoverAnimatedContainer(
                      hoverWidth: 220,
                      hoverHeight: 220,
                      hoverDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundColor,
                      ),
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffBCEFC2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/receipt.png",
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "الفواتير",
                            style: TextStyle(fontSize: 20),
                          )
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
                      hoverWidth: 220,
                      hoverHeight: 220,
                      hoverDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor),
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffBCEFC2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/report.png",
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            " اضافة فاتورة",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DeliveryListScreen()));
                    },
                    child: HoverAnimatedContainer(
                      hoverWidth: 220,
                      hoverHeight: 220,
                      hoverDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor),
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffBCEFC2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/clock.png",
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "قوائم التسليم",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SmartDialog.show(
                          backDismiss: true,
                          onDismiss: () {},
                          builder: (ctx) {
                            return Container(
                                padding: EdgeInsets.all(10),
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Stack(
                                    children: [

                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            MainScreen(
                                                              index: 4,
                                                            )));
                                              },
                                              child: HoverAnimatedContainer(
                                                  hoverWidth: 250,
                                                  hoverHeight: 60,
                                                  hoverDecoration:
                                                      BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              backgroundColor),
                                                  margin: EdgeInsets.all(20),
                                                  height: 50,
                                                  width: 230,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: accentCanvasColor,
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "images/man.png",
                                                          height: 30,
                                                        ),
                                                        Text(
                                                          'جميع عملائي',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            MainScreen(
                                                              index: 3,
                                                            )));
                                              },
                                              child: HoverAnimatedContainer(
                                                  hoverWidth: 250,
                                                  hoverHeight: 60,
                                                  hoverDecoration:
                                                      BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              backgroundColor),
                                                  margin: EdgeInsets.all(20),
                                                  height: 50,
                                                  width: 230,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: accentCanvasColor,
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "images/user.png",
                                                          height: 30,
                                                        ),
                                                        Text(
                                                          ' اضافة عميل جديد',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ]),
                                      Positioned(
                                        top: -2,
                                        right: -1,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => MainScreen(
                                                      index: 0,
                                                    )));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          });
                    },
                    child: HoverAnimatedContainer(
                      hoverWidth: 220,
                      hoverHeight: 220,
                      hoverDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor),
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffBCEFC2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/man.png",
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "العملاء",
                            style: TextStyle(fontSize: 20),
                          )
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
                      hoverWidth: 220,
                      hoverHeight: 220,
                      hoverDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor),
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffBCEFC2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/fabric-pattern.png",
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "اضافة نوع قماش",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      SmartDialog.show(
                          clickMaskDismiss: true,
                          builder: (ctx) {
                            return Stack(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              fit: StackFit.loose,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    width: 300,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      color: buttonColor.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Center(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              HoverAnimatedContainer(
                                                  hoverWidth: 250,
                                                  hoverHeight: 60,
                                                  hoverDecoration:
                                                      BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              backgroundColor),
                                                  margin: EdgeInsets.all(20),
                                                  height: 50,
                                                  width: 230,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: accentCanvasColor,
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "images/user.png",
                                                          height: 30,
                                                        ),
                                                        Text(
                                                          'اضافة مورد جديد',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              HoverAnimatedContainer(
                                                  hoverWidth: 250,
                                                  hoverHeight: 60,
                                                  hoverDecoration:
                                                      BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              backgroundColor),
                                                  margin: EdgeInsets.all(20),
                                                  height: 50,
                                                  width: 230,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: accentCanvasColor,
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "images/pencil.png",
                                                          height: 30,
                                                        ),
                                                        Text(
                                                          ' اضافة توريد جديد',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ]),
                                      ),
                                    )),
                                Positioned(
                                  top: -2,
                                  right: -1,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MainScreen(
                                                    index: 0,
                                                  )));
                                    },
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: HoverAnimatedContainer(
                      hoverWidth: 220,
                      hoverHeight: 220,
                      hoverDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor),
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffBCEFC2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/pencil.png",
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "التوريدات",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Store()));
                    },
                    child: HoverAnimatedContainer(
                      hoverWidth: 220,
                      hoverHeight: 220,
                      hoverDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor),
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffBCEFC2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/store.png",
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "المخزن",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SmartDialog.show(
                          backDismiss: true,
                          onDismiss: () {},
                          builder: (ctx) {
                            return Container(
                                padding: EdgeInsets.all(10),
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Stack(
                                    children: [
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            HoverAnimatedContainer(
                                                hoverWidth: 250,
                                                hoverHeight: 60,
                                                hoverDecoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: backgroundColor),
                                                margin: EdgeInsets.all(20),
                                                height: 50,
                                                width: 230,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: accentCanvasColor,
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "images/man.png",
                                                        height: 30,
                                                      ),
                                                      Text(
                                                        'جميع الموظفين',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            HoverAnimatedContainer(
                                                hoverWidth: 250,
                                                hoverHeight: 60,
                                                hoverDecoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: backgroundColor),
                                                margin: EdgeInsets.all(20),
                                                height: 50,
                                                width: 230,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: accentCanvasColor,
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "images/user.png",
                                                        height: 30,
                                                      ),
                                                      Text(
                                                        ' اضافة موظف جديد',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ]),
                                      Positioned(
                                        top: -2,
                                        right: -1,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => MainScreen(
                                                      index: 0,
                                                    )));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          });
                    },
                    child: HoverAnimatedContainer(
                      hoverWidth: 220,
                      hoverHeight: 220,
                      hoverDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor),
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffBCEFC2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/man.png",
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "الموظفين",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
