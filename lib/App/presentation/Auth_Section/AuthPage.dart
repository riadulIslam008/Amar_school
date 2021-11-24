import 'package:amer_school/App/presentation/Auth_Section/Widgets/ButtonWidget.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
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
                onclick: () => Get.toNamed(Routes.TeacherLogin)),
            SizedBox(height: 20),
            ButtonWidget(
              buttonText: "STUDENT",
              onclick: () => Get.toNamed(Routes.StudentLogin),
            ),
          ],
        ),
      ),
    );
  }
}
