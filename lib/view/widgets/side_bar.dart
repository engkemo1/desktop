import 'package:desktop_app/view_model/database/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../constants.dart';
import '../screens/login/login_screen.dart';

class SidebarXWidget extends StatelessWidget {
  const SidebarXWidget({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return SidebarX(
      controller: _controller,
      showToggleButton:isSmallScreen? false:true,
      theme: SidebarXTheme(

        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),

        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme:  SidebarXTheme(
        width: isSmallScreen?100:300,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),

      footerDivider: divider,
      headerBuilder: (context, extended) {
        return extended?isSmallScreen? Column(children: [
          SizedBox(height: 20,),
          SvgPicture.asset(
            'images/very big logo.svg',
            height: 150,

            ),const Text(
            ' اولاد ابو سلطح',
            style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold,color: Colors.white),
          ),
          SizedBox(height: 20,)
        ]):Column(children: [
          SizedBox(height: 20,),

        SvgPicture.asset(
        'images/midlle logo.svg',
        width: 200,
        ),const Text(
            ' اولاد ابو سلطح',
            style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold,color: Colors.white),
          ),
          SizedBox(height: 20,)
        ]):SizedBox(
          height: 120,
          child:  SvgPicture.asset(
            'images/big logo.svg',
          ),
        );
      },
      items:  [
        const   SidebarXItem(
          icon: Icons.home_outlined,
          label: 'الصفحة الرئيسية',
        ),
        const   SidebarXItem(
          icon: Icons.folder,
          label: 'الفواتير',
        ),
        const   SidebarXItem(
          icon: Icons.add_circle_outline_sharp,
          label: 'اضافة فاتورة',
        ),
        const  SidebarXItem(
          icon: Icons.add_reaction_outlined,
          label: 'اضافة عميل',
        ),const SidebarXItem(
          icon: Icons.account_box_sharp,
          label: 'العملاء',
        ),
         SidebarXItem(
          icon: Icons.exit_to_app,
          label: 'خروج',
           onTap: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=> LoginScreen()));
            CacheHelper.removeData(key: "user");
           }
        ),

      ],
    );
  }
}
