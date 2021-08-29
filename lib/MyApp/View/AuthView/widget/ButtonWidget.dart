import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onclick;

  const ButtonWidget({Key key, this.buttonText, this.onclick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:Colors.grey.withOpacity(0.5),
      highlightColor: Colors.grey[300],
      period : Duration(seconds: 2),
      child: TextButton(
        onPressed: onclick,
        style: TextButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
