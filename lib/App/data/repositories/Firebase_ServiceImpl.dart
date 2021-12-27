import 'dart:io';
  //** =========== Core Error and String */
import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/Core/errors/Firebase_Exception_Errors.dart';
import 'package:amer_school/App/Core/utils/Universal_String.dart';

//** =========== From Data Sources ============  */
import 'package:amer_school/App/data/dataSources/remote/Firebase_Auth.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_FireStore.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_Storage.dart';
import 'package:amer_school/App/data/dataSources/remote/Flutter_Downloader.dart';

//** =============== Models ================= */
import 'package:amer_school/App/data/models/GroupCall_Teacher_Model.dart';
import 'package:amer_school/App/data/models/Group_Model.dart';
import 'package:amer_school/App/data/models/Members_List_Model.dart';
import 'package:amer_school/App/data/models/MessageModel.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:amer_school/App/data/models/VideoFileModel.dart';
import 'package:amer_school/App/data/models/StudentDetailsModel.dart';

//** =============== Model Entity ==================== */
import 'package:amer_school/App/domain/entites/GroupCall_Teacher_Model_Entity.dart';
import 'package:amer_school/App/domain/entites/Group_List_Model_Entity.dart';
import 'package:amer_school/App/domain/entites/Members_Param.dart';
import 'package:amer_school/App/domain/entites/Message_Model_entity.dart';
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';
import 'package:amer_school/App/domain/entites/Task_SnapShot.dart';
import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';

 //** ============= Use Case Param ================== */
import 'package:amer_school/App/domain/useCases/Paramitters/Add_Member_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/AuthParam.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Download_File.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/GroupCall_Params.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Send_Message_Params.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Update_Stream_list_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/User_Id.dart';

import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
//?? ========== Packages ===========
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class FirebaseServiceImpl extends FirebaseService {
  final FirebaseAuthService _firebaseAuthService;
  final FireStorage _fireStorage;
  final FirebaseDatabaseApi _firebaseDatabaseApi;
  final FlutterDownload _flutterDownload;

  FirebaseServiceImpl(this._firebaseAuthService, this._fireStorage,
      this._firebaseDatabaseApi, this._flutterDownload);
  @override
  Future<Either<AppError, String>> signin(
      {@required AuthParam authParam}) async {
    try {
      UserCredential response = await _firebaseAuthService.signin(
          email: authParam.userName, password: authParam.userPassword);

      return Right(response.user.uid);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on FirebaseException catch (e) {
      return Left(AppError(firebaseError(e)));
    }
  }

  @override
  Future<Either<AppError, String>> signup(
      {@required AuthParam authParam}) async {
    try {
      final UserCredential response = await _firebaseAuthService.signup(
          email: authParam.userName, password: authParam.userPassword);

      return Right(response.user.uid);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, TaskSnap>> uploadFile(
      {UploadParam uploadParam}) async {
    try {
      final response = await _fireStorage.uploadFile(
          sectionName: uploadParam.sectionName,
          destination: uploadParam.destination,
          imageFile: uploadParam.imageFile);
      return Right(response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> addMembersIngGroup(
      {AddMemberParam memberParam}) async {
    try {
      final response = await _firebaseDatabaseApi.addStudentInGroup(
        standerd: memberParam.standerd,
        membersListModel:
            MembersListModel.fromMembersListEntity(memberParam.membersParam),
      );

      return Right(response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> savePersonData(
      {StudentModelEntity studentModelEntity}) async {
    try {
      final response = await _firebaseDatabaseApi.personDetailsSave(
          personInfo: StudentDetailsModel.fromJsonStudentModelEntity(
              studentModelEntity));
      return Right(response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, StudentDetailsModel>> fetchStudentData(
      {UserId useruid}) async {
    try {
      final response =
          await _firebaseDatabaseApi.fetchStudentData(userid: useruid.userid);
      return Right(response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, TeacherDetailsModel>> fetchTeacherModelEntity(
      {UserId useruid}) async {
    try {
      final response = await _firebaseDatabaseApi.fetchTeacherDetailsModel(
          userid: useruid.userid);
      return Right(response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> downloadFile(
      {DownloadFileParam downloadFileParam}) async {
    try {
      final response = await _flutterDownload.downloadFile(
          videoUrl: downloadFileParam.videoUrl,
          fileName: downloadFileParam.fileName);
      return Right(response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> saveVideoFileInfos(
      {VideoFileEntity videoFileEntity}) async {
    try {
      final response = await _firebaseDatabaseApi.saveVideoFileInfos(
          VideoFileModel.fromVideoFileEntity(videoFileEntity));

      return Right(response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Stream<List<GroupListModel>> fetchGroupList() =>
      _firebaseDatabaseApi.fetchGroupList();

  @override
  Future<Either<AppError, void>> createGroup(
      GroupModelEntity groupModelEntity) async {
    try {
      final response = await _firebaseDatabaseApi
          .createGroup(GroupListModel.fromGroupModelEntity(groupModelEntity));

      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Stream<List<MessageModelEntity>> fetchMessageModel({String standerd}) {
    return _firebaseDatabaseApi.fetchAllMessage(standerd: standerd);
  }

  @override
  Stream<List<VideoFileEntity>> videoFileGet({String collectionName}) =>
      _firebaseDatabaseApi.videoFile(collectionName: collectionName);

  @override
  Future<Either<AppError, void>> sendMessageInDatabase(
      SendMessageParams sendMessageParams) async {
    try {
      final response = await _firebaseDatabaseApi.sendMessageInDb(
          messageModel: MessageModel.fromMessageModelEntity(
              sendMessageParams.messageModelEntity),
          studentStanderd: sendMessageParams.studentStanderd);

      return Right(response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<TeacherModelEntity>>> fetchTeacherList() async {
    try {
      return Right(await _firebaseDatabaseApi.fetchTeacherList());
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, List>> fetchStudentList({String standerd}) async {
    try {
      return Right(
          await _firebaseDatabaseApi.fetchMembersList(standerd: standerd));
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> createStreamInstance(
      {String channelName}) async {
    try {
      final snapShot = await _firebaseDatabaseApi.createStreamCallInstance(
          channelName: channelName);
      return Right(snapShot);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> addStudentInStream(
      {AddMemberParam addMemberParam}) async {
    try {
      final response = await _firebaseDatabaseApi.addStudentInLiveStreamList(
          channelID: addMemberParam.standerd,
          memberListModel: MembersListModel.fromMembersListEntity(
              addMemberParam.membersParam));

      return Right(response);
    } on SocketException {
      return Left(AppError("Check your Internet and try again 😂"));
    } on FirebaseException catch (e) {
      print(e);
      return Left(AppError(e.toString()));
    }
  }

  @override
  Stream<List<MembersModelEntity>> streamStudentList({String channelName}) =>
      _firebaseDatabaseApi.fetchLiveStreamStudentList(channelName: channelName);

  @override
  Future<Either<AppError, void>> updateStreamList(
      UpdateStreamListParam updateStreamListParam) async {
    try {
      final _response = _firebaseDatabaseApi.updateStreamList(
          channelName: updateStreamListParam.channelId,
          membersList: updateStreamListParam.membersList);
      return Right(_response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> deleteStreamInstance(
      {String channelName}) async {
    try {
      final _response = await _firebaseDatabaseApi.deleteStreamInstance(
          channelName: channelName);
      return Right(_response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> createGroupCallInstance(
      GroupCallTeacherParams groupCallParams) async {
    try {
      final _response = await _firebaseDatabaseApi.groupCallInstanceCreate(
          studentStanderd: groupCallParams.studentStanderd,
          groupCallTeacherModel: GroupCallTeacherModel.fromTeacherEntity(
              groupCallParams.groupCallTeacherModelEntity));
      return Right(_response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Stream<GroupCallTeacherModelEntity> cheackGroupCall(
          {String studentStanderd}) =>
      _firebaseDatabaseApi.checkGroupCallInstance(
          studentStanderd: studentStanderd);

  @override
  Future<Either<AppError, void>> deleteGroupCall(
      {String studentStanderd}) async {
    try {
      final _response = await _firebaseDatabaseApi.deleteGroupCallInstance(
          studentStanderd: studentStanderd);
      return Right(_response);
    } on SocketException {
      return Left(AppError(INTERNET_ERROR_MESSAGE));
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}
