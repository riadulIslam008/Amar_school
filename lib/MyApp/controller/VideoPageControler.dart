import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoDisplayController extends GetxController {
  final String videoLink;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  VideoDisplayController({this.videoLink});
  @override
  void onInit() {
    initializedPlayer();
    super.onInit();
  }

  initializedPlayer() async {
    videoPlayerController = VideoPlayerController.network(videoLink);
    await Future.wait([videoPlayerController.initialize()]);

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      looping: true,
      aspectRatio: 16 / 9,
      autoInitialize: true,
    );

    update();
  }

  @override
  void dispose() {
    try {
       super.dispose();
      Future.delayed(Duration.zero, () {
        if (chewieController != null && videoPlayerController != null) {
          videoPlayerController.dispose();
          chewieController.dispose();
          videoPlayerController = null;
          chewieController = null;
        }
      });
    } catch (e) {
      print(e);
    }
   
  }

  @override
  void onClose() {
     super.onClose();
    videoPlayerController = null;
   // videoPlayerController.dispose();
   // chewieController = null;
    chewieController.dispose();

   
  }
}







  // initializedPlayer({@required String videoLink}) async {
  //   videoPlayerController = VideoPlayerController.network(videoLink);
  //   await Future.wait([videoPlayerController.initialize()]);
  //   chewieController = ChewieController(
  //     videoPlayerController: videoPlayerController,
  //     looping: true,
  //     aspectRatio: 16 / 9,
  //     autoInitialize: true,
  //   );
  // }
