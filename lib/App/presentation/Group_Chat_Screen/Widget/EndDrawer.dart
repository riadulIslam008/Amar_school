import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EndDrawer extends GetWidget<GroupChatScreenController> {
  final bool isStudent;
  final String classStanderd;
  final BuildContext context;
  final TeacherDetailsModel teacherModel;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  EndDrawer(
      {Key key,
      @required this.classStanderd,
      @required this.isStudent,
      this.context,
      this.teacherModel})
      : super(key: key);

  List membersList = [];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: membersList.isEmpty
          ? FutureBuilder(
              future: _firebaseFirestore
                  .collection("groups")
                  .doc(classStanderd)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                membersList = snapshot.data.data()["members"];
                return (snapshot.hasData)
                    ? drawerUI()
                    : Center(child: CircularProgressIndicator());
              },
            )
          : drawerUI(),
    );
  }

  Column drawerUI() {
    return Column(
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
          title: isStudent ? Text("student List") : Text("Group Call"),
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
        ListView.builder(
          shrinkWrap: true,
          itemCount: membersList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(membersList[index]["profileImage"])
              ),
              title: Text(
                "${membersList[index]["name"]}".capitalizeFirst,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                "Roll: ${membersList[index]["Roll"]}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
