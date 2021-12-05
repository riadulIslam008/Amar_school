import 'package:flutter/material.dart';

class DecorationCircle extends StatelessWidget {
  final String groupName;
  const DecorationCircle({Key key,@required this.groupName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _classNumber = groupName.split(" ")[1];
   return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _classNumber,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          "th",
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
