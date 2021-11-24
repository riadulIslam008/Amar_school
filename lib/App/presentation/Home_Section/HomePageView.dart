import 'package:amer_school/App/presentation/Home_Section/Widgets/Floating_Button.dart';
import 'package:amer_school/App/presentation/Home_Section/Widgets/HomepageLoading.dart';
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/View/Profile/Profile.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/MyApp/model/VideoFileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends GetWidget<HomeViewController> {
  final bool isTeacher;
  HomePageView({Key key, this.isTeacher}) : super(key: key);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    VideoFileModel videoInfos;
    return Scaffold(
    //
    // ─── APPBAR ──────────────────────────────────────────────────────
    //  
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
      // ─── BODY ────────────────────────────────────────────────────────
      //
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
  //
  // ─── FLOATING BUTTON ────────────────────────────────────────────────────────────
  //
      floatingActionButton: FloatingButton(isTeacher: isTeacher),
    );
  }
}
