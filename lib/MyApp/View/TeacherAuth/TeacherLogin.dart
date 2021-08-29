import 'package:amer_school/MyApp/View/UpoloadFileView/Widgets/TextFieldWidget.dart';
import 'package:amer_school/MyApp/controller/TeacherViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherLogin extends GetWidget<TeacherViewController> {
  final _height = Get.height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/teacherScreen.png",
                    height: _height * 0.40,
                    width: double.infinity,
                    fit: BoxFit.cover),
                SizedBox(height: 20),
                TextFieldWidget(
                  titleName: "Full Name",
                  maxLine: 1,
                  controller: controller.fullNameController,
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  titleName: "password",
                  maxLine: 1,
                  controller: controller.passwordController,
                ),
                SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("Don't Have An Account ?"),
                //     TextButton(
                //       onPressed: () {
                //         Get.to(() => TeacherSignUP());
                //       },
                //       child: Text("SIGNUP"),
                //     ),
                //   ],
                // ),
                MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.blueGrey,
                  onPressed: () => controller.signIN(),
                  child: Text("SIGNIN"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
