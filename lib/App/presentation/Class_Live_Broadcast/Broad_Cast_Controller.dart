import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/domain/entites/Members_Param.dart';
import 'package:amer_school/App/domain/useCases/Delete_Stream_Instance.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Update_Stream_list_Param.dart';
import 'package:amer_school/App/domain/useCases/Stream_Student_List.dart';
import 'package:amer_school/App/domain/useCases/Update_Stream_List.dart';
import 'package:amer_school/MyApp/Utiles/app_id.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class BroadCastController extends GetxController {
  final _firebaseRepository;
  BroadCastController(this._firebaseRepository);

  final String channelName = Get.arguments[0];
  final ClientRole role = Get.arguments[1];
  final bool isStudent = Get.arguments[2];

  Rx<List<MembersModelEntity>> _streamStudentList =
      Rxn<List<MembersModelEntity>>();

  List<MembersModelEntity> get streamStudentList => _streamStudentList.value;

  final users = <int>[].obs;
  RtcEngine engine;
  RxBool muted = false.obs;
  final infoStrings = <String>[].obs;
  RxInt streamWacthCounter = 0.obs;
  int viewStudentIndex = -1;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    initializeAgora();
    _streamStudentList
        .bindStream(streamStudent(channelNameFromStudent: channelName));

    super.onInit();
  }

  @override
  void onClose() {
    //leave the channel clear list
    users.clear();
    //leave channel destroy the engine
    engine.destroy();
    super.onClose();
  }

  @override
  void dispose() {
    users.clear();
    //leave channel destroy the engine
    engine.destroy();
    super.dispose();
  }

  Future<void> initializeAgora() async {
    if (APP_ID.isEmpty) {
      infoStrings.add(
        'APP_ID missing, please provide your APP_ID in settings.dart',
      );
      infoStrings.add('Agora Engine is not starting');
      return;
    }
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();

    // ignore: deprecated_member_use
    await engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await engine.setVideoEncoderConfiguration(configuration);
    await engine.joinChannel("", channelName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    engine = await RtcEngine.create(APP_ID);
    await engine.enableVideo();
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine.setClientRole(role);
  }

  void _addAgoraEventHandlers() async {
    engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      final info = 'onError: $code';
      infoStrings.add(info);
    }, joinChannelSuccess: (channel, uid, elapsed) {
      final info = 'onJoinChannel: $channel, uid: $uid';
      infoStrings.add(info);
    }, leaveChannel: (stats) {
      infoStrings.add('onLeaveChannel');
      users.clear();
    }, userJoined: (uid, elapsed) {
      final info = 'userJoined: $uid';
      infoStrings.add(info);
      users.add(uid);
    }, userOffline: (uid, elapsed) {
      final info = 'userOffline: $uid';
      infoStrings.add(info);
      users.remove(uid);
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      final info = 'firstRemoteVideo: $uid ${width}x $height';
      infoStrings.add(info);
    }));

    await engine.joinChannel("", channelName, null, 0);
  }

  getRenderViews() {
    final List<StatefulWidget> view = [];
    if (role == ClientRole.Broadcaster) view.add(RtcLocalView.SurfaceView());

    users.forEach((uid) => view.add(RtcRemoteView.SurfaceView(uid: uid)));
    return view;
  }

  Stream<List<MembersModelEntity>> streamStudent(
      {String channelNameFromStudent}) {
    StreamStudentList _streamStudentList =
        StreamStudentList(_firebaseRepository);
    return _streamStudentList(channelName: channelName);
  }

  void endDrawerOpen() {
    scaffoldKey.currentState.openEndDrawer();
  }

  void removeStudentFromStream() async {
    if (viewStudentIndex != -1) {
      streamStudentList.removeAt(viewStudentIndex);
      await updateStream();
      Get.back();
    }
  }

  Future<Either<AppError, void>> updateStream() async {
    UpdateStreamList _update = UpdateStreamList(_firebaseRepository);
    return _update(UpdateStreamListParam(
        channelId: channelName, membersList: streamStudentList));
  }

  void deleteStreamChannel() async {
    final _either = await deleteStream();
    _either.fold(
      (l) => errorDialogBox(description: l.errorMerrsage),
      (r) => Get.back(),
    );
  }

  Future<Either<AppError, void>> deleteStream() async {
    DeleteStreamInstance _deleteStream =
        DeleteStreamInstance(_firebaseRepository);

    return await _deleteStream(channelName);
  }
}
