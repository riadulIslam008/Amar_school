import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/Widget/EndDrawer.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/Widget/MessageBoxSection.dart';
import 'package:amer_school/MyApp/controller/GroupChatScreenController.dart';
import 'package:amer_school/MyApp/model/MessageModel.dart';
import 'package:amer_school/MyApp/model/TeacherDetailsModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        //*
        //*
        //*
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

                            final BorderRadius _borderRadius = sendByMe
                                ? BorderRadius.circular(10)
                                : BorderRadius.circular(10);

                            Row layout = sendByMe
                                ? Row(
                                    children: [
                                      Expanded(child: Container()),
                                      GestureDetector(
                                        onTap: () => controller.visiable(index),
                                        child: messageModel.type == "message"
                                            ? Container(
                                                padding: EdgeInsets.all(10),
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius: _borderRadius,
                                                  color: teacherMessageColor,
                                                ),
                                                constraints: BoxConstraints(
                                                  maxWidth: Get.width / 2,
                                                ),
                                                child:
                                                    Text(messageModel.message))
                                            : CachedNetworkImage(
                                                imageUrl:
                                                    messageModel.imageLink,
                                                fit: BoxFit.fill),
                                      ),
                                      SizedBox(width: 10),
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.black54,
                                        backgroundImage: messageModel
                                                    .personProfilLink !=
                                                null
                                            ? NetworkImage(
                                                messageModel.personProfilLink)
                                            : AssetImage(
                                                "assets/personAvatar.jpeg"),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.black54,
                                        backgroundImage: messageModel
                                                    .personProfilLink !=
                                                null
                                            ? NetworkImage(
                                                messageModel.personProfilLink)
                                            : AssetImage(
                                                "assets/personAvatar.jpeg"),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () => controller.visiable(index),
                                        child: messageModel.type == "message"
                                            ? Container(
                                                padding: EdgeInsets.all(10),
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius: _borderRadius,
                                                  color: teacherMessageColor,
                                                ),
                                                constraints: BoxConstraints(
                                                  maxWidth: Get.width / 2,
                                                ),
                                                child:
                                                    Text(messageModel.message))
                                            : CachedNetworkImage(
                                                imageUrl:
                                                    messageModel.imageLink,
                                                fit: BoxFit.fill),
                                      ),
                                      Expanded(child: Container())
                                    ],
                                  );
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
                                  layout,
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
            SizedBox(height: Get.height *0.01,),
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
