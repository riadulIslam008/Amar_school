// To parse this JSON data, do
//
//     final videoFileModel = videoFileModelFromJson(jsonString);

import 'dart:convert';

import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
import 'package:flutter/material.dart';

VideoFileModel videoFileModelFromJson(String str) =>
    VideoFileModel.fromJson(json.decode(str));

String videoFileModelToJson(VideoFileModel data) => json.encode(data.toJson());

class VideoFileModel extends VideoFileEntity {
  VideoFileModel({
    @required this.videoTitle,
    @required this.thumbnailImageLink,
    @required this.videoFileLink,
    @required this.videoDescription,
    @required this.date,
    @required this.classNumber,
    @required this.teacherProfileImage,
  }) : super(
          videoTitle,
          thumbnailImageLink,
          videoFileLink,
          videoDescription,
          date,
          classNumber,
          teacherProfileImage,
        );

  final String videoTitle;
  final String thumbnailImageLink;
  final String videoFileLink;
  final String videoDescription;
  final String date;
  final String classNumber;
  final String teacherProfileImage;

  factory VideoFileModel.fromVideoFileEntity(VideoFileEntity videoFileEntity) {
    return VideoFileModel(
        videoTitle: videoFileEntity.videoTitle,
        thumbnailImageLink: videoFileEntity.thumbnailImageLink,
        videoFileLink: videoFileEntity.videoFileLink,
        videoDescription: videoFileEntity.videoDescription,
        date: videoFileEntity.date,
        classNumber: videoFileEntity.classNumber,
        teacherProfileImage: videoFileEntity.teacherProfileImage);
  }

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
