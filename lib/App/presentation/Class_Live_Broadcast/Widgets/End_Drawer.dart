import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/presentation/Class_Live_Broadcast/Broad_Cast_Controller.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentListDrawer extends GetWidget<BroadCastController> {
  final BuildContext context;
  const StudentListDrawer({Key key, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: double.infinity,
        color: Colors.transparent.withOpacity(0.9),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.transparent.withOpacity(0.8),
              child: Row(
                children: [
                  Text("LIVE WATCH"),
                  SizedBox(width: 20),
                  Icon(Icons.remove_red_eye),
                  SizedBox(width: 10),
                  Obx(
                    () => Text(controller.streamWacthCounter.value.toString()),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.streamStudentList != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.streamStudentList.length,
                      itemBuilder: (context, index) {
                        StudentModelEntity _viewStudentModel =
                            controller.isStudent
                                ? Get.find<HomeViewController>().studentModel
                                : null;
                        controller.viewStudentIndex = controller.isStudent &&
                                int.parse(_viewStudentModel.studentRoll) ==
                                    controller.streamStudentList[index].roll
                            ? index
                            : -1;
                       
                        return Card(
                          color: Colors.grey[800],
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  Colors.transparent.withOpacity(0.9),
                              backgroundImage: NetworkImage(controller
                                  .streamStudentList[index].profilePic),
                            ),
                            title:
                                Text(controller.streamStudentList[index].name),
                            trailing: Text(
                                "Roll: ${controller.streamStudentList[index].roll}"),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text("No one Join Yet"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
