import 'package:amer_school/MyApp/View/HomeView/widget/HomepageLoading.dart';
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/View/Profile/Profile.dart';
import 'package:amer_school/MyApp/View/TeacherList/TeacherList.dart';
import 'package:amer_school/MyApp/View/UpoloadFileView/UploadFile.dart';
import 'package:amer_school/MyApp/controller/HomeViewPageController.dart';
import 'package:amer_school/MyApp/model/VideoFileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends StatelessWidget {
  final bool isTeacher;
  HomePageView({Key key, this.isTeacher}) : super(key: key);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final controller = Get.put(HomeViewController());

  @override
  Widget build(BuildContext context) {
    VideoFileModel videoInfos;
    return Scaffold(
      //*
      //*
      //*
      appBar: AppBar(
        // backgroundColor: Colors.black,
        title: Text("Amar School"),
        actions: [
          isTeacher
              ? IconButton(
                  onPressed: () => controller.groupListIconPress(),
                  icon: Icon(Icons.people),
                )
              : IconButton(
                  onPressed: () => controller.messangerIconPressed(),
                  icon: Icon(Icons.messenger),
                ),
          SizedBox(width: 10),
          // Profile(uid: controller.userUid, isTeacher: isTeacher)
          Obx(
            () => GestureDetector(
              onTap: () {
                Get.to(() =>
                    Profile(uid: controller.userUid, isTeacher: isTeacher));
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey.withOpacity(0.5),
                backgroundImage: controller.personProfile.value.isEmpty
                    ? null
                    : NetworkImage(controller.personProfile.value),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      //*
      //*
      //*
      body: StreamBuilder(
        stream: firestore.collection(COLLECTION_NAME).snapshots(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) return Container();
          return (snapShot.hasData)
              ? Container(
                  color: Colors.blueAccent.withOpacity(0.2),
                  child: ListView.builder(
                      itemCount: snapShot.data.docs.length,
                      itemBuilder: (_, index) {
                        videoInfos = VideoFileModel.fromJson(
                            snapShot.data.docs[index].data());
                        //*
                        //*
                        return HomePageLoadingView(
                          videoFileModel: videoInfos,
                        );
                      }),
                )
              : Center(
                  child: Text("Video Content is Loading..."),
                );
        },
      ),
      //*
      //*
      //*
      floatingActionButton: isTeacher
          ? FloatingActionButton(
              onPressed: () {
                Get.to(() => UploadFileView());
              },
              tooltip: 'Upload File',
              child: Icon(Icons.cloud_download),
            )
          : FloatingActionButton(
              onPressed: () {
                Get.to(() => TeacherList());
              },
              tooltip: "Teacher list",
              child: Icon(Icons.people_outline),
            ),
    );
  }
}
