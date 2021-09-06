import 'dart:io';

import 'package:amer_school/MyApp/Services/FirebaseApi.dart';
import 'package:amer_school/MyApp/View/UpoloadFileView/Widgets/DorpDownButton.dart';
import 'package:amer_school/MyApp/controller/HomeViewPageController.dart';
import 'package:amer_school/MyApp/model/VideoFileModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadFileController extends GetxController {
  final homeController = Get.find<HomeViewController>();
  FirebaseApi _firebaseApi = FirebaseApi();

  var titleController = TextEditingController();
  var discriptionController = TextEditingController();

  RxString imageFileName = "Thumbnail image".obs;
  RxString videoFileName = "select video from file".obs;

  final List urlList = [];

  File imageFile;
  File videoFile;

  final String date = DateTime.now().toString().substring(0, 10);

  RxDouble imageParcentage = 0.0.obs;
  RxDouble videoParcentage = 0.0.obs;
  RxBool isUploading = false.obs;

  RxString fristItemClassSerial = DropDownItem().classSerial[0].obs;

  uploadVideosAndImage() async {
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
      Get.snackbar(
        "Success",
        "Upload Completed",
        backgroundColor: Colors.greenAccent,
        colorText: Colors.white,
      );

      clearState();
    } else {
      Get.snackbar("Waring", "Title and Discription should not empty");
    }
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      try {
        final String path = result.files.single.path;
        imageFileName.value = path.split("/").last;
        imageFile = File(path);
      } catch (e) {
        print("select Image Error $e");
      }
    } else {
      return;
    }
  }

  Future selectVideo() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      try {
        final String path = result.files.single.path;
        videoFileName.value = path.split("/").last;
        videoFile = File(path);
      } catch (e) {
        print("select Image Error $e");
      }
    } else {
      return;
    }
  }

  uploadImage() async {
    if (imageFile != null) {
      final destination = "$date/${imageFileName.value}";
      TaskSnapshot task = await _firebaseApi.uploadFile(destination, imageFile);

      if (task != null) {
        isUploading.value = true;
        imageParcentage.value = (task.bytesTransferred / task.totalBytes) * 100;
        final url = await task.ref.getDownloadURL();
        urlList.add(url);
      } else {
        Get.snackbar(
          "File Uploaded Error",
          "Try Agrain",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      return null;
    }
  }

  uploadVideo() async {
    if (videoFile != null) {
      final destination = "$date/${videoFileName.value}";
      TaskSnapshot task = await _firebaseApi.uploadFile(destination, videoFile);
      if (task != null) {
        videoParcentage.value = (task.bytesTransferred / task.totalBytes) * 100;
        final url = await task.ref.getDownloadURL();
        urlList.add(url);
      } else {
        Get.snackbar(
          "File Uploaded Error",
          "Try Agrain",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      return null;
    }
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
