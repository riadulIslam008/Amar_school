import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_Auth.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_FireStore.dart';
import 'package:amer_school/App/data/dataSources/remote/Firebase_Storage.dart';
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Add_Member_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/AuthParam.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Person_Param.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/MyApp/model/StudentDetailsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class FirebaseServiceImpl extends FirebaseService {
  final FirebaseAuthService _firebaseAuthService;
  final FireStorage _fireStorage;
  final FirebaseDatabaseApi _firebaseDatabaseApi;

  FirebaseServiceImpl(
      this._firebaseAuthService, this._fireStorage, this._firebaseDatabaseApi);
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
  Future<Either<AppError, String>> uploadFile({UploadParam uploadParam}) async {
    try {
      final response = await _fireStorage.uploadFile(
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
}
