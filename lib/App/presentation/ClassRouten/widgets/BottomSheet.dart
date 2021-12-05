import 'package:amer_school/App/presentation/ClassRouten/widgets/TexEditing.dart';
import 'package:amer_school/App/presentation/ClassRouten/ClassRoutenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomModal extends GetWidget<RoutenController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.black,
      child: ListView(
        children: [
          SizedBox(height: 10),
          TextEditing(
              hintText: "Full Name",
              controller: controller.teacherNameController),
          SizedBox(height: 10),
          TextEditing(
              hintText: "Subject", controller: controller.subjectController),
          SizedBox(height: 10),
          TextEditing(
              hintText: "24 hour format",
              controller: controller.timeController),
          SizedBox(height: 10),
          TextEditing(
              hintText: "01-Dec-2000", controller: controller.dateController),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              color: Colors.blueGrey,
              onPressed: () {
                controller.onSavedRouten(
                  teacherName: controller.teacherNameController.value.text,
                  subject: controller.subjectController.value.text,
                  time: controller.timeController.value.text,
                  date: controller.dateController.value.text,
                );
              },
              child: Text("Save"),
            ),
          ),
          // SizedBox(height: 10),
        ],
      ),
    );
  }
}
