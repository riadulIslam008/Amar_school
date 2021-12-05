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
  void onClose() {
    videoPlayerController.dispose();
    chewieController = null;
    super.onClose();
  }
}
