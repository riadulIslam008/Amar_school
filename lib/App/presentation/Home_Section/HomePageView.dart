import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/presentation/Home_Section/Widgets/Floating_Button.dart';
import 'package:amer_school/App/presentation/Home_Section/Widgets/HomepageLoading.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends GetWidget<HomeViewController> {
  final bool isTeacher;
  HomePageView({Key key, this.isTeacher}) : super(key: key);

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
          GestureDetector(
            onTap: () => controller.stdentORteacherCheck()
                ? Get.toNamed(Routes.STUDENT_PROFILE,
                    arguments: controller.studentModel)
                : Get.toNamed(Routes.TEACHER_PROFILE,
                    arguments: [controller.teacherInfo, false]),
            child: Hero(
              tag: PROFILE_TAG,
              child: Obx(
                () => CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueGrey.withOpacity(0.5),
                  backgroundImage: controller.personProfile.value.isEmpty
                      ? null
                      : CachedNetworkImageProvider(
                          controller.personProfile.value),
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
      body: GetX<HomeViewController>(
        builder: (controller) {
          return controller.videosInfo != null
              ? ListView.builder(
                  itemCount: controller.videosInfo.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) => HomePageLoadingView(
                      videoFileModel: controller.videosInfo[index]),
                )
              : Container();
        },
      ),
      //
      //Todo ─── FLOATING BUTTON ────────────────────────────────────────────────────────────
      //
      floatingActionButton: FloatingButton(isTeacher: isTeacher),
    );
  }
}
