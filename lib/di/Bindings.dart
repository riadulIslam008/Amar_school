import 'package:amer_school/App/data/dataSources/remote/Firebase_Auth.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_FireStore.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_Storage.dart';
import 'package:amer_school/App/data/dataSources/remote/Flutter_Downloader.dart';
import 'package:amer_school/App/data/repositories/Firebase_ServiceImpl.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/UploadFileController.dart';
import 'package:amer_school/MyApp/controller/ClassRoutenController.dart';
import 'package:amer_school/MyApp/controller/GroupChatScreenController.dart';
import 'package:amer_school/MyApp/controller/GroupListViewController.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/StudentViewController.dart';
import 'package:amer_school/App/presentation/Auth_Section/Teacher_Auth_Section/TeacherViewController.dart';
import 'package:amer_school/MyApp/controller/VideoPageControler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    GetStorage _getStorage = GetStorage();

    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseAuthService _firebaseAuthService =
        FirebaseAuthServiceImpl(_firebaseAuth);

    FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    FireStorage _fireStorage = FireStorageImpl(_firebaseStorage);

    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    FirebaseDatabaseApi _firebaseDatabaseApi =
        FirebaseDatabaseApiImpl(_firebaseFirestore);

    FlutterDownload _flutterDownload = FlutterDownloadImpl();

    FirebaseService _firebaseServices = FirebaseServiceImpl(
        _firebaseAuthService,
        _fireStorage,
        _firebaseDatabaseApi,
        _flutterDownload);

    Get.lazyPut<StudentViewController>(
        () => StudentViewController(_firebaseServices, _getStorage),
        fenix: true);
    Get.lazyPut<TeacherViewController>(() => TeacherViewController(_firebaseServices),
        fenix: true);
    Get.lazyPut<HomeViewController>(
        () => HomeViewController(_firebaseServices, _getStorage),
        fenix: true);
    Get.lazyPut<GroupListViewController>(() => GroupListViewController(),
        fenix: true);
    Get.lazyPut<GroupChatScreenController>(() => GroupChatScreenController(),
        fenix: true);
    Get.lazyPut<RoutenController>(() => RoutenController(), fenix: true);
    Get.lazyPut<UploadFileController>(
        () => UploadFileController(_firebaseServices),
        fenix: true);
  }

  videoPageCall(String videoLink) {
    Get.lazyPut<VideoDisplayController>(
        () => VideoDisplayController(videoLink: videoLink));
  }
}
