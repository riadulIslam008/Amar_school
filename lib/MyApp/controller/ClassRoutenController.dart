import 'package:amer_school/MyApp/Services/FirebaseApi.dart';
import 'package:amer_school/MyApp/model/RoutenModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutenController extends GetxController {
  final FirebaseApi _firebaseApi = FirebaseApi();
  TextEditingController teacherNameController,
      subjectController,
      timeController,
      dateController;

  @override
  void onInit() {
    teacherNameController = TextEditingController();
    subjectController = TextEditingController();
    timeController = TextEditingController();
    dateController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    teacherNameController.dispose();
    subjectController.dispose();
    timeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  onClear() {
    teacherNameController.clear();
    subjectController.clear();
    timeController.clear();
    dateController.clear();
  }

  onSavedRouten(
      {String teacherName, String subject, String time, String date}) async {
    RoutenModel routenModel = RoutenModel(
      teacherName: teacherName,
      subject: subject,
      time: time,
      date: date,
    );
    await _firebaseApi.classRouten(routenModel: routenModel);
    onClear();
  }
}
