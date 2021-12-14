import 'dart:io';

import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/Core/useCases/Make_Validate_Email.dart';
import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/domain/useCases/Firebase_Signin.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/AuthParam.dart';
import 'package:amer_school/MyApp/Services/FirebaseApi.dart';
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/App/presentation/Home_Section/HomePageView.dart';
import 'package:amer_school/App/Core/widgets/CircularPage.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class TeacherViewController extends GetxController {
  final FirebaseApi _firebaseApi = FirebaseApi();
  final GetStorage getStorage = GetStorage();

  final _firebaseRepository;

  TextEditingController fullNameController,
      mobileController,
      passwordController,
      quotesController;

  TeacherViewController(this._firebaseRepository);

  @override
  void onInit() {
    fullNameController = TextEditingController();
    mobileController = TextEditingController();
    passwordController = TextEditingController();
    quotesController = TextEditingController();
    super.onInit();
  }

  RxString fullName = "".obs;
  RxString mobileNumber = "".obs;
  RxString quotes = "".obs;
  RxString password = "".obs;
  RxString subject = "".obs;
  RxString profileFile = "".obs;

  File imageFile;

  //* ## ================== sign IN function ================ ##
  signIN() async {
    Get.to(() => CircularPage(), transition: Transition.zoom);
    fullName.value = fullNameController.text;
    password.value = passwordController.text;

    final String _email = makeValidateEmail(fullNameController.text, "");

    FirebaseSignIn _userSignIn = FirebaseSignIn(_firebaseRepository);
    final Either<AppError, String> _either =
        await _userSignIn(AuthParam(_email, passwordController.text));

    _either.fold((l) {
      Get.back();
      errorDialogBox(description: l.errorMerrsage);
    }, (r) {
      getStorage.write(teacherUid, "$r");
      getStorage.write(PERSON_TYPES, "teacher");
      Get.offAll(() => HomePageView(isTeacher: true));
    });

    // final String email =
    //     "${fullName.value.replaceAll(RegExp(" "), "").toLowerCase()}@gmail.com";

    // final UserCredential result =
    //     await _firebaseApi.signIN(email: email, password: password.value);

    // if (result != null) {
    //   getStorage.write(teacherUid, "${result.user.uid}");
    //   getStorage.write(PERSON_TYPES, "teacher");
    //   Get.offAll(() => HomePageView(isTeacher: true));
    // }
  }

  //* ## ================== signUP function ================ ##
  signUP({@required String subjectName}) async {
    String _imageUrl;
    fullName.value = fullNameController.text;
    mobileNumber.value = mobileController.text;
    subject.value = subjectName;
    quotes.value = quotesController.text;
    password.value = passwordController.text;

    final String email =
        "${fullName.value.replaceAll(RegExp(" "), "").toLowerCase()}@gmail.com";

    try {
      final String destination = "teachers/${fullNameController.text}";
      TaskSnapshot task = await _firebaseApi.uploadFile(destination, imageFile);

      if (task != null) {
        final imageUrl = await task.ref.getDownloadURL();
        _imageUrl = imageUrl;
      } else {
        Get.snackbar("Network Error", "Failed ImageUpload");
        return;
      }

      UserCredential _userCredential =
          await _firebaseApi.signUP(email: email, password: password.value);

      TeacherDetailsModel teacherInfos = TeacherDetailsModel(
        teacherName: fullName.value,
        teacherSubject: subject.value,
        teacherUid: _userCredential.user.uid,
        mobileNumber: mobileNumber.value,
        teacherProfileLink: _imageUrl,
        quetosForStudent: quotes.value,
      );

      await _firebaseApi.dataSave(
          infos: teacherInfos,
          uid: _userCredential.user.uid,
          collectionName: teacherCollection);

      Get.snackbar("Sign UP successfully", "Go to login page",
          backgroundColor: Colors.green);
      clearController();
    } on FirebaseException catch (e) {
      print("Exception $e");
    }
  }

  //* ## =================== Clear Function ================= ##
  clearController() {
    fullNameController.clear();
    mobileController.clear();
    passwordController.clear();
    quotesController.clear();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    quotesController.dispose();
    super.dispose();
  }

  Future<void> pickImage({@required ImageSource imageSource}) async {
    final PermissionStatus cameraStatus = await Permission.camera.request();
    final PermissionStatus galleryStatus = await Permission.storage.request();

    if (cameraStatus.isGranted && galleryStatus.isGranted) {
      XFile _response = await ImagePicker().pickImage(source: imageSource);
      if (_response != null) {
        profileFile.value = _response.path;
        imageFile = File(profileFile.value);
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
