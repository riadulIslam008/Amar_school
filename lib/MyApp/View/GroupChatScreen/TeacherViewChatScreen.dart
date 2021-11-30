import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/Widget/EndDrawer.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/Widget/MessageBoxSection.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/Widget/MessageShowDerection.dart';
import 'package:amer_school/MyApp/controller/GroupChatScreenController.dart';
import 'package:amer_school/MyApp/model/MessageModel.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherViewChatScreen extends GetWidget<GroupChatScreenController> {
  final TeacherDetailsModel teacherInfo;
  final String studentClass;

  TeacherViewChatScreen({this.teacherInfo, this.studentClass});

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final controller = Get.put(GroupChatScreenController());

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
       // ─── BODY ────────────────────────────────────────────────────────
       //
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _firebaseFirestore
                    .collection("groups")
                    .doc(studentClass)
                    .collection(CHAT)
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context, snapShot) {
                  if (snapShot.hasError) return Container(color: Colors.red);

                  return (snapShot.hasData)
                      ? ListView.builder(
                          itemCount: snapShot.data.docs.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            //*
                            //*
                            //*
                            controller.listBool.add(false);

                            MessageModel messageModel = MessageModel.fromJson(
                                snapShot.data.docs[index].data());

                            bool sendByMe =
                                messageModel.sendBy == teacherInfo.teacherName;

                            Color _color =
                                (sendByMe) ? Colors.blue : Colors.grey;

                            Color teacherMessageColor =
                                messageModel.sendByStudent
                                    ? _color
                                    : Colors.teal;

                            Alignment _alignment = sendByMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft;

                            final BorderRadius borderRadius = sendByMe
                                ? BorderRadius.circular(10)
                                : BorderRadius.circular(10);   
                            //*
                            //*
                            //*
                            return Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text("${messageModel.date}"
                                        .split(" ")[1]
                                        .substring(0, 5)),
                                  ),
                                  // layout,
                                  MessageShow(
                                    messageColor: teacherMessageColor,
                                    borderRadius: borderRadius,
                                    sendBy: sendByMe,
                                    messageType: messageModel.type,
                                    index: index,
                                    personProfileLink: messageModel.personProfilLink,
                                    message: messageModel.message,
                                    imageUrl: messageModel.imageLink,
                                  ),
                                  Obx(
                                    () => Visibility(
                                      visible: controller.listBool[index],
                                      child: Container(
                                        padding: EdgeInsets.only(left: 20),
                                        alignment: _alignment,
                                        margin: EdgeInsets.only(top: 5),
                                        child: messageModel.sendByStudent
                                            ? Text(
                                                "sendBy ${messageModel.sendBy}")
                                            : Text(
                                                "sendBy Sir ${messageModel.sendBy}"),
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Visibility(
                                      visible: controller.listBool[index],
                                      child: Container(
                                        padding: EdgeInsets.only(left: 20),
                                        alignment: _alignment,
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text("${messageModel.date}"
                                            .substring(0, 10)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
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
          onPressed: () => controller.liveStream(teacherInfo.teacherName,
              studentClass, teacherInfo.teacherProfileLink),
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
  //*
  //*

}
