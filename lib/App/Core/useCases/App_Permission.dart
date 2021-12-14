import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> cameraPermission() async =>
    await Permission.camera.request();

Future<PermissionStatus> microPhonePermission() async =>
    await Permission.microphone.request();
