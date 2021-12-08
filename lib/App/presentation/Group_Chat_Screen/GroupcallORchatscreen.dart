import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/presentation/Group_Call_Picker_Screen/GroupPickerScreen.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Student_Chat/StudentchatScreen.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/MyApp/Services/VideoCallApi.dart';
import 'package:amer_school/MyApp/model/GroupCallModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GroupCallORchatScreen extends StatelessWidget {
  final VideoCallApi _videocallApi = VideoCallApi();
  VideoCallModel groupCallModel;

  final _homeController = Get.find<HomeViewController>();
  @override
  Widget build(BuildContext context) {
    final StudentModelEntity _studentModelEntity = _homeController.studentModel;
    return StreamBuilder(
        stream: _videocallApi.callStream(_studentModelEntity.studentClass),
        builder: (context, snapshots) {
          if (snapshots.hasData && snapshots.data.data() != null) {
            groupCallModel =
                VideoCallModel.fromJson(snapshots.data.data()["teacherInfo"]);

            if (groupCallModel.cutCall == false) {
              return GroupCallPickerScreen(
                groupCallModel: groupCallModel,
                studentDetailsModel: _studentModelEntity,
              );
            }
          }
          return StudentChatScreen();
        });
  }
}
