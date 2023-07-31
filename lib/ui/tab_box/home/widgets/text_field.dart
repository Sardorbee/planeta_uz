import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/ui/utils/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          prefixIcon: Icon(Icons.search,color: AppColors.c_BBBBBB,size: 20,),
          hintText: 'Search any product..',
          hintStyle: TextStyle(
            color: AppColors.c_BBBBBB,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
          suffixIcon: Icon(Icons.keyboard_voice_outlined,color: AppColors.c_BBBBBB,size: 20,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: AppColors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
