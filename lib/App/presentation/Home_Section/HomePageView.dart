import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/Core/useCases/App_Permission.dart';
import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/domain/entites/GroupCall_Teacher_Model_Entity.dart';
import 'package:amer_school/App/presentation/Home_Section/Widgets/Floating_Button.dart';
import 'package:amer_school/App/presentation/Home_Section/Widgets/HomepageLoading.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/presentation/Home_Section/Widgets/Incomng_Call_SnackBar.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';


// ignore: must_be_immutable
class HomePageView extends GetWidget<HomeViewController> {
  HomePageView(this.isTeacher, {Key key}) : super(key: key);
  final bool isTeacher;

  bool cutCall = false;

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
                  onPressed: () => _messangerIconPressed(),
                  icon: Icon(Icons.messenger),
                ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () => isTeacher
                ? Get.toNamed(Routes.TEACHER_PROFILE,
                    arguments: [controller.teacherInfo, false])
                : Get.toNamed(Routes.STUDENT_PROFILE,
                    arguments: controller.studentModel),
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
      body: StreamBuilder<GroupCallTeacherModelEntity>(
          stream: controller.checkTeacherGroupCall(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.data.teacherName != null &&
                cutCall == false) {
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _snackBarFumction(snapshot.data));
            }

            return StreamBuilder(
              stream: controller.fetchVideoCollection(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  errorDialogBox(description: INTERNET_ERROR_MESSAGE);
                return (snapshot.hasData)
                    ? _body(snapshot.data)
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            );
          }),
      //
      //Todo ─── FLOATING BUTTON ────────────────────────────────────────────────────────────
      //
      floatingActionButton: FloatingButton(isTeacher: isTeacher),
    );
  }

  _body(data) {
    return ListView.builder(
      itemCount: data.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) =>
          HomePageLoadingView(videoFileModel: data[index]),
    );
  }

  void _messangerIconPressed() {
    Get.toNamed(Routes.STUDENT_CHAT,
        arguments: controller.studentModel.studentClass);
  }

  void _snackBarFumction(data) {
    incomingCallSnackbar(data, () async {
      final PermissionStatus _camPer = await cameraPermission();
      final PermissionStatus _microPer = await microPhonePermission();
      if (_camPer.isGranted && _microPer.isGranted) {
        controller.groupCallPage(data.teacherName);
      }
    }, () {
      cutCall = true;
      Get.back();
    });
  }
}
