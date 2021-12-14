import 'dart:convert';

import 'package:amer_school/App/domain/entites/Members_Param.dart';

class MembersListModel extends MembersModelEntity {
  final String name;
  final String profilePic;
  final int roll;

  MembersListModel(
    this.name,
    this.profilePic,
    this.roll,
  ) : super(
          name: name,
          profilePic: profilePic,
          roll: roll,
        );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'roll': roll,
    };
  }

  factory MembersListModel.fromMembersListEntity(
          MembersModelEntity membersModelEntity) =>
      MembersListModel(membersModelEntity.name, membersModelEntity.profilePic,
          membersModelEntity.roll);

  factory MembersListModel.fromMap(Map<String, dynamic> map) =>
      MembersListModel(
        map['name'],
        map['profilePic'],
        map['roll'],
      );

  String toJson() => json.encode(toMap());

  factory MembersListModel.fromJson(String source) =>
      MembersListModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MembersListModel(name: $name, profilePic: $profilePic, roll: $roll)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MembersListModel &&
        other.name == name &&
        other.profilePic == profilePic &&
        other.roll == roll;
  }

  @override
  int get hashCode => name.hashCode ^ profilePic.hashCode ^ roll.hashCode;
}
