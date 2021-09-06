import 'dart:isolate';
import 'dart:ui';

import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/GroupcallORchatscreen.dart';
import 'package:amer_school/MyApp/View/GroupList/GroupListView.dart';
import 'package:amer_school/MyApp/View/HomeView/VideoPlayPageView/VideoPlayView.dart';
import 'package:amer_school/MyApp/controller/VideoPageControler.dart';
import 'package:amer_school/MyApp/model/StudentDetailsModel.dart';
import 'package:amer_school/MyApp/model/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeViewController extends GetxController {
  final GetStorage getStorage = GetStorage();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String userUid;
  StudentDetailsModel studentModel;
  String person;
  TeacherDetailsModel teacherInfo;

  ReceivePort _receivePort = ReceivePort();

  RxString personProfile = "".obs;

  @override
  void onInit() {
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "donwloadingVideo");
    FlutterDownloader.registerCallback(downloaderCallback);
    _receivePort.listen((message) {
      print(message);
    });
    initialFunction();
    super.onInit();
  }

  initialFunction() async {
    person = await getStorage.read(PERSON_TYPE);
    stdentORteacherCheck() ? studentInit() : teacherInit();
  }

  bool stdentORteacherCheck() {
    if (person == "student") {
      return true;
    }
    return false;
  }

  void studentInit() async {
    try {
      userUid = await getStorage.read(studentUid);
      await firestore
          .collection(studentCollection)
          .doc(userUid)
          .get()
          .then((studentInfo) {
        studentModel = StudentDetailsModel.fromJson(studentInfo.data());
        personProfile.value = studentModel.studentProfileLink;
        person = "student";
        print("Student Info Done");
      });
    } catch (e) {
      print("This is teacher Side");
      print(e);
    }
  }

  void teacherInit() async {
    userUid = await getStorage.read(teacherUid);
    try {
      await firestore
          .collection(teacherCollection)
          .doc(userUid)
          .get()
          .then((snapshot) {
        teacherInfo = TeacherDetailsModel.fromJson(snapshot.data());
        personProfile.value = teacherInfo.teacherProfileLink;
      });
      person = "Teacher";
    } catch (e) {
      print(e);
    }
  }

  messangerIconPressed() {
    Get.to(
      () => GroupCallORchatScreen(studentDetailsModel: studentModel),
    );
  }

  groupListIconPress() {
    Get.to(() => GroupListView(teacherInfo: teacherInfo));
  }

//Todo ==================== Download File ====================##

  void downloadFile(
      {@required String videoUrl, @required String fileName}) async {
    await Permission.storage.request();
    final baseName = await getExternalStorageDirectory();
    final id = await FlutterDownloader.enqueue(
        url: videoUrl, savedDir: baseName.path, fileName: fileName);
    print(id);
  }

  static void downloaderCallback(
      String id, DownloadTaskStatus status, int progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName("donwloadingVideo");
    print(sendPort);
  }

  //Todo ============== Video Play ====================##

  Future<void> videoPlay({@required String videoLink}) async {
    // ignore: await_only_futures
    await Get.put(VideoDisplayController(videoLink: videoLink));

    Get.to(() => VideoPlayView());
  }
}
