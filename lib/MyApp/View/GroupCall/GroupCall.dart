import 'package:amer_school/MyApp/controller/CallController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GroupCall extends GetWidget<CallController> {
  final boxwidht = Get.width / 3;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _appBar(),
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                controller.visiable.value = !controller.visiable.value;
              },
              child: controller.viewRows(context, boxwidht),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () async {
          // ignore: await_only_futures
          await controller.onCallEnd();
          Get.back();
          Get.delete<CallController>(force: true);
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: [
        Obx(
          () => IconButton(
            onPressed: () {
              controller.onToggleMute();
            },
            icon: Icon(controller.muted.value ? Icons.mic_off : Icons.mic),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.onSwitchCamera();
          },
          icon: Icon(Icons.switch_camera),
        ),
      ],
    );
  }
}
