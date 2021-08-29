import 'dart:io';

import 'package:amer_school/MyApp/Services/FirebaseApi.dart';
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/View/HomeView/HomePageView.dart';
import 'package:amer_school/MyApp/View/StudentAuth/CircularPage.dart';
import 'package:amer_school/MyApp/View/StudentAuth/StudentSignUP.dart';
import 'package:amer_school/MyApp/View/StudentAuth/studentLogin.dart';
import 'package:amer_school/MyApp/model/StudentDetailsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class StudentViewController extends GetxController {
  final FirebaseApi _firebaseApi = FirebaseApi();
  final GetStorage getStorage = GetStorage();

  var file = "".obs;
  File imageFile;

  TextEditingController fullNameController,
      rollController,
      passwordController,
      confrimPasswordController;

  RxString fristItemClassList = StudentSignup().classList[0].obs;
  RxString fristItemClassListVariable = StudentLogin().classList[0].obs;

  RxString fullName = "".obs;
  RxString rollNumber = "".obs;
  RxString password = "".obs;
  RxString standerd = "".obs;
  RxString profileImage = "".obs;

  signIN() async {
    Get.off(() => CircularPage(), transition: Transition.zoom);
    fullName.value = fullNameController.text;
    password.value = passwordController.text;
    rollNumber.value = rollController.text;

    final String email =
        "${fullName.value.replaceAll(RegExp(" "), "").toLowerCase()}${rollNumber.value}@gmail.com";

    final UserCredential result =
        await _firebaseApi.signIN(email: email, password: password.value);

    if (result != null) {
      getStorage.write(studentUid, "${result.user.uid}");
      getStorage.write(PERSON_TYPE, "student");
      Get.offAll(() => HomePageView(isTeacher: false), transition: Transition.fadeIn);
      // Restart.restartApp();
      // main();
    } else {
      print("Error $result");
    }
  }

  signUP({@required String standerdSection}) async {
    Get.off(() => CircularPage(), transition: Transition.zoom);
    fullName.value = fullNameController.text;
    rollNumber.value = rollController.text;
    password.value = passwordController.text;
    standerd.value = standerdSection;

    final String email =
        "${fullName.value.replaceAll(RegExp(" "), "").toLowerCase()}${rollNumber.value}@gmail.com";

    try {
      if (imageFile == null) {
        Get.snackbar("Image", "Chose image from file");
        return;
      }
      final String destination =
          "${fristItemClassList.value}/${fullNameController.text}";
      TaskSnapshot task = await _firebaseApi.uploadFile(destination, imageFile);

      if (task != null) {
        final imageUrl = await task.ref.getDownloadURL();
        profileImage.value = imageUrl;
      } else {
        Get.snackbar("Network Error", "Failed ImageUpload");
        return;
      }
      UserCredential _userCredential =
          await _firebaseApi.signUP(email: email, password: password.value);

      StudentDetailsModel studentInfos = StudentDetailsModel(
        studentName: fullName.value,
        studentRoll: rollNumber.value,
        studentClass: standerd.value,
        studentUid: _userCredential.user.uid,
        studentProfileLink: profileImage.value,
      );

      await _firebaseApi.dataSave(
          infos: studentInfos,
          uid: _userCredential.user.uid,
          collectionName: studentCollection);

      await _firebaseApi.addMembersInGroup(
        studentName: fullName.value,
        studentRoll: rollNumber.value,
        studentClass: standerd.value,
        profilePic: profileImage.value,
      );

      Get.snackbar("Sign UP successfully", "please login here",
          backgroundColor: Colors.green);
      clearController();
      Get.off(() => StudentLogin());
    } on FirebaseException catch (e) {
      print("Exception $e");
    }
  }

  @override
  void onInit() {
    fullNameController = TextEditingController();
    rollController = TextEditingController();
    passwordController = TextEditingController();
    confrimPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    //fullNameController.dispose();
    fullNameController.text = "";
    rollController.dispose();
    passwordController.dispose();
    confrimPasswordController.dispose();
    super.dispose();
  }

  clearController() {
    fullNameController.clear();
    rollController.clear();
    passwordController.clear();
    confrimPasswordController.clear();
  }

  //Todo ================== Pick Image =====================##
  Future<void> pickImage({@required ImageSource imageSource}) async {
    final PermissionStatus cameraStatus = await Permission.camera.request();
    final PermissionStatus galleryStatus = await Permission.storage.request();

    if (cameraStatus.isGranted && galleryStatus.isGranted) {
      XFile _response = await ImagePicker().pickImage(source: imageSource);
      if (_response != null) {
        file.value = _response.path;
        imageFile = File(file.value);
        print(imageFile);

        Get.back();
      } else {
        return;
      }
    } else {
      return;
    }
  }
}
