import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EndDrawer extends GetWidget<GroupChatScreenController> {
  final bool isStudent;
  final String classStanderd;
  final BuildContext context;
  final TeacherDetailsModel teacherModel;

  EndDrawer(
      {Key key,
      @required this.classStanderd,
      @required this.isStudent,
      this.context,
      this.teacherModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 20),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close, color: Colors.white),
                color: Colors.grey,
                padding: const EdgeInsets.all(0),
              ),
            ),
            title: isStudent ? Text("Student List") : Text("Group Call"),
            trailing: isStudent
                ? Icon(null)
                : IconButton(
                    onPressed: () => controller.groupCall(
                      classStaderd: classStanderd,
                      teacherModel: teacherModel,
                    ),
                    icon: Icon(Icons.video_call),
                  ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 10),
          Obx(
            () => controller.studentList.isEmpty
                ? Center(
                    child: Text("No student add Yet!"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.studentList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                            controller.studentList[index]["profileImage"],
                          ),
                        ),
                        title: Text(
                          "${controller.studentList[index]["name"]}"
                              .capitalizeFirst,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: Text(
                          "Roll: ${controller.studentList[index]["roll"]}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
