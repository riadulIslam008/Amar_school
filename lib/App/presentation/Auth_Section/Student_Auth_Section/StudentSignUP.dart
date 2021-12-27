import 'dart:io';

import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/presentation/DropDown_Section/DropDown_Section.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/TextButtonWidget.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/TextFieldWidget.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/StudentViewController.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StudentSignup extends GetWidget<StudentViewController> {
  static const SizedBox emptySpace = SizedBox(height: 15.0);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    Expanded(child: DropDownSection()),
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
                  onPressed: () => _signUp(),
                  child: Text("SIGNUP"),
                ),
                emptySpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Already Have An Account ?"),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(Routes.STUDENT_SIGN_UP);
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
                  pickImage(imageSource: ImageSource.camera);
                },
              ),
              Divider(thickness: 1, color: Colors.grey),
              TextButtonWidget(
                buttonText: "Gallery",
                onclick: () {
                  pickImage(imageSource: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //Todo ================== Pick Image =====================##
  Future<void> pickImage({@required ImageSource imageSource}) async {
    XFile _response = await ImagePicker().pickImage(source: imageSource);
    if (_response != null) {
      controller.file.value = _response.path;
      controller.imageFile = File(controller.file.value);

      Get.back();
    } else {
      return;
    }
  }

  void _signUp() {
    if (controller.imageFile == null) {
      Get.back();
      return errorDialogBox(description: FILE_IMAGE_ERROR_MESSAGE);
    } else {
      controller.signUP();
    }
  }
}
