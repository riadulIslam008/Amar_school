// To parse this JSON data, do
//
//     final studentDetailsModel = studentDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';

StudentDetailsModel studentDetailsModelFromJson(String str) =>
    StudentDetailsModel.fromJson(json.decode(str));

String studentDetailsModelToJson(StudentDetailsModel data) =>
    json.encode(data.toJson());

class StudentDetailsModel extends StudentModelEntity {
  StudentDetailsModel({
    this.studentName,
    this.studentRoll,
    this.studentProfileLink,
    this.studentUid,
    this.studentClass,
  }) : super(
          studentName: studentName,
          studentRoll: studentRoll,
          studentProfileLink: studentProfileLink,
          studentUid: studentUid,
          studentClass: studentClass,
        );

  final String studentName;
  final String studentRoll;
  final String studentProfileLink;
  final String studentUid;
  final String studentClass;

  factory StudentDetailsModel.fromJsonStudentModelEntity(
      StudentModelEntity studentModelEntity) {
    return StudentDetailsModel(
      studentName: studentModelEntity.studentName,
      studentRoll: studentModelEntity.studentRoll,
      studentUid: studentModelEntity.studentUid,
      studentClass: studentModelEntity.studentClass,
      studentProfileLink: studentModelEntity.studentProfileLink,
    );
  }

  factory StudentDetailsModel.fromJson(Map<String, dynamic> json) =>
      StudentDetailsModel(
        studentName: json["studentName"],
        studentRoll: json["studentRoll"],
        studentProfileLink: json["studentProfileLink"],
        studentUid: json["studentUid"],
        studentClass: json["studentClass"],
      );

  Map<String, dynamic> toJson() => {
        "studentName": studentName,
        "studentRoll": studentRoll,
        "studentProfileLink": studentProfileLink,
        "studentUid": studentUid,
        "studentClass": studentClass,
      };
}
