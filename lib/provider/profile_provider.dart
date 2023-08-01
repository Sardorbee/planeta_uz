import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planeta_uz/data/firebase/profile_service.dart';
import 'package:planeta_uz/data/model/universal.dart';

class ProfileProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordcont = TextEditingController();

  ProfileProvider({required this.profileService}) {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
    listenUserChanges();
  }
  bool isLoading = false;
  ProfileService profileService;
  User? currentUser;

  listenUserChanges() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      currentUser = user;
      emailController.text = currentUser?.email ?? '';
      notifyListeners();
    });
  }
  notify(bool v) {
    isLoading = v;
    notifyListeners();
  }

  Future<void> updateEmail(BuildContext context) async {
    String email = emailController.text;
    if (email.isNotEmpty) {
      notify(true);
      UniversalData universalData =
          await profileService.updateuserEmail(email: email);
      notify(false);
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          snackkbar(context, universalData.data.toString());
        }
      } else {
        if (context.mounted) {
          snackkbar(context, universalData.error);
        }
      }
    }
  }

  Future<void> updatePassword(BuildContext context) async {
    String password = passwordcont.text;
    if (password.isNotEmpty) {
      notify(true);
      UniversalData universalData =
          await profileService.updateUserPassword(password: password);
      notify(false);
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          snackkbar(context, universalData.data.toString());
        }
      } else {
        if (context.mounted) {
          snackkbar(context, universalData.error);
        }
      }
    }
  }

  snackkbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    isLoading = false;
    notifyListeners();
  }
}
