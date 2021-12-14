import 'dart:isolate';
import 'dart:ui';

//? ============ AppError =================//
import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';

//? ============ String ===================//
import 'package:amer_school/App/Core/utils/Universal_String.dart';

//? ============ Student Model ================//
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
//? ============ Teacher Model ================//
import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';
//? ============ Use Cases ================//
import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
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
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';

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

  Rxn<List<VideoFileEntity>> _videoFile = Rxn<List<VideoFileEntity>>();
  List<VideoFileEntity> get videosInfo => _videoFile.value;

  @override
  void onInit() {
    _videoFile.bindStream(fetchVideoCollection());
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "donwloadingVideo");
    FlutterDownloader.registerCallback(downloaderCallback);
    _receivePort.listen((message) {
    //  print(message);
    });
    initialFunction();
    super.onInit();
  }

  initialFunction() async {
    person = await _getStorage.read(PERSON_TYPES);
    stdentORteacherCheck() ? studentInit() : teacherInit();
  }

  bool stdentORteacherCheck() {
    return person == STUDENT ? true : false;
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

  messangerIconPressed() {
    Get.toNamed(Routes.STUDENT_CHAT, arguments: studentModel.studentClass);
  }

//Todo ================= Teacher View ================
  void teacherInit() async {
    userUid = await _getStorage.read(teacherUid);

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
}
