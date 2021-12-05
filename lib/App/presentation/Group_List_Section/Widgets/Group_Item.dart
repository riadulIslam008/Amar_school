import 'package:amer_school/App/presentation/Group_List_Section/Widgets/Decoration_Circle.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupItem extends StatelessWidget {
  final String groupName;
  const GroupItem({Key key, this.groupName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        onTap: () {
          Get.toNamed(Routes.TEACHER_CHAT_PAGE, arguments: groupName);
        },
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[800],
          ),
          child: Center(
            child: DecorationCircle(groupName: groupName),
          ),
        ),
        title: Text(groupName),
      ),
    );
  }
}
