import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:amer_school/App/domain/entites/Task_SnapShot.dart';
import 'package:dartz/dartz.dart';

class UploadFile extends UseCases<TaskSnap, UploadParam> {
  final FirebaseService _firebaseService;

  UploadFile(this._firebaseService);
  @override
  Future<Either<AppError, TaskSnap>> call(UploadParam uploadParam) async {
    return await _firebaseService.uploadFile(uploadParam: uploadParam);
  }
}
