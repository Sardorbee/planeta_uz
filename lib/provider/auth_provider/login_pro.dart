import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planeta_uz/ui/sign_in/sign_in_page.dart';
import 'package:planeta_uz/ui/tab_box/tab_box.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController repeatpasswordcontroller =
      TextEditingController();
  bool obscureText = true;
  bool obscureText1 = true;

  bool isLoading = false;
  tozalash() {
    emailcontroller.clear();
    passwordcontroller.clear();
    repeatpasswordcontroller.clear();
    notifyListeners();
  }

  Future<void> authState(BuildContext context) async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;

    if (user == null) {
      if(context.mounted){
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInPage(),
        ),
        (route) => false,
      );

      }
      print('User is currently signed out!');
    } else {
      if(context.mounted){
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const TabBox(),
        ),
        (route) => false,
      );

      }

      print('User is signed in!');
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

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (context.mounted) {
        snackkbar(context, "logged in successfully! ");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => const TabBox())),
            (route) => false);
        tozalash();
      }

      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      snackkbar(context, e.code);
    } catch (error) {
      snackkbar(context, error.toString());
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.signOut();

      if (context.mounted) {
        snackkbar(context, "logged Out successfully! ");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInPage(),
            ),
            (route) => false);
      }
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      snackkbar(context, e.code);
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
