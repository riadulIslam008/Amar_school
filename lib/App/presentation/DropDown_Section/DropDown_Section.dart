import 'package:amer_school/App/presentation/DropDown_Section/DropDown_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DropDownSection extends GetWidget {
  DropDownSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DropDownController>(
      init: DropDownController(),
      builder: (controller) {
        return DropdownButton<String>(
          hint: Text("select ur class"),
          value: controller.fristItemClassListVariable,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          items: controller.classList
              .map(
                (value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          onChanged: (currentstandred) {
            controller.updateStudentSection(currentstandred);
          },
        );
      },
    );
  }
}
