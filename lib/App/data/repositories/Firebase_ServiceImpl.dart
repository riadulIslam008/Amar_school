import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_Auth.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_FireStore.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_Storage.dart';
import 'package:amer_school/App/data/dataSources/remote/Flutter_Downloader.dart';
import 'package:amer_school/App/data/models/Group_Model.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:amer_school/App/data/models/VideoFileModel.dart';
import 'package:amer_school/App/domain/entites/Group_List_Model_Entity.dart';
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Add_Member_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/AuthParam.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Download_File.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/data/models/StudentDetailsModel.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/User_Id.dart';
import 'package:amer_school/App/domain/entites/Task_SnapShot.dart';
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
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, String>> signup(
      {@required AuthParam authParam}) async {
    try {
      final UserCredential response = await _firebaseAuthService.signup(
          email: authParam.userName, password: authParam.userPassword);

      return Right(response.user.uid);
    } catch (e) {
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
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> addMembersIngGroup(
      {AddMemberParam memberParam}) async {
    try {
      final response = await _firebaseDatabaseApi.addStudentInGroup(
          name: memberParam.name,
          roll: memberParam.roll,
          standerd: memberParam.standerd,
          profilePic: memberParam.profilePic);

      return Right(response);
    } catch (e) {
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
    } catch (e) {
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
    } catch (e) {
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
    } catch (e) {
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
    } catch (e) {
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
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Stream<List<VideoFileModel>> videoFile({String collectionName}) =>
      _firebaseDatabaseApi.videoFileCollection(collectionName: collectionName);

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
}
