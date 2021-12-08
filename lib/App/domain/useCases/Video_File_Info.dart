import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';

class VideoFileInfo {
  final FirebaseService _firebaseService;

  VideoFileInfo(this._firebaseService);

  Stream<List<VideoFileEntity>> call({String collectionName}) =>
      _firebaseService.videoFileGet();
}
