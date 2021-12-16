import 'dart:io';

//? ==================== Agora Rtc Engine ================//
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:amer_school/App/Core/errors/App_Error.dart';

//? ==================== Core Items =======================//
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/Core/useCases/Random_String.dart';
import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';

//? ==================== Models =======================//

import 'package:amer_school/App/domain/entites/Members_Param.dart';
import 'package:amer_school/App/domain/entites/Message_Model_entity.dart';
import 'package:amer_school/App/domain/entites/Task_SnapShot.dart';

//? ==================== Use Cases =======================//
import 'package:amer_school/App/domain/useCases/Add_Student_In_Stream.dart';
import 'package:amer_school/App/domain/useCases/Cereate_Stream_Instance.dart';
import 'package:amer_school/App/domain/useCases/Fetch_Messages.dart';
import 'package:amer_school/App/domain/useCases/Fetch_Student_List.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Add_Member_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Send_Message_Params.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/Send_Message_In_Firebase.dart';
import 'package:amer_school/App/domain/useCases/Upload_Image.dart';

//? ==================== Group Call =======================//
import 'package:amer_school/App/presentation/Group_Call/GroupCall.dart';
import 'package:amer_school/App/presentation/Group_Call/CallController.dart';

//? ==================== Routes =======================//
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:amer_school/MyApp/Services/VideoCallApi.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:dartz/dartz.dart';

//? ==================== Packages =======================//
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupChatScreenController extends GetxController {
  final _firebaseRepository;
  GroupChatScreenController(this._firebaseRepository);

  final VideoCallApi videoCallApi = VideoCallApi();

  final studentDetailsModel = Get.find<HomeViewController>().studentModel;
  final teacherInfo = Get.find<HomeViewController>().teacherInfo;

  RxBool isChanged = false.obs;
  RxList listBool = <bool>[].obs;
  RxList studentList = [].obs;

  final String randomString = generateRandomString(5);
  final String personType = Get.find<HomeViewController>().person;
  final String sectionName = Get.arguments;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController messageController, channelNameController;

  Rx<List<MessageModelEntity>> _messageModel = Rxn<List<MessageModelEntity>>();
  List<MessageModelEntity> get messageModel => _messageModel.value;

  @override
  void onInit() async {
    _messageModel.bindStream(fetchMessage(sectionName: sectionName));
    fetchStudentList(standerd: sectionName);
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

  //? */ ============== OpenDrawer =======================##
  void openDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

  //? */ ============== PickImage ====================##
  Future<void> pickImage(
      {selectedFile,
      String sectionName,
      String personName,
      String personProfileImage}) async {
    final String destination = "$sectionName/message";
    Get.back();

    final _either = await _uploadImage(destination, selectedFile);
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
  }

  Future<Either<AppError, TaskSnap>> _uploadImage(
      destination, selectedFile) async {
    UploadFile _uploadImage = UploadFile(_firebaseRepository);
    return await _uploadImage(
        UploadParam(destination, File(selectedFile), IMAGES));
  }

//? */ ================= TextField  Function =============##
  textFieldOnChange({@required String typeText}) {
    if (typeText.trim() == null) {
      isChanged.value = false;
    } else {
      isChanged.value = true;
    }
  }

//? */ ================= Send Message  Function =============##

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

  //? */ ================ Live Stream ================== ##
  Future<void> liveStream(
      String personName, String studentClass, String teacherProfile) async {
    String message =
        "Sir $personName is On LIVE Channel ID : $randomString    Click here for watch Live";

    MessageModelEntity _messageModel = MessageModelEntity(message, personName,
        DateTime.now(), "", "message", false, teacherProfile);

    CreateStreamInstance _createstreamDocs =
        CreateStreamInstance(_firebaseRepository);

    final _either = await _createstreamDocs(randomString);

    _either.fold((l) => errorDialogBox(description: l.errorMerrsage),
        (r) async {
      SendMessageInFirebase _sendMessageInFirebase =
          SendMessageInFirebase(_firebaseRepository);
      final _either = await _sendMessageInFirebase(
          SendMessageParams(_messageModel, studentClass));

      _either.fold((l) => errorDialogBox(description: l.errorMerrsage), (r) {
        Get.toNamed(Routes.BROAD_CAST_VIEW,
            arguments: [randomString, ClientRole.Broadcaster, false]);
      });
    });
  }

//? */ ================= Group Call  Function =============##
  void groupCall(
      {@required String classStaderd,
      @required TeacherDetailsModel teacherModel}) async {
  //   bool result = await videoCallApi.groupCallDb(
  //     className: classStaderd,
  //     teacherModel: teacherModel,
  //   );
  //   if (result) {
  //     await Permission.camera.request();
  //     await Permission.microphone.request();
  //     // ignore: await_only_futures
  //     await Get.put(CallController(
  //       channelName: classStaderd,
  //       isTeacher: true,
  //     ));
  //     Get.to(() => GroupCall());
  //   } else {
  //     return;
  //   }
  }

  //? ================ Fetch Messsages ==================//
  Stream<List<MessageModelEntity>> fetchMessage({String sectionName}) {
    FetchMessages _fetchMessage = FetchMessages(_firebaseRepository);
    return _fetchMessage(standerd: sectionName);
  }

  //? ================ Fetch Student List ==================//
  Future<void> fetchStudentList({String standerd}) async {
    FetchStudentList _fetchStudentList = FetchStudentList(_firebaseRepository);
    studentList.value = await _fetchStudentList(standerd: standerd);
  }

  //? ================ Live Stram Confrim Function ==================//
  Future<void> liveStreamConfrimForStudent({String channelId}) async {
    //Add Student in Members List
    final _either = await _addStudentInStreamList(channelId: channelId);

    _either.fold(
      (l) => errorDialogBox(description: l.errorMerrsage),
      (r) => Get.toNamed(
        Routes.BROAD_CAST_VIEW,
        arguments: [channelId, ClientRole.Audience, true],
      ),
    );
  }

  //? ================ Add Student In Firebase Function ==================//
  Future<Either<AppError, void>> _addStudentInStreamList(
      {String channelId}) async {
    final _either = await _addStudentInStream(channelName: channelId);
    return _either.fold(
        (l) => left(AppError(l.errorMerrsage)), (r) => Right(r));
  }

  Future<Either<AppError, void>> _addStudentInStream(
      {String channelName}) async {
    AddStudentInStream _addInStream = AddStudentInStream(_firebaseRepository);
    return await _addInStream(
      AddMemberParam(
        standerd: channelName,
        membersParam: MembersModelEntity(
            name: studentDetailsModel.studentName,
            roll: int.parse(studentDetailsModel.studentRoll),
            profilePic: studentDetailsModel.studentProfileLink),
      ),
    );
  }
}
