// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.message,
    this.sendBy,
    this.date,
    this.imageLink,
    this.type,
    this.sendByStudent,
    this.personProfilLink,
  });

  String message;
  String sendBy;
  DateTime date;
  String imageLink;
  String type;
  bool sendByStudent;
  String personProfilLink;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
        sendBy: json["sendBy"],
        date: DateTime.parse(json["date"]),
        imageLink: json["imageLink"],
        type: json["type"],
        sendByStudent: json["sendByStudent"],
        personProfilLink: json["personProfilLink"],
        
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "sendBy": sendBy,
        "date": date.toIso8601String(),
        "imageLink": imageLink,
        "type": type,
        "sendByStudent": sendByStudent,
        "personProfilLink": personProfilLink,
      };
}
