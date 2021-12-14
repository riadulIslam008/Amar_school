import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AddMemberParam extends Equatable {
  final String standerd;
  final membersParam;

  AddMemberParam({
    @required this.standerd,
    @required this.membersParam,
  });
  @override
  List<Object> get props => [];
}
