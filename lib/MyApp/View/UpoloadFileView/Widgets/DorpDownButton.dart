import 'package:amer_school/MyApp/controller/UploadFileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownItem extends GetWidget<UploadFileController> {
  final List<String> classSerial = <String>[
    "Select Class",
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9",
    "Class 10",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton(
        value: controller.fristItemClassSerial.value,
        isExpanded: true,
        iconEnabledColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        //hint: Text("আপনার বিভাগ নির্বাচন করুন"),
        items: classSerial
            .map(
              (value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
        onChanged: (currentClass) {
          controller.fristItemClassSerial.value = currentClass;
        },
      ),
    );
  }
}
