import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String? image;
  final Widget? customImage;
  final String title;
  final String subTitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final bool hideBackgroundAnimation;

  const EmptyWidget({
    Key? key,
    this.image,
    this.customImage,
    required this.title,
    required this.subTitle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.hideBackgroundAnimation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (customImage != null)
            customImage!
          else if (image != null)
            Image.asset(
              image!,
              height: 100,
              width: 100,
            ),
          const SizedBox(height: 20),
          Text(
            title,
            style: titleTextStyle ??
                TextStyle(
                  fontSize: 22,
                  color: const Color(0xff9da9c7),
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            subTitle,
            style: subtitleTextStyle ??
                TextStyle(
                  fontSize: 16,
                  color: const Color(0xffabb8d6),
                ),
          ),
          if (!hideBackgroundAnimation)
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            ),
        ],
      ),
    );
  }
}
