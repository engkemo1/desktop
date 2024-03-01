import 'package:desktop_app/view_model/cubit/login_cubit/login_cubit.dart';
import 'package:desktop_app/view_model/cubit/login_cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userNameController = TextEditingController();

  var passController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _obscured = true;
    // TODO: implement initState
    super.initState();
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: isSmallScreen
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF080215),
                      Color(0xFF45273e),
                      Color(0xFF8c4657),
                      Color(0xFFcd725d),
                      Color(0xFFf4af5c),
                      Color(0xFFf9f871)
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SvgPicture.asset(
                      'images/very big logo.svg',
                      width: 200,
                    ),
                    const Text(
                      ' اولاد ابو سلطح',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Text(
                      'لخياطة جميع انواع الملابس الرجالي \n ادارة الحاج عبد النبي ابو سلطح \nواولاد ايمن - محمد',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: userNameController,
                                        validator: (val) => val!.length == 0
                                            ? 'please enter name'
                                            : null,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.abc,
                                            size: 24,
                                            color: accentCanvasColor,
                                          ),
                                          border: OutlineInputBorder(),
                                          hintText: 'ادخل الاسم',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.white),
                                        controller: passController,
                                        validator: (val) => val!.length < 6
                                            ? 'Password too short.'
                                            : null,
                                        obscureText: _obscured,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock_rounded,
                                            size: 24,
                                            color: accentCanvasColor,
                                          ),
                                          suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 4, 0),
                                              child: GestureDetector(
                                                onTap: _toggleObscured,
                                                child: Icon(
                                                  _obscured
                                                      ? Icons.visibility_rounded
                                                      : Icons
                                                          .visibility_off_rounded,
                                                  size: 24,
                                                ),
                                              )),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          hintText: 'ادخل الرقم السري',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                width: 150,
                                height: 40,
                                child: BlocProvider(
                                  create: (context) => LoginCubit(),
                                  child:
                                  BlocConsumer<LoginCubit, LoginMainState>(
                                      listener:
                                          (BuildContext context, state) async {
                                        if (state is LoginLoadingState) {
                                          SmartDialog.showLoading();
                                          await Future.delayed(Duration(seconds: 2));
                                          SmartDialog.dismiss();
                                        }
                                      }, builder: (BuildContext context, state) {
                                    var data = LoginCubit.get(context);
                                    return ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            data.login(userNameController.text,
                                                passController.text, context);
                                            // TODO submit
                                          }
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    accentCanvasColor)),
                                        child:const Text(
                                                'تسجيل',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ));
                                  }),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container( decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'images/login.jpg',
              ),
              fit: BoxFit.fill)),
            child: Container(

                   color: Colors.black.withOpacity(0.8),width: double.infinity,
                  child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width:500,

                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: accentCanvasColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.network(
                          
                          'https://lottie.host/752b689d-58eb-46ea-831a-2f3f07b8ecda/Misq3L3A3n.json',
                          width: 300,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                        const Text(
                          ' اولاد ابو سلطح',
                          style: TextStyle(color: backgroundColor,
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'لخياطة جميع انواع الملابس الرجالي \n ادارة الحاج عبد النبي ابو سلطح \nواولاد ايمن - محمد',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: userNameController,
                                    validator: (val) => val!.length == 0
                                        ? 'please enter name'
                                        : null,
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.white70),
                                      prefixIcon: Icon(
                                        Icons.abc,
                                        size: 24,
                                        color: backgroundColor,
                                      ),
                                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white70)),
                                      focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: backgroundColor)) ,
                                      hintText: 'ادخل الاسم',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(                                        style: TextStyle(color: Colors.white),

                                    controller: passController,
                                    validator: (val) => val!.length < 6
                                        ? 'Password too short.'
                                        : null,
                                    obscureText: _obscured,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock_rounded,
                                        size: 24,
                                        color: backgroundColor,
                                      ),
                                      suffix: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 4, 0),
                                          child: GestureDetector(
                                            onTap: _toggleObscured,
                                            child: Icon(
                                              color:buttonColor,
                                              _obscured
                                                  ? Icons.visibility_rounded
                                                  : Icons
                                                      .visibility_off_rounded,
                                              size: 24,
                                            ),
                                          )),                                      hintStyle: TextStyle(color: Colors.white70),

                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white70)),
                                      focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: backgroundColor)) ,
                                      hintText: 'ادخل الرقم السري',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: 150,
                            height: 40,
                            child: BlocProvider(
                              create: (context) => LoginCubit(),
                              child: BlocConsumer<LoginCubit, LoginMainState>(
                                  listener:
                                      (BuildContext context, state) async {
                                if (state is LoginLoadingState) {
                                  SmartDialog.showLoading();
                                  await Future.delayed(Duration(seconds: 2));
                                  SmartDialog.dismiss();
                                }
                              }, builder: (BuildContext context, state) {
                                var data = LoginCubit.get(context);
                                return ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        data.login(
                                            userNameController.text,
                                            passController.text,
                                            context);
                                        // TODO submit
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                backgroundColor)),
                                    child: const Text(
                                      'تسجيل',
                                      style: TextStyle(color: Colors.white),
                                    ));
                              }),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ),
    );
  }
}
