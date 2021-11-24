import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Add_Member_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/AuthParam.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

abstract class FirebaseService {
  Future<Either<AppError, String>> signin({@required AuthParam authParam});
  Future<Either<AppError, String>> signup({@required AuthParam authParam});

  Future<Either<AppError, String>> uploadFile(
      {@required UploadParam uploadParam});

  Future<Either<AppError, void>> savePersonData(
      {@required StudentModelEntity studentModelEntity});
  Future<Either<AppError, void>> addMembersIngGroup(
      {@required AddMemberParam memberParam});
}
