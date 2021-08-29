import 'package:flutter/material.dart';

class AContainer extends StatelessWidget {
  final String dataName;

  const AContainer({Key key, this.dataName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        constraints: BoxConstraints(minHeight: 50),
        child: Center(child: Text(dataName)),
      ),
    );
  }
}
