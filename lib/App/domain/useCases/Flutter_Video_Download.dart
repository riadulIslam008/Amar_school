import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Download_File.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class FlutterFileDownload extends UseCases<void, DownloadFileParam> {
  final FirebaseService _firebaseService;

  FlutterFileDownload(this._firebaseService);
  @override
  Future<Either<AppError, void>> call(DownloadFileParam downloadParam) async {
    return await _firebaseService.downloadFile(
        downloadFileParam: downloadParam);
  }
}
