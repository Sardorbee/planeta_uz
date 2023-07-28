import 'package:flutter/material.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider x = context.read<LoginProvider>();
    return Scaffold(
      appBar: AppBar(),
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
            Visibility(
                visible: x.isLoading,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
          ],
        ),
      ),
    );
  }
}
