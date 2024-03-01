import 'package:desktop_app/view/screens/login/login_screen.dart';
import 'package:desktop_app/view/screens/main_screen.dart';
import 'package:desktop_app/view_model/database/local/cache_helper.dart';
import 'package:desktop_app/view_model/database/network/dio-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'اولاد ابوسلطح',
              home: CacheHelper.get(key: "user")==null?LoginScreen():MainScreen(),
          navigatorObservers: [FlutterSmartDialog.observer],
          // here
          builder: FlutterSmartDialog.init(),
            );
  }
}
