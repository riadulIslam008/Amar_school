import 'package:amer_school/MyApp/View/AuthView/widget/ButtonWidget.dart';
import 'package:amer_school/MyApp/View/StudentAuth/studentLogin.dart';
import 'package:amer_school/MyApp/View/TeacherAuth/TeacherLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonWidget(
              buttonText: "TEACHER",
              onclick: () => teacharView(),
            ),
            SizedBox(height: 20),
            ButtonWidget(
              buttonText: "STUDENT",
              onclick: () => studentView(),
            ),
          ],
        ),
      ),
    );
  }


//? ========================= Teacher Button Function ===================##
  void teacharView() {
    Get.offAll(() => TeacherLogin());
  }


//? ========================= Student Button Function ===================##
  void studentView() {
    Get.offAll(() => StudentLogin());
  }
}
