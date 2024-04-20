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

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'images/background7.jpg',
                  ),
                  fit: BoxFit.fill)),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.network(
                          'https://lottie.host/752b689d-58eb-46ea-831a-2f3f07b8ecda/Misq3L3A3n.json',
                          width: isSmallScreen ? 200 : 300,
                          height: isSmallScreen ? 150 : 200,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          ' اولاد ابو سلطح',
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: isSmallScreen ? 20 : 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'لخياطة جميع انواع الملابس الرجالي \n ادارة الحاج عبد النبي ابو سلطح \nواولاد ايمن - محمد',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 15 : 20,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            width: isSmallScreen
                                ? null
                                : MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    controller: userNameController,
                                    validator: (val) => val!.length == 0
                                        ? 'please enter name'
                                        : null,
                                    style: TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.grey),
                                      prefixIcon: Icon(
                                        Icons.abc,
                                        size: 24,
                                        color: backgroundColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black54)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: backgroundColor)),
                                      hintText: 'ادخل الاسم',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.black),
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
                                              color: Colors.blueAccent,
                                              _obscured
                                                  ? Icons.visibility_rounded
                                                  : Icons
                                                      .visibility_off_rounded,
                                              size: 24,
                                            ),
                                          )),
                                      hintStyle:
                                          TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black54)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: backgroundColor)),
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
                                        data.login(userNameController.text,
                                            passController.text, context);
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
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
