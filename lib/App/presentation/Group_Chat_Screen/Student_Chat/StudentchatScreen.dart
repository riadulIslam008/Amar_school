import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/presentation/Class_Live_Broadcast/BroadcastPage.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/EndDrawer.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/MessageBoxSection.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/Message_Layout.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/MyApp/Services/VideoCallApi.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class StudentChatScreen extends GetWidget<GroupChatScreenController> {
  final studentDetailsModel = Get.find<HomeViewController>().studentModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: appBar(),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Messagelayout(studentDetailsModel, true),
              ),
            ),
            SizedBox(height: 10),
            MessageBoxsection(
              context: context,
              name: studentDetailsModel.studentName,
              standerd: studentDetailsModel.studentClass,
              personProfileImage: studentDetailsModel.studentProfileLink,
              isTeacher: false,
            ),
            SizedBox(height: Get.height * 0.01),
          ],
        ),
        //*
        //*
        //*
        endDrawer: EndDrawer(
            classStanderd: studentDetailsModel.studentClass,
            isStudent: true,
            context: context),
      ),
    );
  }

  //*
  //Todo ================== AppBar ==================== ##
  //*
  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back),
      ),
      title: Text(studentDetailsModel.studentClass),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => dialogField(),
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

  //*
  //Todo  ================= Dialog ==================== ##
  //*

  Future<Widget> dialogField() async {
    return await Get.defaultDialog(
      title: "Go Live Stream",
      content: TextField(
        controller: controller.channelNameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Teacher Name",
        ),
      ),
      textCancel: "Cencel",
      onCancel: () {
        Get.isDialogOpen;
        controller.channelNameController.clear();
      },
      textConfirm: "Confrim",
      onConfirm: () async {
        if (controller.channelNameController.text != null) {
          await Permission.camera.request();
          await Permission.microphone.request();

          await VideoCallApi().addMembersInStream(
            studentDetailsModel: studentDetailsModel,
            channelName: controller.channelNameController.text
                .replaceAll(" ", "")
                .toLowerCase(),
          );
          Get.to(
            BroadcastPage(
              channelName: controller.channelNameController.text
                  .replaceAll(" ", "")
                  .toLowerCase(),
              role: ClientRole.Audience,
            ),
          );
        } else {
          Get.snackbar("Text Field Error", "TextField should not Error",
              backgroundColor: Colors.red);
        }
      },
    );
  }
}
