import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class StudentModelEntity extends Equatable {
  final String studentName;
  final String studentRoll;
  final String studentProfileLink;
  final String studentUid;
  final String studentClass;

  StudentModelEntity({
    @required this.studentName,
    @required this.studentRoll,
    @required this.studentProfileLink,
    @required this.studentUid,
    @required this.studentClass,
  });

  @override
  List<Object> get props => [];
}
