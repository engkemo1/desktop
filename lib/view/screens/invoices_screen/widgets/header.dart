import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

import '../../../../constants.dart';
import '../../../widgets/customTextField.dart';
import '../../add_screen/add_screen.dart';
import '../../home_screen.dart';
import '../../main_screen.dart';

class Header extends StatelessWidget {
  final bool isSmallScreen;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const Header({
    Key? key,
    required this.isSmallScreen,
    required this.searchController,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Header layout reused for both mobile and desktop (minor padding differences handled by caller)
    return Container(
      width: double.infinity,
      color: accentCanvasColor,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // navigate to main/home
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen(index: 0)));
                },
                child: HoverAnimatedContainer(
                  hoverWidth: isSmallScreen ? 140 : 200,
                  padding: EdgeInsets.all(isSmallScreen ? 10 : 20),
                  hoverDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.withOpacity(0.8),
                  ),
                  margin: EdgeInsets.only(left: isSmallScreen ? 10 : 20, right: isSmallScreen ? 10 : 20),
                  width: isSmallScreen ? 140 : 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffBCEFC2),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.home),
                      SizedBox(width: 6),
                      Text(
                        "الصفحة الرئيسية",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isSmallScreen)
                Row(
                  children: [
                    Text(
                      "الفواتير",
                      style: TextStyle(
                          fontSize: 35,
                          wordSpacing: 2,
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 5),
                    Image.asset("images/receipt.png", height: 70),
                  ],
                )
              else
                Row(
                  children: [
                    Text(
                      "الفواتير",
                      style: TextStyle(
                          fontSize: 25,
                          wordSpacing: 2,
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 5),
                    Image.asset("images/receipt.png", height: 50),
                  ],
                ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen(index: 2)));
                },
                child: HoverAnimatedContainer(
                  hoverWidth: isSmallScreen ? 140 : 200,
                  padding: EdgeInsets.all(isSmallScreen ? 10 : 20),
                  hoverDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.withOpacity(0.8),
                  ),
                  margin: EdgeInsets.only(left: isSmallScreen ? 10 : 20, right: isSmallScreen ? 10 : 20),
                  width: isSmallScreen ? 140 : 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffBCEFC2),
                  ),
                  child: Row(
                    children: [
                      Image.asset("images/report.png", height: isSmallScreen ? 30 : 30),
                      const SizedBox(width: 6),
                      const Text(
                        "  اضافة فاتورة",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 100, vertical: 10),
            child: SizedBox(
              height: 50,
              child: CustomTextField(
                controller: searchController,
                prefix: const Icon(Icons.search),
                onChanged: onSearchChanged,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, size: 15),
                  onPressed: () {
                    searchController.clear();
                    onSearchChanged('');
                  },
                ),
                hintText: ' ابحث عن فاتورة ',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
