import 'package:equatable/equatable.dart';

class GroupModelEntity extends Equatable {
  final String groupName;
  final List memberList;

  GroupModelEntity(this.groupName, this.memberList);
  @override
  List<Object> get props => [groupName];
}
