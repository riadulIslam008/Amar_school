import 'package:equatable/equatable.dart';

class VideoFileEntity extends Equatable {
  final String videoTitle;
  final String thumbnailImageLink;
  final String videoFileLink;
  final String videoDescription;
  final String date;
  final String classNumber;
  final String teacherProfileImage;

  VideoFileEntity(
    this.videoTitle,
    this.thumbnailImageLink,
    this.videoFileLink,
    this.videoDescription,
    this.date,
    this.classNumber,
    this.teacherProfileImage,
  );

  @override
  List<Object> get props => [videoTitle];
}
