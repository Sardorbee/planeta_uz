import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planeta_uz/chat/chat_model.dart';
import 'package:planeta_uz/data/model/universal.dart';


class ChatService {
  static Future<UniversalData> addMessage(
      {required MessageModel messageModel}) async {
    try {
      DocumentReference newOrder = await FirebaseFirestore.instance
          .collection("messages")
          .add(messageModel.toJson());

      await FirebaseFirestore.instance
          .collection("messages")
          .doc(newOrder.id)
          .update({
        "messageId": newOrder.id,
      });

      return UniversalData(data: "Message added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  static Future<UniversalData> updatemessage(
      {required MessageModel messageModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("messages")
          .doc(messageModel.messageId)
          .update(messageModel.toJson());

      return UniversalData(data: "Message updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  static Future<UniversalData> deleteMessage(
      {required String  messageId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("messages")
          .doc(messageId)
          .delete();

      return UniversalData(data: "Message deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
