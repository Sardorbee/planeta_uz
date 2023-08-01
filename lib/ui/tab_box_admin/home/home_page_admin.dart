import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/provider/profile_provider.dart';
import 'package:planeta_uz/ui/tab_box/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreenAdmin extends StatelessWidget {
  const HomeScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider x = context.read<LoginProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home Page'),
        actions: [
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
                  )
                : CircleAvatar(
                    foregroundImage: NetworkImage(
                      context.read<ProfileProvider>().currentUser!.photoURL!,
                      scale: 2,
                    ),
                  ),
          ),
          SizedBox(
            width: 12.w,
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Logged IN'),
                ElevatedButton(
                    onPressed: () {
                      context.read<LoginProvider>().logOut(context);
                    },
                    child: const Text('Log Out'))
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
