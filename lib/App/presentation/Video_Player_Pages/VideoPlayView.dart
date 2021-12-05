import 'package:amer_school/App/presentation/Video_Player_Pages/VideoPageControler.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoPlayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RawMaterialButton(
          onPressed: () {
            Get.back();
            Get.delete<VideoDisplayController>(force: true);
           
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Video Play"),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: VideoDisplayController(),
        builder: (controller) {
          return controller.chewieController != null
              ? Chewie(controller: controller.chewieController)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
