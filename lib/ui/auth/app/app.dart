import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planeta_uz/data/service/notification/notify_service.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/provider/order_provider.dart';
import 'package:planeta_uz/ui/auth/sign_in/sign_in_page.dart';
import 'package:planeta_uz/ui/tab_box/tab_box.dart';
import 'package:planeta_uz/ui/tab_box_admin/tab_box_admin.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<User?>(
              stream: context.read<LoginProvider>().listenAuthState(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.data == null) {
                  return const SignInPage();
                } else {
                  return snapshot.data?.email == 'admin123@mail.ru'
                      ? const TabBoxAdmin()
                      : const TabBox();
                }
              },
            ),
          ),
          
        ],
      ),
    );
  }
}
