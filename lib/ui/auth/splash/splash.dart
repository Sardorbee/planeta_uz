import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/ui/auth/app/app.dart';
import 'package:planeta_uz/ui/utils/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _init() async {
    await Future.delayed(const Duration(seconds: 3));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return App();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/png/splash.png',
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'The Gallactic Baazar',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainButtonColor),
            )
          ],
        ),
      ),
    );
  }
}
