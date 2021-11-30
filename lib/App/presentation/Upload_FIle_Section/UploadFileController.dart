import 'dart:io';

import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/Core/useCases/Successful_SnackBar.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/Upload_Image.dart';
import 'package:amer_school/MyApp/Services/FirebaseApi.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/domain/entites/Task_SnapShot.dart';
import 'package:amer_school/MyApp/model/VideoFileModel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadFileController extends GetxController {
  UploadFileController(this._firebaseRepository);
  final homeController = Get.find<HomeViewController>();
  FirebaseApi _firebaseApi = FirebaseApi();
  final _firebaseRepository;

  TextEditingController titleController, discriptionController;

  @override
  void onInit() {
    titleController = TextEditingController();
    discriptionController = TextEditingController();
    super.onInit();
  }

  RxString imageFileName = "Thumbnail image".obs;
  RxString videoFileName = "select video from file".obs;

  final List urlList = [];

  File imageFile;
  File videoFile;

  final String date = DateTime.now().toString().substring(0, 10);

  RxDouble imageParcentage = 0.0.obs;
  RxDouble videoParcentage = 0.0.obs;
  RxBool isUploading = false.obs;

  String fristItemClassSerial;

  Future<void> uploadVideosAndImage() async {
    if (titleController.value.text.trim() != null &&
        discriptionController.value.text.trim() != null) {
      await uploadImage();
      await uploadVideo();
      VideoFileModel info = VideoFileModel(
        videoTitle: titleController.value.text,
        thumbnailImageLink: urlList[0],
        videoDescription: discriptionController.value.text,
        videoFileLink: urlList[1],
        date: date,
        teacherProfileImage: homeController.teacherInfo.teacherProfileLink,
      );

      await _firebaseApi.uploadVideoInfoToDb(info);
      successfulSnackBar("UploadVideo", "SuccessFully complete");

      clearState();
    } else {
      Get.snackbar("Waring", "Title and Discription should not empty");
    }
  }

  Future<void> uploadImage() async {
    final destination = "$date/${imageFileName.value}";

    UploadFile _uploadImage = UploadFile(_firebaseRepository);
    final Either<AppError, TaskSnap> _data =
        await _uploadImage(UploadParam(destination, imageFile));

    _data.fold((l) => errorDialogBox(description: l.errorMerrsage), (r) async {
      isUploading.value = true;
      imageParcentage.value =
          (r.taskSnapshot.bytesTransferred / r.taskSnapshot.totalBytes) * 100;
      String url = await r.taskSnapshot.ref.getDownloadURL();
      urlList.add(url);
    });
  }

  Future<void> uploadVideo() async {
    final destination = "$date/${videoFileName.value}";

    UploadFile _uploadImage = UploadFile(_firebaseRepository);
    final Either<AppError, TaskSnap> _data =
        await _uploadImage(UploadParam(destination, videoFile));

    _data.fold((l) => errorDialogBox(description: l.errorMerrsage), (r) async {
      videoParcentage.value =
          (r.taskSnapshot.bytesTransferred / r.taskSnapshot.totalBytes) * 100;
      String url = await r.taskSnapshot.ref.getDownloadURL();
      urlList.add(url);
    });
  }

  clearState() {
    titleController.clear();
    discriptionController.clear();
    imageFileName.value = "Thumbnail image";
    videoFileName.value = "select video from file";
    urlList.clear();
  }

  //Todo ================ Working With Notification ===================//

}
