import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';

class TeacherProfileArguments {
  final TeacherModelEntity teacherModelEntity;
  final bool fromTeacherList;

  TeacherProfileArguments(this.teacherModelEntity, this.fromTeacherList);
}
