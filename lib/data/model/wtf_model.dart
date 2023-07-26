
import 'dart:convert';

List<WtfModel> wtfModelFromJson(String str) => List<WtfModel>.from(json.decode(str).map((x) => WtfModel.fromJson(x)));

String wtfModelToJson(List<WtfModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WtfModel {
    int userId;
    int id;
    String title;

    WtfModel({
        required this.userId,
        required this.id,
        required this.title,
    });

    factory WtfModel.fromJson(Map<String, dynamic> json) => WtfModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
    };
}
