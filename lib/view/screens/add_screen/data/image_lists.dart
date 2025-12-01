import 'package:flutter/widgets.dart';

class ImageLists {
  // return the path strings (used in model and UI)
  final List<String> list1 = [
    "images/كلفة تامة بشليك.png",
    "images/كلفة تامة نص ياقة.png",
    "images/جلابية قشرة.png",
  ];

  final List<String> list2 = [
    "images/الياقة بدون زراير.png",
    "images/الياقة زرار واحد.png",
    "images/الياقة 2 زرار.png",
  ];

  final List<String> list3 = [
    "images/جلاب 1 زرار.png",
    "images/جلاب 2 زرار.png",
  ];

  final List<String> list4 = [
    "images/جانب بشليك.png",
    "images/جانب شق.png",
  ];

  final List<String> list5 = [
    "images/جيب مربع.png",
    "images/جيب مربع مثلث.png",
    "images/جيب مدور.png",
  ];

  final List<String> list6 = [
    "images/صدر عادي.png",
    "images/صدر مخفي.png",
    "images/صدر-عادي-مربع .png",
    "images/صدر عادي لون في لون 2 خط.jpg",
    "images/صدر لون في لون خط واحد.png",
  ];

  final List<String> list7 = [
    "images/كم شعراوي علية زراير.jpg",
    "images/كم بلدي.png",
    "images/الكم سادة+بشليك لزق.png",
    "images/الكم سادة.png",
    "images/اساورة بشليك.png",
    "images/اساورة كسره واحد.jpg",
    "images/اساورة 2 كسرة.jpg",
    "images/اساورة مربع بدون كسرة.png",
    "images/اساورة مربع كسرة واحدة.jpg",
    "images/اساورة مربع 2 كسرة.jpg",
  ];

  // helpers for known constant image references used in your model
  String get komBaladyPath => "images/كم-بلدي1.png";
  String get komSha3rawyPath => "images/png.png";

  // helper to convert a path into a widget (ClipRRect as in original)
  Widget imageWidget(String assetPath) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: Image.asset(assetPath, height: 300, width: 300, fit: BoxFit.contain),
    );
  }
}
