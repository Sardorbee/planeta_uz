import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planeta_uz/chat/chat_model.dart';
import 'package:planeta_uz/chat/chat_service.dart';
import 'package:planeta_uz/data/model/universal.dart';

class ChatProvider with ChangeNotifier {
  ChatProvider(
    this.chatService,
  );

  final ChatService chatService;

  TextEditingController textEditingController = TextEditingController();

  Future<void> addmessage({
    required BuildContext context,
    required MessageModel messageModel,
  }) async {
    UniversalData universalData =
        await ChatService.addMessage(messageModel: messageModel);
    if (context.mounted) {
      showMessage(context, universalData.error);
    }
  }

  Future<void> updateMessage({
    required BuildContext context,
    required MessageModel messageModel,
  }) async {
    UniversalData universalData =
        await ChatService.updatemessage(messageModel: messageModel);

    if (context.mounted) {
      showMessage(context, universalData.error);
    }
  }

  Future<void> deleteMessage({
    required BuildContext context,
    required String messageId,
  }) async {
    UniversalData universalData =
        await ChatService.deleteMessage(messageId: messageId);

    if (context.mounted) {
      showMessage(context, universalData.error);
    }
  }

  Stream<List<MessageModel>> getMessages() => FirebaseFirestore.instance
      .collection("messages")
      .orderBy('createdAt')
      .snapshots()
      .map(
        (event1) => event1.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList(),
      );

  Stream<List<MessageModel>> getMessagesByID(String messageId) {
    final databaseReference = FirebaseFirestore.instance.collection('messages');

    return databaseReference
        .where('userId', isEqualTo: messageId)
        .orderBy('createdAt')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList());
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }
}
