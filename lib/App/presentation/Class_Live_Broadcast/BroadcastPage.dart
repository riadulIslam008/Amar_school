import 'package:amer_school/MyApp/Services/FirebaseApi.dart';
import 'package:amer_school/MyApp/Services/VideoCallApi.dart';
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/Utiles/app_id.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/data/models/MessageModel.dart';
import 'package:amer_school/App/data/models/StudentDetailsModel.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:get/get.dart';

class BroadcastPage extends StatefulWidget {
  final String channelName;
  final ClientRole role;
  final String standerd;

  BroadcastPage({Key key, this.channelName, this.role, this.standerd})
      : super(key: key);

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  final homeController = Get.find<HomeViewController>();
  final FirebaseApi firebaseApi = FirebaseApi();

  final _users = [];
  RtcEngine _engine;
  bool muted = false;
  final _infoStrings = <String>[];

  final FirebaseFirestore firebaseGroupCall = FirebaseFirestore.instance;
  final VideoCallApi _videoCallApi = VideoCallApi();
  StudentDetailsModel studentDetailsModel;
  TeacherDetailsModel teacherDetailsModel;

  int studentWatch = 0;

  @override
  void initState() {
    if (widget.role == ClientRole.Broadcaster) {
      teacherDetailsModel = homeController.teacherInfo;
    }
    //initial agora sdk
    initializeAgora();
    // Create Stream List

    super.initState();
  }

  @override
  void dispose() {
    //leave the channel clear list
    _users.clear();
    //leave channel destroy the engine
    _engine.destroy();
    super.dispose();
  }

  Future<void> initializeAgora() async {
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
    await _engine.joinChannel("", widget.channelName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() async {
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

    await _engine.joinChannel("", widget.channelName, null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      endDrawer: _endDrwaer(context),
      body: Center(
        child: Stack(
          children: [_broadcastView(), _toolbar()],
        ),
      ),
    );
  }

  Widget _broadcastView() {
    final views = _getRenderViews();

    return _videoView(views[0]);
  }

  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Toolbar layout
  Widget _toolbar() {
    return widget.role == ClientRole.Broadcaster
        ? Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: _onToggleMute,
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
                  onPressed: () => _onCallEnd(context),
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
                  onPressed: _onSwitchCamera,
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
          )
        : Container();
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onCallEnd(BuildContext context) async {
    if (widget.role == ClientRole.Broadcaster) {
      bool result =
          await _videoCallApi.onCallEnd(channelName: widget.channelName);
      MessageModel messageModel = MessageModel(
        personProfilLink: teacherDetailsModel.teacherProfileLink,
        message: "Live was Over",
        sendBy: teacherDetailsModel.teacherName,
        date: DateTime.now(),
        type: "message",
        sendByStudent: false,
      );
      await firebaseApi.addMessageToGroup(
          messageMap: messageModel, standerd: widget.standerd);
      if (result) {
        print("Delete complete");
      } else {
        print("Not Deleted");
      }
    }
    Get.back();
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent.withOpacity(0.8),
      leading: Icon(Icons.arrow_back),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.people)),
        SizedBox(width: 10),
      ],
    );
  }

  _endDrwaer(BuildContext context) {
    return Drawer(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: double.infinity,
        color: Colors.transparent.withOpacity(0.9),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.transparent.withOpacity(0.8),
              child: Row(
                children: [
                  Text("LIVE WATCH"),
                  SizedBox(width: 20),
                  Icon(Icons.remove_red_eye),
                  SizedBox(width: 10),
                  Text(studentWatch.toString()),
                ],
              ),
            ),
            StreamBuilder(
              stream: firebaseGroupCall
                  .collection(STREAM_GROUP)
                  .doc(widget.channelName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: Text("Stream Over"));

                return (snapshot.hasData)
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.data()["members"].length,
                        itemBuilder: (context, index) {
                          studentDetailsModel = StudentDetailsModel.fromJson(
                              snapshot.data.data()["members"][index]);
                          setState(() {
                            studentWatch =
                                snapshot.data.data()["members"].length;
                          });
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  Colors.transparent.withOpacity(0.9),
                              backgroundImage: NetworkImage(
                                  studentDetailsModel.studentProfileLink),
                            ),
                            title: Text(studentDetailsModel.studentName),
                            trailing: Text(
                                "Roll: ${studentDetailsModel.studentRoll}"),
                          );
                        },
                      )
                    : Center(child: Text("Data loading"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
