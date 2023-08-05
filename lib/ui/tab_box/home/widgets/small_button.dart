import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/utils/colors.dart';

// ignore: must_be_immutable
class SmallButton extends StatelessWidget {
  SmallButton({super.key, required this.text, required this.iconData});

  String text;
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color:AppColors.white,
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              iconData,
              size: 16,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
