import 'dart:io';

import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/Widgets/DropDown_Section.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/TextFieldWidget.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/Widget/TextButtonWidget.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/studentLogin.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/StudentViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StudentSignup extends GetWidget<StudentViewController> {
  final SizedBox emptySpace = SizedBox(height: 15.0);
  final List<String> classList = <String>[
    "Select a Class",
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9",
    "Class 10",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       // resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 60,
                        backgroundImage: controller.file.value == ""
                            ? AssetImage("assets/personAvatar.jpeg")
                            : FileImage(
                                File(controller.file.value),
                              ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.yellow[900],
                      child: IconButton(
                        onPressed: () => showDialogButton(context),
                        icon: Icon(Icons.camera_alt),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  titleName: "Full Name",
                  maxLine: 1,
                  controller: controller.fullNameController,
                ),
                emptySpace,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        titleName: "Roll Number",
                        maxLine: 1,
                        controller: controller.rollController,
                      ),
                    ),
                    SizedBox(width: 15),
                    DropDownSection(),
                  ],
                ),
                emptySpace,
                TextFieldWidget(
                  titleName: "password",
                  maxLine: 1,
                  controller: controller.passwordController,
                ),
                emptySpace,
                TextFieldWidget(
                  titleName: "Confrim Password",
                  maxLine: 1,
                  controller: controller.confrimPasswordController,
                ),
                emptySpace,
                MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.yellow[900],
                  onPressed: () => controller.signUP(
                      standerdSection: controller.fristItemClassListVariable),
                  child: Text("SIGNUP"),
                ),
                emptySpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Already Have An Account ?"),
                    TextButton(
                      onPressed: () {
                        Get.off(() => StudentLogin());
                      },
                      child: Text("LOGIN"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDialogButton(context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButtonWidget(
                buttonText: "Camera",
                onclick: () {
                  controller.pickImage(imageSource: ImageSource.camera);
                },
              ),
              Divider(thickness: 1, color: Colors.grey),
              TextButtonWidget(
                buttonText: "Gallery",
                onclick: () {
                  controller.pickImage(imageSource: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
