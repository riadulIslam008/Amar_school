import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PersonParam extends Equatable {
  final StudentModelEntity personInfo;
  final String userUid;
  final String personType;

  PersonParam(
      {@required this.personInfo,
      @required this.userUid,
      @required this.personType});

  @override
  List<Object> get props => [];
}
