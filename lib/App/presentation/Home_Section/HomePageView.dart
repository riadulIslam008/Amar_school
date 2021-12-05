import 'package:amer_school/App/presentation/Home_Section/Widgets/Floating_Button.dart';
import 'package:amer_school/App/presentation/Home_Section/Widgets/HomepageLoading.dart';
import 'package:amer_school/App/presentation/Profile_Section/Profile.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends GetWidget<HomeViewController> {
  final bool isTeacher;
  HomePageView({Key key, this.isTeacher}) : super(key: key);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      //Todo ─── APPBAR ──────────────────────────────────────────────────────
      //
      appBar: AppBar(
        title: Text("Amar School"),
        actions: [
          isTeacher
              ? IconButton(
                  onPressed: () => Get.toNamed(Routes.GROUP_LIST_PAGE),
                  icon: Icon(Icons.people),
                )
              : IconButton(
                  onPressed: () => controller.messangerIconPressed(),
                  icon: Icon(Icons.messenger),
                ),
          SizedBox(width: 10),
          Obx(
            () => GestureDetector(
              onTap: () {
                Get.to(() =>
                    Profile(uid: controller.userUid, isTeacher: isTeacher));
              },
              child: Hero(
                tag: "goToProfilePage",
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueGrey.withOpacity(0.5),
                  backgroundImage: controller.personProfile.value.isEmpty
                      ? null
                      : NetworkImage(controller.personProfile.value),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      //
      //Todo ─── BODY ────────────────────────────────────────────────────────
      //
      body: GetBuilder<HomeViewController>(
        builder: (controller) => ListView.builder(
          itemCount: controller.videoDocs.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) =>
              HomePageLoadingView(videoFileModel: controller.videoDocs[index]),
        ),
      ),
      //
      //Todo ─── FLOATING BUTTON ────────────────────────────────────────────────────────────
      //
      floatingActionButton: FloatingButton(isTeacher: isTeacher),
    );
  }
}
