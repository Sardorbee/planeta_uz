import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/provider/profile_provider.dart';
import 'package:planeta_uz/ui/tab_box/home/widgets/products_grid_view.dart';
import 'package:planeta_uz/ui/tab_box/home/widgets/small_button.dart';
import 'package:planeta_uz/ui/tab_box/home/widgets/text_field.dart';
import 'package:planeta_uz/ui/tab_box/profile/profile_screen.dart';
import 'package:planeta_uz/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider x = context.read<LoginProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF2F2F2),
        actions: [
          Image.asset(
            'assets/png/splash.png',
            height: 31.h,
            width: 38.w,
          ),
          SizedBox(width: 9.w),
          Center(
            child: Text(
              'The Gallactic Baazar',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.c_4392F9,
              ),
            ),
          ),
          SizedBox(width: 79.w),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            icon: context.read<ProfileProvider>().currentUser!.photoURL == null
                ? Icon(
                    Icons.account_circle,
                    size: 40.h,
                    color: Colors.black,
                  )
                : CircleAvatar(
                    foregroundImage: NetworkImage(
                      context.read<ProfileProvider>().currentUser!.photoURL!,
                      scale: 2,
                    ),
                  ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SizedBox(height: 16.h),
          const MyTextField(),
          SizedBox(height: 17.h),
          Row(
            children: [
              Text(
                '2 Categories',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              SmallButton(text: 'Sort', iconData: Icons.sort),
              SizedBox(width: 12.w),
              SmallButton(text: 'Filter', iconData: Icons.filter_alt_outlined),
            ],
          ),
          SizedBox(height: 17.h),
          SizedBox(
            height: MediaQuery.of(context).size.height - 108.h,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: const [
                ProductsGridView(),
                ProductsGridView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
