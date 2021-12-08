import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';
import 'package:amer_school/App/presentation/Teacher_List/Teacher_list_Controller.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherList extends GetWidget<TeacherListController> {
  @override
  Widget build(BuildContext context) {
    TeacherModelEntity _teacherModelEntity;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Teacher List"),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: controller.teacherList.length,
            itemBuilder: (_, index) {
              _teacherModelEntity = controller.teacherList[index];
              return Card(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                elevation: 5,
                child: ListTile(
                  title: Text(_teacherModelEntity.teacherName.toUpperCase()),
                  subtitle:
                      Text("${_teacherModelEntity.teacherSubject} Teacher"),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[400],
                    backgroundImage: CachedNetworkImageProvider(
                      _teacherModelEntity.teacherProfileLink,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Get.toNamed(Routes.TEACHER_PROFILE,
                        arguments: [_teacherModelEntity, true]);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
