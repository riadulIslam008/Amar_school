import 'package:flutter/material.dart';

class CircularPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.greenAccent[700],
        ),
      ),
    );
  }
}
