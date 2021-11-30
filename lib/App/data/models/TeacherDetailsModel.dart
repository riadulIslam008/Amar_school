// To parse this JSON data, do
//
//     final teacherDetailsModel = teacherDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';
import 'package:flutter/cupertino.dart';

TeacherDetailsModel teacherDetailsModelFromJson(String str) =>
    TeacherDetailsModel.fromJson(json.decode(str));

String teacherDetailsModelToJson(TeacherDetailsModel data) =>
    json.encode(data.toJson());

class TeacherDetailsModel extends TeacherModelEntity {
  TeacherDetailsModel({
    @required this.quetosForStudent,
    @required this.teacherName,
    @required this.teacherProfileLink,
    @required this.teacherSubject,
    @required this.teacherUid,
    @required this.mobileNumber,
  }) : super(
          quetosForStudent: quetosForStudent,
          teacherName: teacherName,
          teacherProfileLink: teacherProfileLink,
          mobileNumber: mobileNumber,
          teacherSubject: teacherSubject,
          teacherUid: teacherUid,
        );

  final String quetosForStudent;
  final String teacherName;
  final String teacherProfileLink;
  final String teacherSubject;
  final String teacherUid;
  final String mobileNumber;

  factory TeacherDetailsModel.fromJson(Map<String, dynamic> json) =>
      TeacherDetailsModel(
        quetosForStudent: json["quetosForStudent"],
        teacherName: json["teacherName"],
        teacherProfileLink: json["teacherProfileLink"],
        teacherSubject: json["teacherSubject"],
        teacherUid: json["teacherUid"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "quetosForStudent": quetosForStudent,
        "teacherName": teacherName,
        "teacherProfileLink": teacherProfileLink,
        "teacherSubject": teacherSubject,
        "teacherUid": teacherUid,
        "mobileNumber": mobileNumber,
      };
}
