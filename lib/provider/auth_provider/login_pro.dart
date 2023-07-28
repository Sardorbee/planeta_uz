import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:planeta_uz/ui/auth/sign_in/sign_in_page.dart';

import 'package:planeta_uz/ui/tab_box/tab_box.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController repeatpasswordcontroller =
      TextEditingController();
  bool obscureText = true;
  bool obscureText1 = true;

  bool isLoading = false;
  notify(bool v) {
    isLoading = v;
    notifyListeners();
  }

  tozalash() {
    emailcontroller.clear();
    passwordcontroller.clear();
    repeatpasswordcontroller.clear();
    notifyListeners();
  }

  Stream<User?> listenAuthState() => FirebaseAuth.instance.authStateChanges();

  Future<void> createUser(BuildContext context) async {
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    try {
      notify(true);

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
      notify(false);
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
      notify(true);

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

      notify(false);
    } on FirebaseAuthException catch (e) {
      snackkbar(context, e.code);
    } catch (error) {
      snackkbar(context, error.toString());
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      notify(true);

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
      notify(false);
    } on FirebaseAuthException catch (e) {
      snackkbar(context, e.code);
    } catch (error) {
      snackkbar(context, error.toString());
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      notify(true);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      notify(false);
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
