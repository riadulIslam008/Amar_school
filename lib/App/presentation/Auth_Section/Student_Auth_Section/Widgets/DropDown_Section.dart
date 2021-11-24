import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/StudentViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DropDownSection extends GetWidget<StudentViewController> {
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
    return GetBuilder<StudentViewController>(
      builder: (controller) {
        return Expanded(
          child: DropdownButton<String>(
            hint: Text("select ur class"),
            value: controller.fristItemClassListVariable,
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
              controller.fristItemClassListVariable = currentstandred;
              controller.update();
            },
          ),
        );
      },
    );
  }
}
