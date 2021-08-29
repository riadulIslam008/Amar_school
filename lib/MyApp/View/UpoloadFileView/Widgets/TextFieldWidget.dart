import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String titleName;
  final int maxLine;
  final TextEditingController controller;

  const TextFieldWidget(
      {Key key, this.titleName, this.maxLine, this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLine,
      decoration: InputDecoration(
        hintText: titleName,
       // labelText: titleName,
        border: OutlineInputBorder(
         // gapPadding: 0,
        ),
        
      ),
      textInputAction: TextInputAction.go,
    );
  }
}
