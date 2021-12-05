import 'package:flutter/material.dart';

class TextEditing extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const TextEditing({Key key, this.hintText, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
         border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
