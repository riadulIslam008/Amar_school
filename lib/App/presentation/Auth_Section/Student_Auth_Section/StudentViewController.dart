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
import 'package:amer_school/App/domain/entites/Members_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/Person_Data_Save.dart';
import 'package:amer_school/App/domain/useCases/Upload_Image.dart';
import 'package:amer_school/App/presentation/DropDown_Section/DropDown_Controller.dart';

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
  signUP() async {
    if (imageFile == null) {
      Get.back();
      return errorDialogBox(description: FILE_IMAGE_ERROR_MESSAGE);
    }
    final String studentSection =
        Get.find<DropDownController>().fristItemClassListVariable;

    Get.off(() => CircularPage(), transition: Transition.zoom);
    standerd.value = studentSection;

    final String email =
        makeValidateEmail(passwordController.text, rollController.text);

    final String destination = "$studentSection/${fullNameController.text}";

    final Either<AppError, String> _credential =
        await signupFirebase(email: email);
    _credential.fold((l) => errorDialogBox(description: l.errorMerrsage),
        (userUid) async {
      final Either<AppError, String> imageUrl =
          await uploadImage(destination: destination);
      imageUrl.fold((l) => errorDialogBox(description: IMAGE_ERROR_MESSAGE),
          (imageLink) async {
        StudentModelEntity studentInfos = StudentModelEntity(
          studentName: fullNameController.text,
          studentRoll: rollController.text,
          studentClass: standerd.value,
          studentUid: userUid,
          studentProfileLink: imageLink,
        );

        final Either<AppError, void> _either =
            await saveStudentDataInFirebase(studentModelEntity: studentInfos);

        _either.fold((l) => errorDialogBox(description: l.errorMerrsage),
            (r) async {
          MembersModelEntity _membersModel = MembersModelEntity(
            name: fullNameController.text,
            roll: int.parse(rollController.text),
            profilePic: imageLink,
          );

          final _addedInGroup =
              await addStudentInTheirGroup(membersModelEntity: _membersModel);

          _addedInGroup
              .fold((l) => errorDialogBox(description: l.errorMerrsage), (r) {
            clearController();
            Get.off(() => StudentLogin());
            successfulSnackBar("Sign UP successfully", "please login here");
          });
        });
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

  Future<Either<AppError, String>> signupFirebase({String email}) async {
    FirebaseSignUp _firebaseSignUp = FirebaseSignUp(_firebaseServices);
    final Either<AppError, String> _credential =
        await _firebaseSignUp(AuthParam(email, passwordController.text));

    return _credential.fold(
        (l) => Left(AppError(l.errorMerrsage)), (r) => Right(r));
  }

  Future<Either<AppError, String>> uploadImage({String destination}) async {
    UploadFile _uploadImage = UploadFile(_firebaseServices);
    final Either<AppError, TaskSnap> _imageUrl =
        await _uploadImage(UploadParam(destination, imageFile, IMAGES));

    return _imageUrl.fold(
      (l) => Left(AppError(l.errorMerrsage)),
      (r) async => Right(
        await r.taskSnapshot.ref.getDownloadURL(),
      ),
    );
  }

  Future<Either<AppError, void>> saveStudentDataInFirebase(
      {StudentModelEntity studentModelEntity}) async {
    PersonDataSave personDataSave = PersonDataSave(_firebaseServices);
    final _response = await personDataSave(studentModelEntity);

    return _response.fold(
        (l) => Left(AppError(l.errorMerrsage)), (r) => Right(r));
  }

  Future<Either<AppError, void>> addStudentInTheirGroup(
      {MembersModelEntity membersModelEntity}) async {
    AddInGroup addInGroup = AddInGroup(_firebaseServices);
    final _response = await addInGroup(AddMemberParam(
        standerd: standerd.value, membersParam: membersModelEntity));

    return _response.fold(
        (l) => Left(AppError(l.errorMerrsage)), (r) => Right(r));
  }
}
