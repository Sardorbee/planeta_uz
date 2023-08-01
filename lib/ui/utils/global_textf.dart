import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/ui/utils/colors.dart';

class GlobalTextField extends StatelessWidget {
  GlobalTextField({
    Key? key,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    required this.textAlign,
    this.obscureText = false,
    this.maxLines = 1,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  int? maxLines;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  TextAlign textAlign;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.c_0C1A30,
          fontFamily: "DMSans"),
      textAlign: textAlign,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.c_0C1A30,
            fontFamily: "DMSans"),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.c_C8C8C8,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.c_C8C8C8,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.c_C8C8C8,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.c_C8C8C8,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.c_C8C8C8,
          ),
        ),
      ),
    );
  }
}
