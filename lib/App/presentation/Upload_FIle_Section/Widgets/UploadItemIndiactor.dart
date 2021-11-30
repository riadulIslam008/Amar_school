import 'package:amer_school/App/presentation/Upload_FIle_Section/UploadFileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadItemIndicator extends GetWidget<UploadFileController> {
  final IconData icon;
  final String title;
  final double value;

  UploadItemIndicator({this.icon, this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          // leading: Icon(Icons.image),
          title: Text(title),
          subtitle: 
             LinearProgressIndicator(
              value: value,
            ),
          
          trailing: (value == 100)?Icon(Icons.open_in_browser,color: Colors.green): Icon(Icons.close_rounded),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
