import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/ui/auth/sign_in/sign_in_page.dart';
import 'package:planeta_uz/ui/tab_box/tab_box.dart';
import 'package:planeta_uz/ui/tab_box_admin/tab_box_admin.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<LoginProvider>().listenAuthState(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.data == null) {
            print('User is not signed in');
            return const SignInPage();
          } else {
            if (context
                .read<LoginProvider>()
                .user!
                .email!
                .contains('admin123')) {
              print('Admin');
              return const TabBoxAdmin();
            } else {
              print('Client');
              return const TabBox();
            }
          }
        },
      ),
    );
  }
}
