import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/ui/sign_in/sign_in_page.dart';
import 'package:planeta_uz/ui/tab_box.dart';
import 'package:provider/provider.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthProvider>().listenAuthSate(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.data == null) {
            print('Sign');
            return SignInPage();
          } else {
            print('Sign');
            return TabBox();
          }
        },
      ),
    );
  }
}