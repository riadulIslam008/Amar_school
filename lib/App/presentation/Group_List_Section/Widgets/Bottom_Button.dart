import 'package:amer_school/App/presentation/DropDown_Section/DropDown_Controller.dart';
import 'package:amer_school/App/presentation/Group_List_Section/GroupListViewController.dart';
import 'package:amer_school/App/presentation/Group_List_Section/Widgets/Create_Group_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomButton extends GetWidget<GroupListViewController> {
  const BottomButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () => showDialogButton(onPressed: _onPressed),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            SizedBox(width: 10),
            Text(
              "Create Group ...",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed() {
    final studentSection =
        Get.find<DropDownController>().fristItemClassListVariable;

    controller.createGroup(className: studentSection);
    Get.back();
  }
}
