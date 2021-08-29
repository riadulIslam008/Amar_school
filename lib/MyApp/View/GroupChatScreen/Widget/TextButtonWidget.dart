import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onclick;

  const TextButtonWidget({Key key, this.buttonText, this.onclick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onclick,
      child: Text(buttonText),
    );
  }
}
