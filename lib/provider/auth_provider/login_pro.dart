import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool obscureText = true;
  
}
