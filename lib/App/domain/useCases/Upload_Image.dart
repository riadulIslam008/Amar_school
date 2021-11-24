import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Upload_File.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class UploadImage extends UseCases<String, UploadParam> {
  final FirebaseService _firebaseService;

  UploadImage(this._firebaseService);
  @override
  Future<Either<AppError, String>> call(UploadParam uploadParam) async {
    return await _firebaseService.uploadFile(uploadParam: uploadParam);
  }
}
