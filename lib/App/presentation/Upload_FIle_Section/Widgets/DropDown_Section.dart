import 'package:amer_school/App/presentation/Upload_FIle_Section/UploadFileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DropDownSection extends GetWidget<UploadFileController> {
  DropDownSection({Key key}) : super(key: key);

  final List<String> classList = <String>[
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9",
    "Class 10",
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadFileController>(
      builder: (controller) {
        return DropdownButton<String>(
          hint: Text("select ur class"),
          value: controller.fristItemClassSerial,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          items: classList
              .map(
                (value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          onChanged: (currentstandred) {
            controller.fristItemClassSerial = currentstandred;
            controller.update();
          },
        );
      },
    );
  }
}
