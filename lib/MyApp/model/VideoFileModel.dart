// To parse this JSON data, do
//
//     final videoFileModel = videoFileModelFromJson(jsonString);

import 'dart:convert';

VideoFileModel videoFileModelFromJson(String str) =>
    VideoFileModel.fromJson(json.decode(str));

String videoFileModelToJson(VideoFileModel data) => json.encode(data.toJson());

class VideoFileModel {
  VideoFileModel({
    this.videoTitle,
    this.thumbnailImageLink,
    this.videoFileLink,
    this.videoDescription,
    this.date,
    this.classNumber,
    this.teacherProfileImage,
  });

  String videoTitle;
  String thumbnailImageLink;
  String videoFileLink;
  String videoDescription;
  String date;
  String classNumber;
  String teacherProfileImage;

  factory VideoFileModel.fromJson(Map<String, dynamic> json) => VideoFileModel(
        videoTitle: json["videoTitle"],
        thumbnailImageLink: json["thumbnailImageLink"],
        videoFileLink: json["videoFileLink"],
        videoDescription: json["videoDescription"],
        date: json["date"],
        classNumber: json["classNumber"],
        teacherProfileImage: json["teacherProfileImage"],
      );

  Map<String, dynamic> toJson() => {
        "videoTitle": videoTitle,
        "thumbnailImageLink": thumbnailImageLink,
        "videoFileLink": videoFileLink,
        "videoDescription": videoDescription,
        "date": date,
        "classNumber": classNumber,
        "teacherProfileImage": teacherProfileImage,
      };
}
