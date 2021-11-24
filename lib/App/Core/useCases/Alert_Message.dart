import 'package:amer_school/App/presentation/Auth_Section/Widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//* Utils File

//* Button Widget

void errorDialogBox({@required String description}) {
  TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  Get.defaultDialog(
    barrierDismissible: false,
    title: "Alert",
    titleStyle: textStyle,
    backgroundColor: Colors.black,
    radius: 8,
    content: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(description,
                textAlign: TextAlign.center, style: textStyle),
          ),
          SizedBox(height: 15),
          ButtonWidget(
            buttonText: "Okay",
            onclick: () {
              Get.back();
            },
          ),
        ],
      ),
    ),
  );
}
