import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingButton extends StatelessWidget {
  final bool isTeacher;
  const FloatingButton({Key key, @required this.isTeacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isTeacher
        ? FloatingActionButton(
            onPressed: () {
              // Get.toNamed(Routes.UploadFile);
              final controller = Get.find<HomeViewController>();

              controller.fetchVideoCollection();
            },
            tooltip: 'Upload File',
            child: Icon(Icons.cloud_download),
          )
        : FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.TEACHER_LIST);
            },
            tooltip: "Teacher list",
            child: Icon(Icons.people_outline),
          );
  }
}
