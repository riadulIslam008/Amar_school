//?? ============== End Drawer ================= */
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/EndDrawer.dart';

//?? ============== Message Box Section ================= */
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/MessageBoxSection.dart';

//?? ============== Message layout ================= */
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/Message_Layout.dart';

//?? ============== Controller ================= */
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherViewChatScreen extends GetWidget<GroupChatScreenController> {
  final teacherInfo = Get.find<HomeViewController>().teacherInfo;
  final String studentClass = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //*
        //*
        //*
        key: controller.scaffoldKey,
        appBar: appBar(),
        //
        //Todo ─── BODY ────────────────────────────────────────────────────────
        body: Column(
          children: [
            Expanded(
              child: Messagelayout(teacherInfo, false),
            ),
            SizedBox(height: 10),
            MessageBoxsection(
              context: context,
              name: teacherInfo.teacherName,
              standerd: studentClass,
              personProfileImage: teacherInfo.teacherProfileLink,
              isTeacher: true,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
          ],
        ),
        //*
        //*
        //*
        endDrawer: EndDrawer(
            classStanderd: studentClass,
            isStudent: false,
            context: context,
            teacherModel: teacherInfo),
      ),
    );
  }

  //*
  //*
  //Todo ================== AppBar ====================##
  //*
  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back),
      ),
      title: Text(studentClass),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          // onPressed: () => controller.liveStream(teacherInfo.teacherName,
          //     studentClass, teacherInfo.teacherProfileLink),
          icon: Icon(Icons.live_tv),
          tooltip: "Live stream",
        ),
        SizedBox(width: 10),
        IconButton(
          onPressed: () => controller.openDrawer(),
          icon: Icon(Icons.people_outline),
          tooltip: "Group members",
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
