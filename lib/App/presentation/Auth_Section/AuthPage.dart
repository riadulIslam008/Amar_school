import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/presentation/Auth_Section/Widgets/ButtonWidget.dart';
import 'package:amer_school/App/presentation/Home_Section/HomePageView.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthPage extends StatelessWidget {
    final GetStorage getStorage = GetStorage();
  @override
  Widget build(BuildContext context)  {
    return getStorage.read(TEACHER_UID) != null
        ? HomePageView(true)
        : getStorage.read(STUDENT_UID) != null
            ? HomePageView(false)
            : Scaffold(
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
