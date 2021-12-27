//??? =================== Packages ===============//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
  //** ================== Controllers =========== */
import 'package:amer_school/App/data/dataSources/remote/Firebase_Auth.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_FireStore.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_Storage.dart';
import 'package:amer_school/App/data/dataSources/remote/Flutter_Downloader.dart';
import 'package:amer_school/App/data/repositories/Firebase_ServiceImpl.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/presentation/Class_Live_Broadcast/Broad_Cast_Controller.dart';
import 'package:amer_school/App/presentation/DropDown_Section/DropDown_Controller.dart';
import 'package:amer_school/App/presentation/Group_Call/Group_Call_Controller.dart';
import 'package:amer_school/App/presentation/Profile_Section/Profile_Controller.dart';
import 'package:amer_school/App/presentation/Teacher_List/Teacher_list_Controller.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/UploadFileController.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:amer_school/App/presentation/Group_List_Section/GroupListViewController.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/StudentViewController.dart';
import 'package:amer_school/App/presentation/Auth_Section/Teacher_Auth_Section/TeacherViewController.dart';
import 'package:amer_school/App/presentation/Video_Player_Pages/VideoPageControler.dart';

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

    Get.lazyPut<DropDownController>(() => DropDownController(), fenix: true);

    Get.lazyPut<StudentViewController>(
        () => StudentViewController(_firebaseServices, _getStorage),
        fenix: true);
    Get.lazyPut<TeacherViewController>(
        () => TeacherViewController(_firebaseServices, _getStorage),
        fenix: true);
    Get.lazyPut<HomeViewController>(
        () => HomeViewController(_firebaseServices, _getStorage),
        fenix: true);
    Get.lazyPut<GroupListViewController>(
        () => GroupListViewController(_firebaseServices),
        fenix: true);
    Get.lazyPut<GroupChatScreenController>(
        () => GroupChatScreenController(_firebaseServices),
        fenix: true);

    Get.lazyPut<UploadFileController>(
        () => UploadFileController(_firebaseServices),
        fenix: true);

    Get.lazyPut<TeacherListController>(
        () => TeacherListController(_firebaseServices),
        fenix: true);
    Get.lazyPut<ProfileController>(
        () => ProfileController(_firebaseAuth, _getStorage),
        fenix: true);

    Get.lazyPut<BroadCastController>(
        () => BroadCastController(_firebaseServices),
        fenix: true);

    Get.lazyPut<VideoDisplayController>(() => VideoDisplayController(),
        fenix: true);

    Get.put(GroupCallController(_firebaseServices));
  }
}
