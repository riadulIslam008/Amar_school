import 'package:amer_school/App/Core/asstes/Assest_Image.dart';
import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';

class HomePageLoadingView extends GetWidget<HomeViewController> {
  final VideoFileEntity videoFileModel;

  const HomePageLoadingView({Key key, this.videoFileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = Get.width;
    final TextStyle _style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    return Container(
      color: Colors.black.withOpacity(0.6),
      padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
      child: FocusedMenuHolder(
        blurBackgroundColor: Colors.grey,
        onPressed: () {},
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
            title: Text("PLAY"),
            onPressed: () {
              playButton();
            },
            trailingIcon: Icon(Icons.play_circle),
            backgroundColor: Colors.grey,
          ),
          FocusedMenuItem(
            title: Text("Download"),
            onPressed: () {
              downloadVideo();
            },
            trailingIcon: Icon(Icons.download),
            backgroundColor: Colors.grey,
          ),
        ],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blueGrey[400],
              backgroundImage: videoFileModel.teacherProfileImage == null
                  ? AssetImage(PERSON_AVATER)
                  : CachedNetworkImageProvider(
                      videoFileModel.teacherProfileImage),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Get.height * 0.25,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: videoFileModel.thumbnailImageLink,
                          fit: BoxFit.cover,
                          height: Get.height * 0.25,
                          width: _width,
                        ),
                        Container(
                          color: Colors.grey[800].withOpacity(.4),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                playButton();
                              },
                              child: Icon(Icons.play_circle, size: 80),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 30,
                    child: Text(
                      "Tilte: ${videoFileModel.videoTitle.capitalizeFirst}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _style,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 30,
                    child: Text(
                      "Des: ${videoFileModel.videoDescription.capitalizeFirst}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _style,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//
//Todo ─── PLAYVIDEO ──────────────────────────────────────────────────────────────────
//
  void playButton() {
    controller.videoPlay(videoLink: videoFileModel.videoFileLink);
  }

//
//Todo ─── DOWNLOAD VIDEO ─────────────────────────────────────────────────────────────
//
  void downloadVideo() {
    controller.downloadFile(
        videoUrl: videoFileModel.videoFileLink,
        fileName: videoFileModel.videoTitle);
  }
}
