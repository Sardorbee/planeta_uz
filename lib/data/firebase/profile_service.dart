import 'package:firebase_auth/firebase_auth.dart';
import 'package:planeta_uz/data/model/universal.dart';

class ProfileService{
  Future<UniversalData> updateuserEmail({required String email})async{
    try{
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      return UniversalData(data: "Updated!");
    }on FirebaseAuthException catch(e){
      return UniversalData(error: e.code);
    }catch(e){
      return UniversalData(error: e.toString());
    }
  }
}