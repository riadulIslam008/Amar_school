import 'dart:io';

//? ======== App Error =========
import 'package:amer_school/App/Core/errors/App_Error.dart';

//? ======= Alert Message ========
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';

//? ========= Make a Valid Emial =======
import 'package:amer_school/App/Core/useCases/Make_Validate_Email.dart';

//? ========== Snack bar =================
import 'package:amer_school/App/Core/useCases/Successful_SnackBar.dart';

//? ========== String =================
import 'package:amer_school/App/Core/utils/Universal_String.dart';

//? =========== Student Model Entity =============
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';

//? ============= Use Cases ==================
import 'package:amer_school/App/domain/useCases/Add_Student_In_Group.dart';
import 'package:amer_school/App/domain/useCases/Firebase_SignUp.dart';
import 'package:amer_school/App/domain/useCases/Firebase_Signin.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Add_Member_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/AuthParam.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/Person_Data_Save.dart';
import 'package:amer_school/App/domain/useCases/Upload_Image.dart';

//? ======== Home Page View ==========
import 'package:amer_school/App/presentation/Home_Section/HomePageView.dart';

//? ============ Circular Progress Indication ========
import 'package:amer_school/App/Core/widgets/CircularPage.dart';

//? =============== Auth/Student Login Page ==========
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/studentLogin.dart';
import 'package:amer_school/App/domain/entites/Task_SnapShot.dart';

//? ============== Packages ========
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StudentViewController extends GetxController {
  final _firebaseServices;
  final _getStorage;
  StudentViewController(this._firebaseServices, this._getStorage);

  var file = "".obs;
  File imageFile;
  String fristItemClassListVariable;

  TextEditingController fullNameController,
      rollController,
      passwordController,
      confrimPasswordController;

  @override
  void onInit() {
    fullNameController = TextEditingController();
    rollController = TextEditingController();
    passwordController = TextEditingController();
    confrimPasswordController = TextEditingController();
    super.onInit();
  }

  RxString standerd = "".obs;
  RxString profileImage = "".obs;

  signIN() async {
    Get.to(() => CircularPage(), transition: Transition.zoom);
    final String email =
        makeValidateEmail(fullNameController.text, rollController.text);

    FirebaseSignIn firebasesignin = FirebaseSignIn(_firebaseServices);
    final Either<AppError, String> _credentail =
        await firebasesignin(AuthParam(email, passwordController.text));

    _credentail.fold((l) {
      Get.back();
      errorDialogBox(description: l.errorMerrsage);
    }, (r) {
      _getStorage.write(STUDENT_UID, "$r");
      _getStorage.write(PERSON_TYPES, STUDENT);
      Get.offAll(() => HomePageView(isTeacher: false));
    });
  }

//Todo ===========  SignUp ======================//
  signUP({@required String standerdSection}) async {
    if (imageFile == null) {
      Get.back();
      return errorDialogBox(description: FILE_IMAGE_ERROR_MESSAGE);
    }

    Get.off(() => CircularPage(), transition: Transition.zoom);
    standerd.value = standerdSection;

    final String email =
        makeValidateEmail(passwordController.text, rollController.text);

    final String destination =
        "$fristItemClassListVariable/${fullNameController.text}";

    UploadFile _uploadImage = UploadFile(_firebaseServices);
    final Either<AppError, TaskSnap> imageUrl =
        await _uploadImage(UploadParam(destination, imageFile, IMAGES));

    imageUrl.fold((l) => errorDialogBox(description: IMAGE_ERROR_MESSAGE),
        (imageLink) async {
      FirebaseSignUp _firebaseSignUp = FirebaseSignUp(_firebaseServices);
      final Either<AppError, String> _credential =
          await _firebaseSignUp(AuthParam(email, passwordController.text));

      _credential.fold((l) => errorDialogBox(description: l.errorMerrsage),
          (userUid) async {
        StudentModelEntity studentInfos = StudentModelEntity(
          studentName: fullNameController.text,
          studentRoll: rollController.text,
          studentClass: standerd.value,
          studentUid: userUid,
          studentProfileLink: await imageLink.taskSnapshot.ref.getDownloadURL(),
        );

        PersonDataSave personDataSave = PersonDataSave(_firebaseServices);
        await personDataSave(studentInfos);

        AddInGroup addInGroup = AddInGroup(_firebaseServices);
        await addInGroup(
          AddMemberParam(
              name: fullNameController.text,
              roll: rollController.text,
              standerd: standerd.value,
              profilePic: await imageLink.taskSnapshot.ref.getDownloadURL()),
        );

        clearController();
        Get.off(() => StudentLogin());
        successfulSnackBar("Sign UP successfully", "please login here");
      });
    });
  }

  clearController() {
    fullNameController.clear();
    rollController.clear();
    passwordController.clear();
    confrimPasswordController.clear();
  }

  //Todo ================== Pick Image =====================##
  Future<void> pickImage({@required ImageSource imageSource}) async {
    XFile _response = await ImagePicker().pickImage(source: imageSource);
    if (_response != null) {
      file.value = _response.path;
      imageFile = File(file.value);

      Get.back();
    } else {
      return;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    rollController.dispose();
    passwordController.dispose();
    confrimPasswordController.dispose();
    super.onClose();
  }
}
