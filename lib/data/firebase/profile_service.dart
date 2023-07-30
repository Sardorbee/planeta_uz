import 'package:firebase_auth/firebase_auth.dart';
import 'package:planeta_uz/data/model/universal.dart';

class ProfileService{
  final user = FirebaseAuth.instance.currentUser;



  Future<UniversalData> updateuserEmail({required String email})async{
    try{
      await user?.updateEmail(email);
      return UniversalData(data: "Updated!");
    }on FirebaseAuthException catch(e){
      return UniversalData(error: e.code);
    }catch(e){
      return UniversalData(error: e.toString());
    }
  }
  Future<UniversalData> updateUserPassword({required String password})async{
    try{
      await user?.updatePassword(password);
      return UniversalData(data: "Updated!");
    }on FirebaseAuthException catch(e){
      return UniversalData(error: e.code);
    }catch(e){
      return UniversalData(error: e.toString());
    }
  }
}