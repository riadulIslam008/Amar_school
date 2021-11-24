import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AddMemberParam extends Equatable {
  final String name, roll, standerd, profilePic;

  AddMemberParam({
    @required this.name,
    @required this.roll,
    @required this.standerd,
    @required this.profilePic,
  });
  @override
  List<Object> get props => [];
}
