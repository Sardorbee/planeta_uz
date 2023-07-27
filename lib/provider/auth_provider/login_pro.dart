import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planeta_uz/ui/home/home_page.dart';
import 'package:planeta_uz/ui/sign_in/sign_in_page.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController repeatpasswordcontroller =
      TextEditingController();
  bool obscureText = true;
  bool obscureText1 = true;
  bool isLoggedIN = false;
  bool isLoading = false;
  tozalash() {
    emailcontroller.clear();
    passwordcontroller.clear();
    repeatpasswordcontroller.clear();
    notifyListeners();
  }

  authState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIN = false;

        print('User is currently signed out!');
      } else {
        isLoggedIN = true;
        print('User is signed in!');
      }
    });
    if (isLoggedIN) {
    } else {
      const SignInPage();
    }
    notifyListeners();
  }

  Future<void> createUser(BuildContext context) async {
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    try {
      isLoading = true;
      notifyListeners();

      if (password == repeatpasswordcontroller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (context.mounted) {
          snackkbar(context, "User created successfully! ");
        }
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ),
              (route) => false);
        }
        tozalash();
      } else {
        snackkbar(context, "Ikkala password ham bir hil bo'lishi kerak");
      }
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      snackkbar(context, e.code);
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (error) {
      snackkbar(context, error.toString());
    }
  }

  Future<void> login(BuildContext context) async {
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    try {
      isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (context.mounted) {
        snackkbar(context, "logged in successfully! ");
      }

      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      snackkbar(context, e.code);
      // if (e.code == 'weak-password') {
      //   debugPrint('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   debugPrint('The account already exists for that email.');
      // }
    } catch (error) {
      snackkbar(context, error.toString());
    }
  }

  snackkbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    isLoading = false;
    notifyListeners();
  }

  obs1() {
    obscureText = !obscureText;
    notifyListeners();
  }

  obs2() {
    obscureText1 = !obscureText1;
    notifyListeners();
  }
}
