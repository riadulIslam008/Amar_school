import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TeacherModelEntity extends Equatable {
  final String quetosForStudent;
  final String teacherName;
  final String teacherProfileLink;
  final String teacherSubject;
  final String teacherUid;
  final String mobileNumber;

  TeacherModelEntity({
    @required this.quetosForStudent,
    @required this.teacherName,
    @required this.teacherProfileLink,
    @required this.teacherSubject,
    @required this.teacherUid,
    @required this.mobileNumber,
  });

  @override
  List<Object> get props => [];
}
