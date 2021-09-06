import 'package:amer_school/MyApp/View/AuthView/AuthPage.dart';
import 'package:amer_school/MyApp/View/Profile/Widget/CardWidget.dart';
import 'package:amer_school/MyApp/controller/GroupChatScreenController.dart';
import 'package:amer_school/MyApp/controller/HomeViewPageController.dart';
import 'package:amer_school/MyApp/model/StudentDetailsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentProfileView extends StatelessWidget {
  final StudentDetailsModel studentDetailsModel;
  // final Function function;
  StudentProfileView({
    Key key,
    this.studentDetailsModel,
  }) : super(key: key);

  final GetStorage getStorage = GetStorage();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final SizedBox _height = SizedBox(height: 15);
  final boxSize = Get.height / 3;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: boxSize,
            // color: Colors.red,
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
                      "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "goToProfilePage",
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.blueGrey.withOpacity(0.5),
                          backgroundImage: NetworkImage(studentDetailsModel.studentProfileLink)
                        ),
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
                  text: studentDetailsModel.studentName.toUpperCase(),
                  iconData: Icons.person,
                  textSize: 20,
                ),
                _height,
                CardWidget(
                  text: "Roll:- ${studentDetailsModel.studentRoll}",
                  iconData: Icons.rice_bowl_outlined,
                ),
                _height,
                CardWidget(
                  text: studentDetailsModel.studentClass,
                  iconData: Icons.class__outlined,
                ),
                _height,
                CardWidget(
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
    Get.offAll(() => AuthPage(), transition: Transition.zoom);
  }
}
