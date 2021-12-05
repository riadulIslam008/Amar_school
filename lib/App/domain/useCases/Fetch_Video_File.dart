import 'package:amer_school/App/domain/entites/Video_File_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:flutter/cupertino.dart';

class FetchVideoFile {
  final FirebaseService _firebaseService;

  FetchVideoFile(this._firebaseService);

  Stream<List<VideoFileEntity>> call({@required String collectionName}) {
    return _firebaseService.videoFile(collectionName: collectionName);
  }
}
