import 'package:amer_school/App/data/dataSources/remote/Firebase_Auth.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_FireStore.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_Storage.dart';
import 'package:amer_school/App/data/repositories/Firebase_ServiceImpl.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/MyApp/controller/ClassRoutenController.dart';
import 'package:amer_school/MyApp/controller/GroupChatScreenController.dart';
import 'package:amer_school/MyApp/controller/GroupListViewController.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/StudentViewController.dart';
import 'package:amer_school/App/presentation/Auth_Section/Teacher_Auth_Section/TeacherViewController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseAuthService _firebaseAuthService =
        FirebaseAuthServiceImpl(_firebaseAuth);

    FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    FireStorage _fireStorage = FireStorageImpl(_firebaseStorage);

    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    FirebaseDatabaseApi _firebaseDatabaseApi =
        FirebaseDatabaseApiImpl(_firebaseFirestore);

    FirebaseService _firebaseServices = FirebaseServiceImpl(
        _firebaseAuthService, _fireStorage, _firebaseDatabaseApi);
    Get.lazyPut<StudentViewController>(
        () => StudentViewController(_firebaseServices),
        fenix: true);
    Get.lazyPut<TeacherViewController>(() => TeacherViewController(),
        fenix: true);
    Get.lazyPut<HomeViewController>(() => HomeViewController(), fenix: true);
    Get.lazyPut<GroupListViewController>(() => GroupListViewController(),
        fenix: true);
    Get.lazyPut<GroupChatScreenController>(() => GroupChatScreenController(),
        fenix: true);
    Get.lazyPut<RoutenController>(() => RoutenController(), fenix: true);
  }
}
