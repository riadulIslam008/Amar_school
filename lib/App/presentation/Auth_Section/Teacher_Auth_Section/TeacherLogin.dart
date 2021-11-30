import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/TextFieldWidget.dart';
import 'package:amer_school/App/presentation/Auth_Section/Teacher_Auth_Section/TeacherViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherLogin extends GetWidget<TeacherViewController> {
  final _height = Get.height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: _height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
    );
  }
}
