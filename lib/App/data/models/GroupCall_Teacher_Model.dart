import 'dart:convert';

import 'package:amer_school/App/domain/entites/GroupCall_Teacher_Model_Entity.dart';

class GroupCallTeacherModel extends GroupCallTeacherModelEntity {
  final String teacherName;
  final String teacherProfile;

  GroupCallTeacherModel(
    this.teacherName,
    this.teacherProfile,
  ) : super(teacherName, teacherProfile);

  Map<String, dynamic> toMap() {
    return {
      'teacherName': teacherName,
      'teacherProfile': teacherProfile,
    };
  }

  factory GroupCallTeacherModel.fromMap(Map<String, dynamic> map) {
    return GroupCallTeacherModel(
      map['teacherName'] ?? '',
      map['teacherProfile'] ?? '',
    );
  }

  factory GroupCallTeacherModel.fromTeacherEntity(
          GroupCallTeacherModelEntity _teacherEntity) =>
      GroupCallTeacherModel(
        _teacherEntity.teacherName,
        _teacherEntity.teacherProfile,
      );

  String toJson() => json.encode(toMap());

  factory GroupCallTeacherModel.fromJson(String source) =>
      GroupCallTeacherModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'GroupCallTeacherModel(teacherName: $teacherName, teacherProfile: $teacherProfile)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupCallTeacherModel &&
        other.teacherName == teacherName &&
        other.teacherProfile == teacherProfile;
  }

  @override
  int get hashCode => teacherName.hashCode ^ teacherProfile.hashCode;
}
