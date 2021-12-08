import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/domain/entites/Message_Model_entity.dart';
import 'package:amer_school/App/domain/useCases/Fetch_Messages.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Send_Message_Params.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/Send_Message_In_Firebase.dart';
import 'package:amer_school/App/domain/useCases/Upload_Image.dart';
import 'package:amer_school/App/presentation/Class_Live_Broadcast/BroadcastPage.dart';
import 'package:amer_school/App/presentation/Group_Call/GroupCall.dart';
import 'package:amer_school/MyApp/Services/VideoCallApi.dart';
import 'package:amer_school/App/presentation/Group_Call/CallController.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class GroupChatScreenController extends GetxController {
  final _firebaseRepository;
  GroupChatScreenController(this._firebaseRepository);

  final VideoCallApi videoCallApi = VideoCallApi();
  RxBool isChanged = false.obs;
  RxList listBool = <bool>[].obs;

  TextEditingController messageController, channelNameController;
  final String personType = Get.find<HomeViewController>().person;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  final String sectionName = Get.arguments;

  Rxn<List<MessageModelEntity>> _messageModel = Rxn<List<MessageModelEntity>>();
  List<MessageModelEntity> get messageModel => _messageModel.value;
  @override
  void onInit() async {
    _messageModel.bindStream(fetchMessage(sectionName: sectionName));
    messageController = TextEditingController();
    channelNameController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    messageController.dispose();
    channelNameController.dispose();
    super.dispose();
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

    if (selectedFile != null) {
      final String destination = "$sectionName/message";
      Get.back();
      UploadFile _uploadImage = UploadFile(_firebaseRepository);
      final _either = await _uploadImage(
          UploadParam(destination, File(selectedFile.path), IMAGES));
      _either.fold((l) => errorDialogBox(description: l.errorMerrsage),
          (uploadedImageUrl) async {
        MessageModelEntity _messageModel = MessageModelEntity(
            null,
            personName,
            DateTime.now(),
            await uploadedImageUrl.taskSnapshot.ref.getDownloadURL(),
            IMAGES,
            personType == STUDENT ? true : false,
            personProfileImage);

        sendMessage(messageMap: _messageModel, standerd: sectionName);
      });
    } else {
      return null;
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

  Future<void> sendMessage(
      {MessageModelEntity messageMap, String standerd}) async {
    SendMessageInFirebase _sendMessageInFirebase =
        SendMessageInFirebase(_firebaseRepository);
    final _either =
        await _sendMessageInFirebase(SendMessageParams(messageMap, standerd));

    _either.fold(
        (l) => errorDialogBox(description: l.errorMerrsage), (r) => null);
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
      // personName: personName,
      standerd: studentClass,
      // message: message,
      // personProfileImage: teacherProfile,
      // type: "message",
    );
    bool result = await videoCallApi
        .createStreamGroup(personName.toLowerCase().replaceAll(" ", ''));
    await Permission.camera.request();
    await Permission.microphone.request();

    if (result) {
      Get.to(
        BroadcastPage(
            channelName: personName.toLowerCase().replaceAll(" ", ''),
            role: ClientRole.Broadcaster,
            standerd: studentClass),
      );
    } else {
      Get.snackbar("Stream Error", "Check your Internet",
          backgroundColor: Colors.red);
    }
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
      // ignore: await_only_futures
      await Get.put(CallController(
        channelName: classStaderd,
        isTeacher: personType == true,
      ));
      Get.to(() => GroupCall());
    } else {
      return;
    }
  }

  //* ================ Fetch Messsages ==================
  fetchMessage({String sectionName}) {
    FetchMessages _fetchMessage = FetchMessages(_firebaseRepository);
    return _fetchMessage(standerd: sectionName);
  }
}
