import 'package:amer_school/MyApp/View/StudentAuth/StudentSignUP.dart';
import 'package:amer_school/MyApp/View/UpoloadFileView/Widgets/TextFieldWidget.dart';
import 'package:amer_school/MyApp/controller/StudentViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentLogin extends GetWidget<StudentViewController> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  //
                  // ────────────────────────────────────────────────────────────────────── III ──────────
                  //   :::::: D R O P D O W N   B U T T O N : :  :   :    :     :        :          :
                  // ────────────────────────────────────────────────────────────────────────────────
                  //    
                  Obx(
                    () => Expanded(
                      child: DropdownButton(
                        value: controller.fristItemClassListVariable.value,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                        items: classList
                            .map(
                              (value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (currentDistrick) {
                          controller.fristItemClassListVariable.value =
                              currentDistrick;
                        },
                      ),
                    ),
                  ),
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
                      Get.to(() => StudentSignup());
                    },
                    child: Text("SIGNUP"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
