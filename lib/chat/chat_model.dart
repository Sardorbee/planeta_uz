class MessageModel {
  final String message;
  final DateTime createdAt;
  final String uid;
  String? messageId;

  MessageModel({
    required this.message,
    required this.createdAt,
    required this.uid,
    required this.messageId
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      messageId: json['messageId'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'messageId': messageId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'uid': uid,
    };
  }
}
