import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

//? ============ AppError =================//
import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';

//? ============ String ===================//
import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/domain/entites/GroupCall_Teacher_Model_Entity.dart';

//? ============ Student Model ================//
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';

//? ============ Teacher Model ================//
import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';

//? ============ Use Cases ================//
import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
import 'package:amer_school/App/domain/useCases/Check_Group_Call.dart';
import 'package:amer_school/App/domain/useCases/Fetch_Student_Data.dart';
import 'package:amer_school/App/domain/useCases/Fetch_Teacher_Data.dart';
import 'package:amer_school/App/domain/useCases/Flutter_Video_Download.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Download_File.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/User_Id.dart';
import 'package:amer_school/App/domain/useCases/Video_File_Info.dart';

//? ============ Flutter Downloader ==========//
import 'package:flutter_downloader/flutter_downloader.dart';

//? ============ Routes ================//
import 'package:amer_school/App/rotues/App_Routes.dart';

//? ============= Packages =============//
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  final _firebaseRepository;
  final _getStorage;
  HomeViewController(this._firebaseRepository, this._getStorage);

  String userUid;
  String person;
  List<VideoFileEntity> videoDocs = [];

  StudentModelEntity studentModel;
  TeacherModelEntity teacherInfo;

  ReceivePort _receivePort = ReceivePort();

  RxString personProfile = "".obs;

  // Rx<GroupCallTeacherModelEntity> _checkCallInstance =
  //     Rxn<GroupCallTeacherModelEntity>();
  // GroupCallTeacherModelEntity get checkCallInstance => _checkCallInstance.value;

  @override
  void onInit() {
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "donwloadingVideo");
    FlutterDownloader.registerCallback(downloaderCallback);
    _receivePort.listen((message) {});
    initialFunction();
    //  _checkCallInstance.bindStream(checkTeacherGroupCall());
    super.onInit();
  }

  // @override
  // void onReady() {
  //   if(checkCallInstance != null)  receiverSnackBar(checkCallInstance);
  //   // Get.snackbar(
  //   //     "hi", "Hello");
  //   super.onReady();
  // }

  void initialFunction() {
    final person = _getStorage.read(PERSON_TYPES);
    person == STUDENT ? studentInit() : teacherInit();
  }

  //Todo ========= Student View ===============##
  void studentInit() async {
    userUid = await _getStorage.read(STUDENT_UID);

    FetchStudentData _fetchStudentData = FetchStudentData(_firebaseRepository);
    final Either<AppError, StudentModelEntity> _data =
        await _fetchStudentData(UserId(userUid));

    _data.fold((l) => errorDialogBox(description: l.errorMerrsage), (r) {
      studentModel = r;
      personProfile.value = r.studentProfileLink;
      person = STUDENT;
    });
  }

//Todo ================= Teacher View ================
  void teacherInit() async {
    userUid = await _getStorage.read(TEACHER_UID);

    FetchTeacherData _fetchTeacherData = FetchTeacherData(_firebaseRepository);
    final Either<AppError, TeacherModelEntity> _data =
        await _fetchTeacherData(UserId(userUid));

    _data.fold((l) => errorDialogBox(description: l.errorMerrsage), (r) {
      teacherInfo = r;
      personProfile.value = r.teacherProfileLink;
      person = "Teacher";
    });
  }

//Todo ==================== Download File ====================##
  void downloadFile(
      {@required String videoUrl, @required String fileName}) async {
    FlutterFileDownload _flutterDownloader =
        FlutterFileDownload(_firebaseRepository);

    final Either<AppError, void> _download =
        await _flutterDownloader(DownloadFileParam(videoUrl, fileName));

    _download.fold(
        (l) => errorDialogBox(description: l.errorMerrsage), (r) => null);
  }

  static void downloaderCallback(
      String id, DownloadTaskStatus status, int progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName("donwloadingVideo");
    print(sendPort);
  }

  //Todo ============== Video Play ====================##
  void videoPlay({@required String videoLink}) async {
    Get.toNamed(Routes.VIDEO_PLAY_PAGE, arguments: videoLink);
  }

  //Todo ============== Fetch Stream as QuerySnapshots ==========##
  fetchVideoCollection() {
    VideoFileInfo _videoFileInfo = VideoFileInfo(_firebaseRepository);
    return _videoFileInfo();
  }

  //?? ================ Group Call Instance Check ================= //
  Stream<GroupCallTeacherModelEntity> checkTeacherGroupCall() {
    final section = _getStorage.read(STUDENT_SECTION);

    CheckGroupCall _checkGroupCall = CheckGroupCall(_firebaseRepository);
    return _checkGroupCall(standerd: section);
  }

  void groupCallPage(teacherName) {
    final section = _getStorage.read(STUDENT_SECTION);
    Get.toNamed(Routes.GROUP_CALL, arguments: [teacherName, section, false]);
  }
}
