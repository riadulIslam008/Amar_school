import 'package:amer_school/MyApp/Services/VideoCallApi.dart';
import 'package:amer_school/MyApp/View/GroupCallPickerScreen.dart/GroupPickerScreen.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/StudentchatScreen.dart';
import 'package:amer_school/MyApp/model/GroupCallModel.dart';
import 'package:amer_school/App/data/models/StudentDetailsModel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GroupCallORchatScreen extends StatelessWidget {
  final StudentDetailsModel studentDetailsModel;
  GroupCallORchatScreen({this.studentDetailsModel});

  final VideoCallApi _videocallApi = VideoCallApi();
  VideoCallModel groupCallModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _videocallApi.callStream(studentDetailsModel.studentClass),
        builder: (context, snapshots) {
          if (snapshots.hasData && snapshots.data.data() != null) {
            groupCallModel =
                VideoCallModel.fromJson(snapshots.data.data()["teacherInfo"]);

            if (groupCallModel.cutCall == false) {
              return GroupCallPickerScreen(
                groupCallModel: groupCallModel,
                studentDetailsModel: studentDetailsModel,
              );
            }
          }
          return StudentChatScreen(studentDetailsModel: studentDetailsModel);
        });
  }
}
