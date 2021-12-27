import 'package:amer_school/App/Core/useCases/Global_Key.dart';
import 'package:amer_school/App/presentation/Class_Live_Broadcast/Broad_Cast_Controller.dart';
import 'package:amer_school/App/presentation/Class_Live_Broadcast/Widgets/End_Drawer.dart';
import 'package:amer_school/App/presentation/Class_Live_Broadcast/Widgets/ToolBar_Section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BroadCastview extends GetWidget<BroadCastController> {
  BroadCastview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      endDrawer: StudentListDrawer(context: context),
      body: Obx(
        () => controller.getRenderViews().isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Stack(
                  children: [
                    _broadcastView(),
                    if (!controller.isStudent) ToolBarSection(),
                  ],
                ),
              ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent.withOpacity(0.8),
      leading: InkWell(
        child: Icon(Icons.arrow_back),
        onTap: () {
          controller.isStudent
              ? controller.removeStudentFromStream()
              : controller.deleteStreamChannel();
        },
      ),
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              onPressed: () =>  scaffoldKey.currentState.openEndDrawer(),
              icon: Icon(Icons.people),
            ),
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 10,
              child: Obx(
                () => Center(
                  child: Text(
                    controller.streamWacthCounter.value.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _broadcastView() {
    final views = controller.getRenderViews();

    return _videoView(views[0]);
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Container(child: view);
  }


}
