import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:amer_school/App/presentation/Class_Live_Broadcast/Broad_Cast_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToolBarSection extends GetWidget<BroadCastController> {
  const ToolBarSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.role == ClientRole.Broadcaster
        ? Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () => _onToggleMute(),
                  child: Obx(
                    () => Icon(
                      controller.muted.value ? Icons.mic_off : Icons.mic,
                      color: Colors.blue,
                      size: 20.0,
                    ),
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  //_onCallEnd(context),
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
                  onPressed: () => _onSwitchCamera(),
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

  void _onSwitchCamera() {
    controller.engine.switchCamera();
  }

  void _onToggleMute() {
    controller.muted.value = !controller.muted.value;

    controller.engine.muteLocalAudioStream(controller.muted.value);
  }
}
