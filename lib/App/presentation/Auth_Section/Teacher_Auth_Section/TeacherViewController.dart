import 'dart:io';

import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/Core/useCases/Make_Validate_Email.dart';
import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/domain/useCases/Firebase_Signin.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/AuthParam.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:amer_school/App/Core/widgets/CircularPage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherViewController extends GetxController {
  final getStorage;
  final _firebaseRepository;

  TextEditingController fullNameController,
      mobileController,
      passwordController,
      quotesController;

  TeacherViewController(this._firebaseRepository, this.getStorage);

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

    final String _email = makeValidateEmail(fullNameController.text, "", "");

    FirebaseSignIn _userSignIn = FirebaseSignIn(_firebaseRepository);
    final Either<AppError, String> _either =
        await _userSignIn(AuthParam(_email, passwordController.text));

    _either.fold((l) {
      Get.back();
      errorDialogBox(description: l.errorMerrsage);
    }, (r) {
      getStorage.write(TEACHER_UID, "$r");
      getStorage.write(PERSON_TYPES, "teacher");
      Get.offAllNamed(Routes.HomeView, arguments: [true]);
    });
  }

  //* ## =================== Clear Function ================= ##
  clearController() {
    fullNameController.clear();
    mobileController.clear();
    passwordController.clear();
    quotesController.clear();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    quotesController.dispose();
    super.dispose();
  }
}
