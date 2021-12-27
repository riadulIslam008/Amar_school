import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:amer_school/App/presentation/Group_Call/Group_Call_Controller.dart';
import 'package:amer_school/App/Core/utils/app_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _controller = Get.find<GroupCallController>();
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = true;
  RtcEngine _engine;

  final String channelName = Get.arguments[0];
  final String studentClass = Get.arguments[1];
  final bool isTeacher = Get.arguments[2];

  dynamic _mainVdeoView;
  bool activeToolbar = true;

  @override
  void dispose() {
    if (isTeacher) _controller.deleteGroupCallStream(studentClass);
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
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
    await _engine.muteLocalAudioStream(true);
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    list.add(RtcLocalView.SurfaceView());
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Container(child: view);
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  void onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void onSwitchCamera() {
    _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    final views = _getRenderViews();
    return Scaffold(
      appBar: AppBar(
        title: Text('$studentClass Group discusses'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    activeToolbar = !activeToolbar;
                  });
                },
                child: SizedBox(
                  height: Get.height * 0.55,
                  child: _mainVdeoView == null
                      ? Container(
                          child: Center(
                            child: Text("Selecte one from here!"),
                          ),
                        )
                      : _videoView(_mainVdeoView),
                ),
              ),
              if (activeToolbar) _toolbar(),
            ],
          ),
          draggableScrollableSheet(context, 130.0, views),
          // _toolbar(),
        ],
      ),
    );
  }

  draggableScrollableSheet(context, boxwidth, groupMembersList) {
    return Expanded(
      child: Container(
        color: Colors.grey[900],
        child: GridView.builder(
          shrinkWrap: true,
          // controller: scrollController,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: boxwidth,
            // childAspectRatio: 0.72,
          ),
          itemCount: groupMembersList.length,
          itemBuilder: (contex, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _mainVdeoView = groupMembersList[index];
                });
              },
              child: Container(
                width: 130,
                height: 100,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.red,
                alignment: Alignment.topLeft,
                child: _videoView(groupMembersList[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}