import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amer_school/MyApp/Services/FirebaseApi.dart';
import 'package:amer_school/MyApp/Services/VideoCallApi.dart';
import 'package:amer_school/MyApp/Utiles/app_id.dart';
import 'package:amer_school/MyApp/controller/HomeViewPageController.dart';
import 'package:amer_school/MyApp/model/MessageModel.dart';

class CallController extends GetxController {
  final String channelName;
  final bool isTeacher;

  CallController({
    @required this.channelName,
    @required this.isTeacher,
  });
  final homeController = Get.find<HomeViewController>();

  final _infoStrings = <String>[].obs;
  RtcEngine _engine;
  final _users = <int>[].obs;
  RxBool muted = false.obs;
  RxBool visiable = false.obs;
  final FirebaseApi _firebaseApi = FirebaseApi();

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  @override
  void dispose() {
    _users.clear();
    //leave channel destroy the engine
    _engine.destroy();
    super.dispose();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      _infoStrings.add(
        'APP_ID missing, please provide your APP_ID in settings.dart',
      );
      _infoStrings.add('Agora Engine is not starting');

      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    // ignore: deprecated_member_use
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel("", channelName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);

    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(
      RtcEngineEventHandler(
        error: (code) {
          final info = 'onError: $code';
          _infoStrings.add(info);
        },
        joinChannelSuccess: (channel, uid, elapsed) {
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        },
        leaveChannel: (stats) {
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        },
        userJoined: (uid, elapsed) {
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          _users.add(uid);
        },
        userOffline: (uid, elapsed) {
          final info = 'userOffline: $uid';
          _infoStrings.add(info);
          _users.remove(uid);
        },
        firstRemoteVideoFrame: (uid, width, height, elapsed) {
          final info = 'firstRemoteVideo: $uid ${width}x $height';
          _infoStrings.add(info);
        },
      ),
    );
  }

  void onCallEnd() async {
    // await _videoCallApi.updateCutCall(widget.channelName);
    await VideoCallApi().groupCallEnd(channelName: channelName);
  }

  /// Helper function to get list of native views
  List<Widget> getRenderViews() {
    final List<StatefulWidget> list = [];

    list.add(RtcLocalView.SurfaceView());

    return list;
  }

  /// Video view wrapper
  Widget videoView(view) {
    return Expanded(child: Container(child: view));
  }

  Widget expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget viewRows() {
    final views = getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
          child: Column(
            children: <Widget>[videoView(views[0])],
          ),
        );
      case 2:
        return Container(
            child: Stack(
          children: <Widget>[
            expandedVideoRow([views[0]]),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: SizedBox(
                height: 160,
                width: 130,
                child: expandedVideoRow([views[1]]),
              ),
            ),
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            expandedVideoRow(views.sublist(0, 2)),
            expandedVideoRow(views.sublist(2, 3)),
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            expandedVideoRow(views.sublist(0, 2)),
            expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  void onSwitchCamera() {
    _engine.switchCamera();
  }

  void onToggleMute() {
    muted.value = !muted.value;
    _engine.muteLocalAudioStream(muted.value);
  }

  broadCastEndMesage() async {
    MessageModel messageMap = MessageModel(
      message: "Group Call has been finished",
      sendBy: homeController.teacherInfo.teacherName,
      sendByStudent: false,
      type: "message",
      date: DateTime.now(),
      personProfilLink: homeController.teacherInfo.teacherProfileLink,
    );
    await _firebaseApi.addMessageToGroup(
        messageMap: messageMap, standerd: channelName);
  }

  @override
  void onClose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.onClose();
  }
}
