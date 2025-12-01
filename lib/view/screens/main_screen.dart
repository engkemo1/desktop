
import 'package:desktop_app/view/screens/customerScreen/customers_screen.dart';
import 'package:desktop_app/view/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../widgets/side_bar.dart';
import 'add_screen/add_screen.dart';
import 'invoices_screen/all_data_screen.dart';
import 'customerScreen/add_customer.dart';
import 'home_screen.dart';
class MainScreen extends StatefulWidget {
  int? index;
   MainScreen({super.key,this.index});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SidebarXController? _controller ;
  final _key = GlobalKey<ScaffoldState>();
@override
  void initState() {
   _controller = SidebarXController(selectedIndex: widget.index??0, extended: false);

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return     SafeArea(
      child: Scaffold(
      backgroundColor: Colors.black26,
        drawer:           SafeArea(
          child: SidebarX(

            controller: _controller!,
            items:  const [
              SidebarXItem(icon: Icons.home_outlined, label: ''),

              SidebarXItem(icon: Icons.add, label: ''),
              SidebarXItem(icon: Icons.folder_copy_outlined, label: ''),
              SidebarXItem(icon: Icons.add_reaction, label: ''),
              SidebarXItem(icon: Icons.account_box_sharp, label: ''),

              SidebarXItem(icon: Icons.exit_to_app, label: '')
      
            ],
      
          ),
        ),
      
      
        body:SafeArea(
          child: Row(
            children: [
            SidebarXWidget(controller: _controller!),
              Expanded(
                child: Center(
                  child: _ScreensExample(
                    controller: _controller!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return HomeScreen() ;

          case 1:
            return AllDataScreen() ;

          case 2:
         return   AddInvoiceScreen();
          case 3:
            return   AddCustomer();
          case 4:
            return   CustomerScreen();
            default:
            return const SizedBox();
        }
      },
    );
  }
}