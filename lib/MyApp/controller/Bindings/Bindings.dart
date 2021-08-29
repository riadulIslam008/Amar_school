import 'package:amer_school/MyApp/controller/ClassRoutenController.dart';
import 'package:amer_school/MyApp/controller/GroupChatScreenController.dart';
import 'package:amer_school/MyApp/controller/GroupListViewController.dart';
import 'package:amer_school/MyApp/controller/HomeViewPageController.dart';
import 'package:amer_school/MyApp/controller/StudentViewController.dart';
import 'package:amer_school/MyApp/controller/TeacherViewController.dart';
import 'package:amer_school/MyApp/controller/UploadFileController.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentViewController>(() => StudentViewController());
    Get.lazyPut<TeacherViewController>(() => TeacherViewController());
    Get.lazyPut<HomeViewController>(() => HomeViewController(), fenix: true);
    Get.lazyPut<UploadFileController>(() => UploadFileController(),
        fenix: true);
    Get.lazyPut<GroupListViewController>(() => GroupListViewController(),
        fenix: true);
    Get.lazyPut<GroupChatScreenController>(() => GroupChatScreenController(),
        fenix: true);
    Get.lazyPut<RoutenController>(() => RoutenController(), fenix: true);
  }
}
