import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/Widgets/DropDown_Section.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/TextFieldWidget.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/StudentViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentLogin extends GetWidget<StudentViewController> {
  final SizedBox emptySpace = SizedBox(height: 15.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFieldWidget(
                titleName: "Full Name",
                maxLine: 1,
                controller: controller.fullNameController,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      titleName: "Roll Number",
                      maxLine: 1,
                      controller: controller.rollController,
                    ),
                  ),
                  SizedBox(width: 20),
                  DropDownSection(),
                ],
              ),
              SizedBox(height: 20),
              TextFieldWidget(
                titleName: "Password",
                maxLine: 1,
                controller: controller.passwordController,
              ),
              SizedBox(height: 20),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.grey,
                onPressed: () => controller.signIN(),
                child: Text("LOGIN"),
              ),
              emptySpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Don't Have An Account ?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.StudentSignin);
                    },
                    child: Text("SIGNUP"),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
