import 'package:desktop_app/view/screens/add_screen/cubit/add_invoice_cubit.dart';
import 'package:desktop_app/view/screens/home_screen.dart';
import 'package:desktop_app/view/screens/login/login_screen.dart';
import 'package:desktop_app/view/screens/main_screen.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:desktop_app/view_model/database/local/cache_helper.dart';
import 'package:desktop_app/view_model/database/network/dio-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DioHelper.init();
  await CacheHelper.init();
  runApp( MultiBlocProvider(
  providers: [
  BlocProvider(create: (_) => AddInvoiceCubit()),
  BlocProvider(create: (_) => ProductCubit()),
  ],
  child:  MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'اولاد ابوسلطح',
              home:HomeScreen(),
          navigatorObservers: [FlutterSmartDialog.observer],
          // here
          builder: FlutterSmartDialog.init(),
            );
  }
}
