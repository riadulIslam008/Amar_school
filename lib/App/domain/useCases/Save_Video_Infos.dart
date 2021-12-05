import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class SaveVideoInfos extends UseCases<void, VideoFileEntity> {
  final FirebaseService _firebaseService;

  SaveVideoInfos(this._firebaseService);

  @override
  Future<Either<AppError, void>> call(VideoFileEntity videoFileEntity) async {
    return _firebaseService.saveVideoFileInfos(
        videoFileEntity: videoFileEntity);
  }
}
