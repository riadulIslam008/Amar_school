import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/EndDrawer.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/MessageBoxSection.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/Message_Layout.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentChatScreen extends GetWidget<GroupChatScreenController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: appBar(),
        body: Column(
          children: [
            Expanded(
                child: Messagelayout(controller.studentDetailsModel, true)),
            SizedBox(height: 10),
            MessageBoxsection(
              context: context,
              name: controller.studentDetailsModel.studentName,
              standerd: controller.studentDetailsModel.studentClass,
              personProfileImage:
                  controller.studentDetailsModel.studentProfileLink,
              isTeacher: false,
            ),
            SizedBox(height: Get.height * 0.01),
          ],
        ),
        //*
        //*
        //*
        endDrawer: EndDrawer(
            classStanderd: controller.studentDetailsModel.studentClass,
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
      title: Text(controller.studentDetailsModel.studentClass),
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
          hintText: "Write Teacher Name",
        ),
      ),
      textCancel: "Cencel",
      onCancel: () {
        Get.isDialogOpen;
        controller.channelNameController.clear();
      },
      textConfirm: "Confrim",
      onConfirm: () async {
        if (controller.channelNameController.text != null)
          controller.liveStreamConfrimForStudent(
            channelId: controller.channelNameController.text,
          );
      },
    );
  }
}
