import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:amer_school/App/domain/entites/Group_List_Model_Entity.dart';

class GroupListModel extends GroupModelEntity {
  final String groupName;
  final List members;

  GroupListModel(
    this.groupName,
    this.members,
  ) : super(
          groupName,
          members,
        );

  Map<String, dynamic> toMap() {
    return {
      'groupName': groupName,
      'members': members,
    };
  }

  factory GroupListModel.fromGroupModelEntity(
      GroupModelEntity groupModelEntity) {
    return GroupListModel(
      groupModelEntity.groupName,
      groupModelEntity.memberList,
    );
  }

  factory GroupListModel.fromMap(Map<String, dynamic> map) {
    return GroupListModel(
      map['groupName'],
      List.from(map['members']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupListModel.fromJson(String source) =>
      GroupListModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'GroupListModel(groupName: $groupName, members: $members)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupListModel &&
        other.groupName == groupName &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode => groupName.hashCode ^ members.hashCode;
}
