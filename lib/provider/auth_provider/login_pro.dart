import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  // _checkAuthState(){
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if(user==null){
  //       debugPrint('User is currently signed out');
  //     }else{
  //       debugPrint('User is signed in');
  //     }
  //   });
  // }

  Stream<User?> listenAuthSate() => FirebaseAuth.instance.authStateChanges();

}
