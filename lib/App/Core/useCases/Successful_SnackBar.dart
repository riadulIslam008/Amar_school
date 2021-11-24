import 'package:flutter/material.dart';
import 'package:get/get.dart';

void successfulSnackBar(String messageType, String errorMessage) {
  Get.snackbar(messageType, errorMessage, backgroundColor: Colors.green);
}
