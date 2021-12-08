//?? =========== Teacher Model Entity =========== */
import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';

//?? ============== Controller ================= */
import 'package:amer_school/App/presentation/Profile_Section/Profile_Controller.dart';

//?? ============== Widgets ================= */
import 'package:amer_school/App/presentation/Profile_Section/Widget/CardWidget.dart';
import 'package:amer_school/App/presentation/Profile_Section/Widget/Profile_Image.dart';
import 'package:amer_school/App/presentation/Profile_Section/Widget/Quetos_Section.dart';

//?? ============== Packages ================= */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherProfileView extends GetWidget<ProfileController> {
  final TeacherModelEntity _teacherModelEntity = Get.arguments[0];
  final bool comeFromTeacherList = Get.arguments[1];

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
              SizedBox(height: 5),
              Container(
                height: controller.boxSize,
                child: Stack(
                  children: [
                    QuetoesSection(
                      controller.screenWidth,
                      controller.boxSize - 50,
                      _teacherModelEntity.quetosForStudent,
                    ),
                    ProfileImage(_teacherModelEntity.teacherProfileLink),
                  ],
                ),
              ),
              _height,
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CardWidget(
                      text: _teacherModelEntity.teacherName.toUpperCase(),
                      iconData: Icons.person,
                      textSize: 20,
                    ),
                    _height,
                    CardWidget(
                      text: "${_teacherModelEntity.teacherSubject} Teacher",
                      iconData: Icons.subject,
                    ),
                    _height,
                    CardWidget(
                      text: _teacherModelEntity.mobileNumber,
                      iconData: Icons.mobile_friendly_outlined,
                      onTap: makeCall,
                      trailingIcon: comeFromTeacherList ? Icons.call : null,
                    ),
                    _height,
                    comeFromTeacherList
                        ? Container()
                        : CardWidget(
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

  makeCall() {
    if (comeFromTeacherList) {
      final int number = int.parse(_teacherModelEntity.mobileNumber);
      launch('tel://$number');
      return;
    } else {
      return;
    }
  }
}
