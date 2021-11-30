import 'dart:io';

import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/TextFieldWidget.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/Widget/TextButtonWidget.dart';
import 'package:amer_school/App/presentation/Auth_Section/Teacher_Auth_Section/TeacherLogin.dart';
import 'package:amer_school/App/presentation/Auth_Section/Teacher_Auth_Section/TeacherViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TeacherSignUP extends GetWidget<TeacherViewController> {
  final List<String> subject = <String>[
    "Choose a subject",
    "Mathematic",
    "English",
    "Physices",
    "Chemistry",
  ];
  final SizedBox emptySpace = SizedBox(height: 12.0);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 60,
                        backgroundImage: controller.profileFile.value == ""
                            ? AssetImage("assets/personAvatar.jpeg")
                            : FileImage(
                                File(controller.profileFile.value),
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
                        titleName: "Mobile Number",
                        maxLine: 1,
                        controller: controller.mobileController,
                      ),
                    ),
                    SizedBox(width: 15),
                    Obx(
                      () => Expanded(
                        child: DropdownButton(
                          value: controller.fristSubject.value,
                          isExpanded: true,
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
                          items: subject
                              .map(
                                (value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                          onChanged: (currentDistrick) {
                            controller.fristSubject.value = currentDistrick;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                emptySpace,
                TextFieldWidget(
                  titleName: "Quotes for Student",
                  maxLine: 3,
                  controller: controller.quotesController,
                ),

                emptySpace,
                TextFieldWidget(
                  titleName: "Password",
                  maxLine: 1,
                  controller: controller.passwordController,
                ),

                emptySpace,
                //*
                //* ##=========== Button ============== ##
                //*
                MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.blueAccent,
                  onPressed: () => controller.signUP(
                      subjectName: controller.fristSubject.value),
                  child: Text("SIGNUP"),
                ),
                emptySpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Already Have An Account ?"),
                    TextButton(
                      onPressed: () {
                        Get.off(() => TeacherLogin());
                      },
                      child: Text("Login"),
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
