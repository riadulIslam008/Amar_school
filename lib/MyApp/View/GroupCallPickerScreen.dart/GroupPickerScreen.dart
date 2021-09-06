import 'package:amer_school/MyApp/Services/VideoCallApi.dart';
import 'package:amer_school/MyApp/View/GroupCall/GroupCall.dart';
import 'package:amer_school/MyApp/controller/CallController.dart';
import 'package:amer_school/MyApp/model/GroupCallModel.dart';
import 'package:amer_school/MyApp/model/StudentDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class GroupCallPickerScreen extends StatelessWidget {
  final VideoCallModel groupCallModel;
  final StudentDetailsModel studentDetailsModel;

  GroupCallPickerScreen(
      {Key key,
      @required this.groupCallModel,
      @required this.studentDetailsModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              Text("Incoming....", style: TextStyle(fontSize: 30)),
              SizedBox(height: 50),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
              ),
              SizedBox(height: 15),
              Text("${groupCallModel.subject} Teacher"),
              SizedBox(height: 15),
              Text("${groupCallModel.teacherName} invite you a Group Call"),
              SizedBox(height: 75),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.call_end),
                    color: Colors.redAccent,
                    onPressed: () async {},
                  ),
                  SizedBox(width: 25),
                  IconButton(
                    icon: Icon(Icons.call),
                    color: Colors.green,
                    onPressed: () async {
                      await Permission.camera.request();
                      await Permission.microphone.request();
                      await VideoCallApi().addMembersInGroup(
                        studentClass: groupCallModel.channelName,
                        studentName: studentDetailsModel.studentName,
                        studentRoll: studentDetailsModel.studentRoll,
                      );
                      // ignore: await_only_futures
                      await Get.put(CallController(
                          channelName: groupCallModel.channelName, isTeacher: false));
                      Get.to(() => GroupCall());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
