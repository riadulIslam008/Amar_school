//?? ============== End Drawer ================= */
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/Core/useCases/App_Permission.dart';
import 'package:amer_school/App/Core/useCases/Global_Key.dart';
import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/EndDrawer.dart';

//?? ============== Message Box Section ================= */
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/MessageBoxSection.dart';

//?? ============== Message layout ================= */
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/Message_Layout.dart';

//?? ============== Controller and Packages ================= */
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class TeacherViewChatScreen extends GetWidget<GroupChatScreenController> {
  final String studentClass = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //*
        //*
        //*
        key: scaffoldKey,
        appBar: appBar(),
        //
        //Todo ─── BODY ────────────────────────────────────────────────────────
        body: Column(
          children: [
            Expanded(
              child: Messagelayout(controller.teacherInfo, false),
            ),
            SizedBox(height: 10),
            MessageBoxsection(
              context: context,
              name: controller.teacherInfo.teacherName,
              standerd: studentClass,
              personProfileImage: controller.teacherInfo.teacherProfileLink,
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
            teacherModel: controller.teacherInfo),
      ),
    );
  }

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
          onPressed: () async {
            bool camPer = await cameraPermission().isGranted;
            bool micPer = await microPhonePermission().isGranted;
            if (camPer && micPer) {
              controller.liveStream(
                controller.teacherInfo.teacherName,
                studentClass,
                controller.teacherInfo.teacherProfileLink,
              );
            } else {
              errorDialogBox(description: CAMERA_AND_MICROPHONE);
            }
          },
          icon: Icon(Icons.live_tv),
          tooltip: "Live stream",
        ),
        SizedBox(width: 10),
        IconButton(
          onPressed: () => scaffoldKey.currentState.openEndDrawer(),
          icon: Icon(Icons.people_outline),
          tooltip: "Group members",
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
