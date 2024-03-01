import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class CustomTextField extends StatelessWidget {
  final bool? isFormField ;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String?)? onsub;
final   TextStyle? hintStyle;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool? enable ;
  final bool isValidator;
  final  String? Function(String?)? validatorMessage;
  final Color ?fillColor;
  final TextCapitalization capitalization;
  final bool isBorder;
  CustomTextField(
      {this.controller,
        this.hintText,
        this.textInputType,
        this.maxLine,
        this.focusNode,
        this.enable,
        this.nextNode,
        this.textInputAction,
        this.isPhoneNumber = false,
        this.isValidator=true,
        this.validatorMessage,
        this.capitalization = TextCapitalization.none,
        this.fillColor,
        this.isBorder = false,  this.isFormField, this.prefix, this.suffix, this.onChanged, this.suffixIcon, this.onsub, this.hintStyle,
      });

  @override
  Widget build(context) {
    return TextFormField(
          textAlign: isBorder? TextAlign.center:TextAlign.start,
          controller: controller,
          enabled: enable,
          maxLines: maxLine ?? 1,
          textCapitalization: capitalization,
          maxLength: isPhoneNumber ? 15 : null,
          focusNode: focusNode,
          onSaved: onsub,
          keyboardType: textInputType ?? TextInputType.text,
          //keyboardType: TextInputType.number,
          initialValue: null,
          onChanged:onChanged ,

          //autovalidate: true,
          validator: isValidator?  (input){
      if(input!.isEmpty){
        return "حقل فارغ";
      }
      return null;

    }:null,

          decoration: InputDecoration(
            prefixIcon: prefix??null,
              suffixIcon: suffix??null,
              suffix: suffixIcon??null,


errorMaxLines: 1,
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            hintText: hintText ?? '',
            filled: true,
            hintStyle: hintStyle ??null,
            fillColor:Color(0xffBCEFC2),
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            isDense: true,

            counterText: '',
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent))
          ),

    );
  }
}
