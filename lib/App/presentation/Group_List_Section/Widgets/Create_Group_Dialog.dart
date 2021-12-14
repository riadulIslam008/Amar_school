import 'package:amer_school/App/presentation/DropDown_Section/DropDown_Section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDialogButton({@required VoidCallback onPressed}) => Get.defaultDialog(
      barrierDismissible: false,
      title: "Create Group",
      // titleStyle: textStyle,
      backgroundColor: Colors.black,
      radius: 8,
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropDownSection(),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
