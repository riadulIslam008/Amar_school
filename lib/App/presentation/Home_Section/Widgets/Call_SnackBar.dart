 import 'package:amer_school/App/Core/useCases/App_Permission.dart';
import 'package:amer_school/App/presentation/Home_Section/Widgets/Incomng_Call_SnackBar.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void receiverSnackBar(data) {
    incomingCallSnackbar(data, () async {
      final PermissionStatus _camPer = await cameraPermission();
      final PermissionStatus _microPer = await microPhonePermission();
      if (_camPer.isGranted && _microPer.isGranted) {
       // controller.groupCallPage(data.teacherName);
      }
    }, () {
     // cutCall = true;
      Get.back();
    });
  }