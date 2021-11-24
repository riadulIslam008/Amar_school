import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitalView extends StatefulWidget {
  const InitalView({Key key}) : super(key: key);

  @override
  _InitalViewState createState() => _InitalViewState();
}

class _InitalViewState extends State<InitalView> {
  @override
  void initState() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(Routes.AuthPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
