// To parse this JSON data, do
//
//     final videoFileModel = videoFileModelFromJson(jsonString);

import 'dart:convert';

VideoCallModel videoFileModelFromJson(String str) =>
    VideoCallModel.fromJson(json.decode(str));

String videoCallModelToJson(VideoCallModel data) => json.encode(data.toJson());

class VideoCallModel {
  VideoCallModel({
    this.channelName,
    this.teacherName,
    this.teacherProfilePic,
    this.subject,
    this.hasReceive,
    this.cutCall,
  });

  String channelName;
  String teacherName;
  String teacherProfilePic;
  String subject;
  bool hasReceive;
  bool cutCall;

  factory VideoCallModel.fromJson(Map<String, dynamic> json) => VideoCallModel(
        channelName: json["channelName"],
        teacherName: json["teacherName"],
        teacherProfilePic: json["teacherProfilePic"],
        subject: json["subject"],
        hasReceive: json["hasReceive"],
        cutCall: json["cutCall"],
      );

  Map<String, dynamic> toJson() => {
        "channelName": channelName,
        "teacherName": teacherName,
        "teacherProfilePic": teacherProfilePic,
        "subject": subject,
        "hasReceive": hasReceive,
        "cutCall": cutCall,
      };
}
