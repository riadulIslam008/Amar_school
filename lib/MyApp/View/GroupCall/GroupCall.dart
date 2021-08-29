import 'package:amer_school/MyApp/controller/CallController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GroupCall extends GetWidget<CallController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          controller.visiable.value = !controller.visiable.value;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: <Widget>[
              controller.viewRows(),
              //_panel(),
              Obx(
                () => toolbar(),
              ),
              appBar(),
            ],
          ),
        ),
      ),
    );
  }

  Container appBar() {
    final Color _color = Colors.black;
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child:
          // CircleAvatar(
          //   radius: 25,
          //   backgroundColor: Colors.white,
          //   child: IconButton(
          //     onPressed: () => Get.back(),
          //     icon: Icon(Icons.arrow_back, color: _color),
          //   ),
          // ),
          Stack(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.transparent.withOpacity(0.5),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.people, color: _color),
            ),
          ),
          Positioned(
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.transparent.withOpacity(0.8),
              radius: 10,
              child: Center(
                child: Text(
                  "0",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Toolbar layout Row  Button
  Widget toolbar() {
    // if (role == ClientRole.Audience) return Container();
    return Visibility(
      visible: controller.visiable.value,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () => controller.onToggleMute,
              child: Icon(
                controller.muted.value ? Icons.mic_off : Icons.mic,
                color:
                    controller.muted.value ? Colors.white : Colors.blueAccent,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor:
                  controller.muted.value ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.all(12.0),
            ),
            RawMaterialButton(
              onPressed: () async {
                // ignore: await_only_futures
                await controller.onCallEnd();
                Get.delete<CallController>(force: true);
                Get.back();
              },
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
              onPressed: controller.onSwitchCamera,
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
      ),
    );
  }
}
