import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/presentation/Profile_Section/Profile_Controller.dart';
import 'package:amer_school/App/presentation/Profile_Section/Widget/CardWidget.dart';
import 'package:amer_school/App/presentation/Profile_Section/Widget/Profile_Image.dart';
import 'package:amer_school/App/presentation/Profile_Section/Widget/Quetos_Section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentProfileView extends GetWidget<ProfileController> {
  final StudentModelEntity studentDetailsModel = Get.arguments;
  StudentProfileView({Key key}) : super(key: key);

  final SizedBox _height = SizedBox(height: 15);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile Details"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: controller.boxSize,
                child: Stack(
                  children: [
                    QuetoesSection(
                        controller.screenWidth, controller.boxSize - 50, ""),
                    ProfileImage(studentDetailsModel.studentProfileLink),
                  ],
                ),
              ),
              _height,
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CardWidget(
                      text: studentDetailsModel.studentName.toUpperCase(),
                      iconData: Icons.person,
                      textSize: 20,
                    ),
                    _height,
                    CardWidget(
                      text: "Roll:- ${studentDetailsModel.studentRoll}",
                      iconData: Icons.rice_bowl_outlined,
                    ),
                    _height,
                    CardWidget(
                      text: studentDetailsModel.studentClass,
                      iconData: Icons.class__outlined,
                    ),
                    _height,
                    CardWidget(
                      text: "LOGOUT",
                      iconData: Icons.logout_outlined,
                      color: Colors.red,
                      onTap: () => controller.logout(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
