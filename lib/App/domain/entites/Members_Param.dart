import 'package:equatable/equatable.dart';

class MembersModelEntity extends Equatable {
  final String name, profilePic;
  final int roll;

  MembersModelEntity({this.name, this.roll, this.profilePic});
  @override
  List<Object> get props => [name, roll];
}
