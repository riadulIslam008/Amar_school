import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:amer_school/MyApp/Services/FirebaseApi.dart';
import 'package:amer_school/MyApp/Services/VideoCallApi.dart';
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/View/ClassLiveBroadcast/BroadcastPage.dart';
import 'package:amer_school/MyApp/View/GroupCall/GroupCall.dart';
import 'package:amer_school/MyApp/controller/CallController.dart';
import 'package:amer_school/MyApp/model/MessageModel.dart';
import 'package:amer_school/MyApp/model/TeacherDetailsModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class GroupChatScreenController extends GetxController {
  final VideoCallApi videoCallApi = VideoCallApi();
  final FirebaseApi _firebaseApi = FirebaseApi();
  final GetStorage getStorage = GetStorage();
  RxBool isChanged = false.obs;

  RxList listBool = <bool>[].obs;

  TextEditingController messageController, channelNameController;
  var personType;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() async {
    messageController = TextEditingController();
    channelNameController = TextEditingController();
    personType = await getStorage.read(PERSON_TYPE);
    super.onInit();
  }

  visiable(int index) {
    listBool[index] = !listBool[index];
  }

  //Todo ============== OpenDrawer =======================##
  void openDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

  //Todo ============== PickImage ====================##
  Future<void> pickImage(
      {@required ImageSource imageSource,
      String sectionName,
      String personName,
      String personProfileImage}) async {
    XFile selectedFile = await ImagePicker().pickImage(source: imageSource);
    try {
      print(sectionName);
      if (selectedFile != null) {
        print(selectedFile);
        final String destination = "$sectionName/message";
        TaskSnapshot task =
            await _firebaseApi.uploadFile(destination, File(selectedFile.path));

        try {
          final imageUrl = await task.ref.getDownloadURL();

          await sendMessage(
            personName: personName,
            standerd: sectionName,
            personProfileImage: personProfileImage,
            type: "Image",
            imageLink: imageUrl,
          );
        } catch (e) {}
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

//Todo ================= TextField  Function =============##
  textFieldOnChange({@required String typeText}) {
    if (typeText.trim() == null) {
      isChanged.value = false;
    } else {
      isChanged.value = true;
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    channelNameController.dispose();
    super.dispose();
  }

  sendMessage(
      {String personName,
      String standerd,
      String message,
      String personProfileImage,
      String type,
      String imageLink}) async {
    MessageModel messageMap = MessageModel(
      personProfilLink: personProfileImage,
      message: message,
      sendBy: personName,
      date: DateTime.now(),
      type: type,
      sendByStudent: personType == "student" ? true : false,
      imageLink: imageLink,
    );

    bool result = await _firebaseApi.addMessageToGroup(
        messageMap: messageMap, standerd: standerd);
    print("class: $standerd");
    result
        ? print("success")
        : Get.snackbar("Send Error", "message can't send");
    messageController.clear();
  }

  clearController() {
    messageController.clear();
    channelNameController.clear();
    Get.back();
  }

  //Todo ================ Live Stream ================== ##
  void liveStream(
      String personName, String studentClass, String teacherProfile) async {
    String message = "Sir $personName is On LIVE";

    await sendMessage(
        personName: personName,
        standerd: studentClass,
        message: message,
        personProfileImage: teacherProfile);
    bool result = await videoCallApi
        .createStreamGroup(personName.toLowerCase().replaceAll(" ", ''));
    await handleCameraAndMic(Permission.camera);
    await handleCameraAndMic(Permission.microphone);

    if (result) {
      Get.to(BroadcastPage(
          channelName: personName.toLowerCase().replaceAll(" ", ''),
          role: ClientRole.Broadcaster));
    } else {
      Get.snackbar("Stream Error", "Check your Internet",
          backgroundColor: Colors.red);
    }
  }

  Future<void> handleCameraAndMic(Permission permission) async {
    await permission.request();
  }

  void groupCall(
      {@required String classStaderd,
      @required TeacherDetailsModel teacherModel}) async {
    bool result = await videoCallApi.groupCallDb(
      className: classStaderd,
      teacherModel: teacherModel,
    );
    if (result) {
      await Permission.camera.request();
      await Permission.microphone.request();
      // Get.to(
      //   () => CallPage(
      //     channelName: classStaderd,
      //     role: ClientRole.Broadcaster,
      //     personName: teacherModel.teacherName,
      //     isTeacher: true,
      //   ),
      // );
      print("channelName : $classStaderd");
     // ignore: await_only_futures
     await Get.put(CallController(channelName: classStaderd));
      Get.to(() => GroupCall());
    } else {
      return;
    }
  }
}
