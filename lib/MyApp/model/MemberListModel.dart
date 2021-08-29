// To parse this JSON data, do
//
//     final memberListModel = memberListModelFromJson(jsonString);

import 'dart:convert';

MemberListModel memberListModelFromJson(String str) => MemberListModel.fromJson(json.decode(str));

String memberListModelToJson(MemberListModel data) => json.encode(data.toJson());

class MemberListModel {
    MemberListModel({
        this.studentName,
        this.studentRool,
        this.studentProfile,
    });

    String studentName;
    int studentRool;
    String studentProfile;

    factory MemberListModel.fromJson(Map<String, dynamic> json) => MemberListModel(
        studentName: json["studentName"],
        studentRool: json["studentRool"],
        studentProfile: json["studentProfile"],
    );

    Map<String, dynamic> toJson() => {
        "studentName": studentName,
        "studentRool": studentRool,
        "studentProfile": studentProfile,
    };
}
