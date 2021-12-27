import 'package:amer_school/App/domain/entites/GroupCall_Teacher_Model_Entity.dart';
import 'package:equatable/equatable.dart';

class GroupCallTeacherParams extends Equatable {
  final String studentStanderd;
  final GroupCallTeacherModelEntity groupCallTeacherModelEntity;

  GroupCallTeacherParams(this.studentStanderd, this.groupCallTeacherModelEntity);
  @override
  List<Object> get props => [];
}
