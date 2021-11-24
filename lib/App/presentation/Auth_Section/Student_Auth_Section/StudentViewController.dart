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

//? ============== Packages ========
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

//? ======== Permission ===========
import 'package:permission_handler/permission_handler.dart';

class StudentViewController extends GetxController {
  final _firebaseServices;
  StudentViewController(this._firebaseServices);

  final GetStorage getStorage = GetStorage();

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

  RxString fullName = "".obs;
  RxString rollNumber = "".obs;
  RxString password = "".obs;
  RxString standerd = "".obs;
  RxString profileImage = "".obs;

  signIN() async {
    Get.to(() => CircularPage(), transition: Transition.zoom);
    fullName.value = fullNameController.text;
    password.value = passwordController.text;
    rollNumber.value = rollController.text;

    final String email = makeValidateEmail(fullName.value, rollNumber.value);

    FirebaseSignIn firebasesignin = FirebaseSignIn(_firebaseServices);
    final Either<AppError, String> _credentail =
        await firebasesignin(AuthParam(email, password.value));

    _credentail.fold((l) {
      Get.back();
      errorDialogBox(description: l.errorMerrsage);
    }, (r) {
      getStorage.write(STUDENT, "$r");
      getStorage.write(PERSON_TYPES, STUDENT);
      Get.offAll(() => HomePageView(isTeacher: false));
    });
  }

  signUP({@required String standerdSection}) async {
    if (imageFile == null) {
      Get.back();
      return errorDialogBox(description: FILE_IMAGE_ERROR_MESSAGE);
    }

    Get.off(() => CircularPage(), transition: Transition.zoom);
    fullName.value = fullNameController.text;
    rollNumber.value = rollController.text;
    password.value = passwordController.text;
    standerd.value = standerdSection;

    final String email = makeValidateEmail(fullName.value, rollNumber.value);

    final String destination =
        "$fristItemClassListVariable/${fullNameController.text}";

    FirebaseSignUp _firebaseSignUp = FirebaseSignUp(_firebaseServices);
    final Either<AppError, String> _credential =
        await _firebaseSignUp(AuthParam(email, password.value));

    _credential.fold((l) => print(l.errorMerrsage), (userUid) async {
      UploadImage _uploadImage = UploadImage(_firebaseServices);
      final Either<AppError, String> imageUrl =
          await _uploadImage(UploadParam(destination, imageFile));

      imageUrl.fold((l) => errorDialogBox(description: IMAGE_ERROR_MESSAGE),
          (r) async {
        StudentModelEntity studentInfos = StudentModelEntity(
          studentName: fullName.value,
          studentRoll: rollNumber.value,
          studentClass: standerd.value,
          studentUid: userUid,
          studentProfileLink: r,
        );

        PersonDataSave personDataSave = PersonDataSave(_firebaseServices);
        await personDataSave(studentInfos);

        AddInGroup addInGroup = AddInGroup(_firebaseServices);
        await addInGroup(
          AddMemberParam(
              name: fullName.value,
              roll: rollNumber.value,
              standerd: standerd.value,
              profilePic: r),
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

  @override
  void onClose() {
    fullNameController.dispose();
    rollController.dispose();
    passwordController.dispose();
    confrimPasswordController.dispose();
    super.onClose();
  }
}
