import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:amer_school/App/data/models/GroupCall_Teacher_Model.dart';

class GroupCallModel {
  final GroupCallTeacherModel teacherInfo;
  final List membersList;

  GroupCallModel(
    this.teacherInfo,
    this.membersList,
  );

  // GroupCallModel copyWith({
  //   GroupCallTeacherModel teacherInfo,
  //   List membersList,
  // }) {
  //   return GroupCallModel(
  //     teacherInfo ?? this.teacherInfo,
  //     membersList ?? this.membersList,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'teacherInfo': teacherInfo.toMap(),
  //     'membersList': membersList,
  //   };
  // }

  factory GroupCallModel.fromMap(Map<String, dynamic> map) {
    return GroupCallModel(
      GroupCallTeacherModel.fromMap(map['teacherInfo']),
      List.from(map['membersList']),
    );
  }

  //String toJson() => json.encode(toMap());

  factory GroupCallModel.fromJson(String source) => GroupCallModel.fromMap(json.decode(source));

  @override
  String toString() => 'GroupCallModel(teacherInfo: $teacherInfo, membersList: $membersList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GroupCallModel &&
      other.teacherInfo == teacherInfo &&
      listEquals(other.membersList, membersList);
  }

  @override
  int get hashCode => teacherInfo.hashCode ^ membersList.hashCode;
}
