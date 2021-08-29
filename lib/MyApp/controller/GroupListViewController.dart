import 'package:amer_school/MyApp/Services/FirebaseApi.dart';
import 'package:amer_school/MyApp/View/GroupChatScreen/TeacherViewChatScreen.dart';
import 'package:amer_school/MyApp/View/GroupList/GroupListView.dart';
import 'package:amer_school/MyApp/model/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GroupListViewController extends GetxController {
  final FirebaseApi _firebaseApi = FirebaseApi();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GetStorage getStorage = GetStorage();

  RxString fristItemClassList = GroupListView().classList[0].obs;

//Todo ================ ## Create Group ## ================
  void createGroup({@required String className}) async {
    try {
      print(fristItemClassList.value);
      if (fristItemClassList.value != "Select a Class") {
        print("Group Craeting start");
        List member = [];
        await _firebaseApi.createGroupInDB(member, className);
        print("Group Craeted");
      } else {
        Get.back();
        Get.snackbar("", "select a class");
      }
    } catch (e) {
      print(e);
    }
  }

//Todo ================ ## Class Number ## ================

  submittedButton({TeacherDetailsModel teacherModel, String groupName}) {
    Get.to(() => TeacherViewChatScreen(
        teacherInfo: teacherModel, studentClass: groupName));
  }
}
