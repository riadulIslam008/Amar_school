import 'package:amer_school/App/presentation/Group_List_Section/GroupListViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DropDownSectionGroupList extends GetWidget<GroupListViewController> {
  DropDownSectionGroupList({Key key}) : super(key: key);

  final List<String> classList = <String>[
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9",
    "Class 10",
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupListViewController>(
      builder: (controller) {
        return DropdownButton<String>(
          hint: Text("select ur class"),
          value: controller.fristItemClassList,
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
            controller.fristItemClassList = currentstandred;
            controller.update();
          },
        );
      },
    );
  }
}
