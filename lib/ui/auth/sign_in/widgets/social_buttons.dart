import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/utils/colors.dart';
import 'package:provider/provider.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
    required this.w,
  });

  final double w;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.2, right: w * 0.2, top: w * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: (){
              context.read<LoginProvider>().signInWithGoogle2(context);
            },
            child: Container(
              padding: EdgeInsets.all(15.h),
              decoration: BoxDecoration(
                color: const Color(0xffFCF3F6),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.mainButtonColor,
                ),
              ),
              child: Image.asset('assets/png/google.png'),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(15.h),
              decoration: BoxDecoration(
                color: const Color(0xffFCF3F6),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.mainButtonColor,
                ),
              ),
              child: Image.asset('assets/png/apple.png'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(15.h),
              decoration: BoxDecoration(
                color: const Color(0xffFCF3F6),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.mainButtonColor,
                ),
              ),
              child: Image.asset('assets/png/facebook.png'),
            ),
          ),
        ],
      ),
    );
  }
}
