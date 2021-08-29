// To parse this JSON data, do
//
//     final routenModel = routenModelFromJson(jsonString);

import 'dart:convert';

RoutenModel routenModelFromJson(String str) =>
    RoutenModel.fromJson(json.decode(str));

String routenModelToJson(RoutenModel data) => json.encode(data.toJson());

class RoutenModel {
  RoutenModel({
    this.teacherName,
    this.subject,
    this.date,
    this.time,
  });

  String teacherName;
  String subject;
  String date;
  String time;

  factory RoutenModel.fromJson(Map<String, dynamic> json) => RoutenModel(
        teacherName: json["teacherName"],
        subject: json["subject"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "teacherName": teacherName,
        "subject": subject,
        "date": date,
        "time": time,
      };
}
