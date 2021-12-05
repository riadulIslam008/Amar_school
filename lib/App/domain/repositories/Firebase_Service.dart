import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/entites/Group_List_Model_Entity.dart';
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';
import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Add_Member_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/AuthParam.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Download_File.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/User_Id.dart';
import 'package:amer_school/App/domain/entites/Task_SnapShot.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

abstract class FirebaseService {
  Future<Either<AppError, String>> signin({@required AuthParam authParam});
  Future<Either<AppError, String>> signup({@required AuthParam authParam});

  Future<Either<AppError, TaskSnap>> uploadFile(
      {@required UploadParam uploadParam});

  Future<Either<AppError, void>> savePersonData(
      {@required StudentModelEntity studentModelEntity});

  Future<Either<AppError, void>> addMembersIngGroup(
      {@required AddMemberParam memberParam});

  Future<Either<AppError, void>> saveVideoFileInfos(
      {@required VideoFileEntity videoFileEntity});

  Future<Either<AppError, StudentModelEntity>> fetchStudentData(
      {@required UserId useruid});

  Future<Either<AppError, TeacherModelEntity>> fetchTeacherModelEntity(
      {@required UserId useruid});

  Future<Either<AppError, void>> downloadFile(
      {@required DownloadFileParam downloadFileParam});

  Stream<List<VideoFileEntity>> videoFile({String collectionName});

  Future<Either<AppError, void>> createGroup(GroupModelEntity groupModelEntity);

  Stream<List<GroupModelEntity>> fetchGroupList();
}
