// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import 'package:amer_school/App/domain/entites/Message_Model_entity.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel extends MessageModelEntity {
  MessageModel({
    this.message,
    this.sendBy,
    this.date,
    this.imageLink,
    this.type,
    this.sendByStudent,
    this.personProfilLink,
  }) : super(
          message,
          sendBy,
          date,
          imageLink,
          type,
          sendByStudent,
          personProfilLink,
        );

  final String message;
  final String sendBy;
  final DateTime date;
  final String imageLink;
  final String type;
  final bool sendByStudent;
  final String personProfilLink;

  factory MessageModel.fromMessageModelEntity(
          MessageModelEntity messageModelEntity) =>
      MessageModel(
        message: messageModelEntity.message,
        sendBy: messageModelEntity.sendBy,
        date: messageModelEntity.date,
        imageLink: messageModelEntity.imageLink,
        personProfilLink: messageModelEntity.personProfilLink,
        type: messageModelEntity.type,
        sendByStudent: messageModelEntity.sendByStudent,
      );

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
