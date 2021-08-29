import 'package:amer_school/MyApp/View/AuthView/AuthPage.dart';
import 'package:amer_school/MyApp/View/Profile/Widget/CardWidget.dart';
import 'package:amer_school/MyApp/controller/GroupChatScreenController.dart';
import 'package:amer_school/MyApp/controller/HomeViewPageController.dart';
import 'package:amer_school/MyApp/model/TeacherDetailsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherProfileView extends StatelessWidget {
  final TeacherDetailsModel teacherDetailsModel;
  final bool comeFromTeacherList;

  final GetStorage getStorage = GetStorage();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final SizedBox _height = SizedBox(height: 15);
  final boxSize = Get.height / 3;

  TeacherProfileView(
      {Key key, this.teacherDetailsModel, this.comeFromTeacherList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Container(
            height: boxSize,
            //color: Colors.red,
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  height: boxSize - 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      teacherDetailsModel.quetosForStudent,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: Colors.blueGrey,
                        backgroundImage: NetworkImage(
                            teacherDetailsModel.teacherProfileLink),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _height,
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                CardWidget(
                  text: teacherDetailsModel.teacherName.toUpperCase(),
                  iconData: Icons.person,
                  textSize: 20,
                ),
                _height,
                CardWidget(
                  text: "${teacherDetailsModel.teacherSubject} Teacher",
                  iconData: Icons.subject,
                ),
                _height,
                CardWidget(
                  text: teacherDetailsModel.mobileNumber,
                  iconData: Icons.mobile_friendly_outlined,
                  function: makeCall,
                  trailingIcon: comeFromTeacherList ? Icons.call : null,
                ),
                _height,
                comeFromTeacherList
                    ? Container()
                    : CardWidget(
                        text: "LOGOUT",
                        iconData: Icons.logout_outlined,
                        color: Colors.red,
                        function: logout,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  logout() async {
    await getStorage.erase();
    await firebaseAuth.signOut();
    Get.delete<HomeViewController>(force: true);
    Get.delete<GroupChatScreenController>(force: true);
    //Get.delete<CallController>(force: true);
    Get.offAll(() => AuthPage());
  }

  makeCall() {
    if (comeFromTeacherList) {
      final int number = int.parse(teacherDetailsModel.mobileNumber);
      launch('tel://$number');
      return;
    } else {
      return;
    }
  }
}
