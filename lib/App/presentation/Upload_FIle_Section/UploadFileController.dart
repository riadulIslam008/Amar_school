import 'dart:io';

import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/Core/useCases/Successful_SnackBar.dart';
import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/Save_Video_Infos.dart';
import 'package:amer_school/App/domain/useCases/Upload_Image.dart';
import 'package:amer_school/App/presentation/DropDown_Section/DropDown_Controller.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/domain/entites/Task_SnapShot.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadFileController extends GetxController {
  UploadFileController(this._firebaseRepository);
  final homeController = Get.find<HomeViewController>();
  final _firebaseRepository;

  final String studentSection = Get.find<DropDownController>().fristItemClassListVariable;

  TextEditingController titleController, discriptionController;

  @override
  void onInit() {
    titleController = TextEditingController();
    discriptionController = TextEditingController();
    super.onInit();
  }

  RxString imageFileName = "Thumbnail image".obs;
  RxString videoFileName = "select video from file".obs;

  String imageUrl;
  String videoUrl;
  File imageFile;
  File videoFile;

  final String date = DateTime.now().toString().substring(0, 10);

  RxDouble imageParcentage = 0.0.obs;
  RxDouble videoParcentage = 0.0.obs;
  RxBool isUploading = false.obs;

  Future<void> uploadVideosAndImage() async {
    if (titleController.value.text.trim() != null &&
        discriptionController.value.text.trim() != null) {
      await uploadImage();
      await uploadVideo();
      VideoFileEntity info = VideoFileEntity(
          titleController.value.text,
          imageUrl,
          videoUrl,
          discriptionController.value.text,
          date,
          studentSection,
          homeController.teacherInfo.teacherProfileLink);

      SaveVideoInfos _saveVideoinfos = SaveVideoInfos(_firebaseRepository);
      await _saveVideoinfos(info);
      successfulSnackBar("UploadVideo", "SuccessFully complete");
      isUploading.value = false;
      clearState();
    } else {
      Get.snackbar("Waring", "Title and Discription should not empty");
    }
  }

  Future<void> uploadImage() async {
    final destination = "$date/${imageFileName.value}";

    UploadFile _uploadImage = UploadFile(_firebaseRepository);
    final Either<AppError, TaskSnap> _data =
        await _uploadImage(UploadParam(destination, imageFile, IMAGES));

    _data.fold((l) => errorDialogBox(description: l.errorMerrsage), (r) async {
      isUploading.value = true;
      imageParcentage.value =
          (r.taskSnapshot.bytesTransferred / r.taskSnapshot.totalBytes) * 100;
      imageUrl = await r.taskSnapshot.ref.getDownloadURL();
    });
  }

  Future<void> uploadVideo() async {
    final destination = "$date/${videoFileName.value}";

    UploadFile _uploadVideo = UploadFile(_firebaseRepository);
    final Either<AppError, TaskSnap> _data =
        await _uploadVideo(UploadParam(destination, videoFile, VIDEOS));

    _data.fold((l) => errorDialogBox(description: l.errorMerrsage), (r) async {
      isUploading.value = true;
      videoParcentage.value =
          (r.taskSnapshot.bytesTransferred / r.taskSnapshot.totalBytes) * 100;
      videoUrl = await r.taskSnapshot.ref.getDownloadURL();
    });
  }

  clearState() {
    titleController.clear();
    discriptionController.clear();
    imageFileName.value = "Thumbnail image";
    videoFileName.value = "select video from file";
  }
}
