import 'package:equatable/equatable.dart';

class GroupCallTeacherModelEntity extends Equatable {
  final String teacherName;
  final String teacherProfile;

  GroupCallTeacherModelEntity(this.teacherName, this.teacherProfile);
  
  @override
  List<Object> get props => [teacherName];
}
