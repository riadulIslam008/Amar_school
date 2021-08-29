
// To parse this JSON data, do
//
//     final teacherDetailsModel = teacherDetailsModelFromJson(jsonString);

import 'dart:convert';

TeacherDetailsModel teacherDetailsModelFromJson(String str) => TeacherDetailsModel.fromJson(json.decode(str));

String teacherDetailsModelToJson(TeacherDetailsModel data) => json.encode(data.toJson());

class TeacherDetailsModel {
    TeacherDetailsModel({
        this.quetosForStudent,
        this.teacherName,
        this.teacherProfileLink,
        this.teacherSubject,
        this.teacherUid,
        this.mobileNumber,
    });

    String quetosForStudent;
    String teacherName;
    String teacherProfileLink;
    String teacherSubject;
    String teacherUid;
    String mobileNumber;

    factory TeacherDetailsModel.fromJson(Map<String, dynamic> json) => TeacherDetailsModel(
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