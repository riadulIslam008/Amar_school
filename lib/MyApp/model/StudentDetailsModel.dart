
// To parse this JSON data, do
//
//     final studentDetailsModel = studentDetailsModelFromJson(jsonString);

import 'dart:convert';

StudentDetailsModel studentDetailsModelFromJson(String str) => StudentDetailsModel.fromJson(json.decode(str));

String studentDetailsModelToJson(StudentDetailsModel data) => json.encode(data.toJson());

class StudentDetailsModel {
    StudentDetailsModel({
        this.studentName,
        this.studentRoll,
        this.studentProfileLink,
        this.studentUid,
        this.studentClass,
    });

    String studentName;
    String studentRoll;
    String studentProfileLink;
    String studentUid;
    String studentClass;

    factory StudentDetailsModel.fromJson(Map<String, dynamic> json) => StudentDetailsModel(
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
