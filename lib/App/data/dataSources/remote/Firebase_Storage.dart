import 'dart:io';

import 'package:amer_school/App/domain/entites/Task_SnapShot.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

abstract class FireStorage {
  Future<TaskSnap> uploadFile(
      {@required String destination, @required File imageFile});
}

class FireStorageImpl extends FireStorage {
  final FirebaseStorage _firebaseStorage;

  FireStorageImpl(this._firebaseStorage);

  @override
  Future<TaskSnap> uploadFile({String destination, File imageFile}) async {
    Reference _filedestionation =
        _firebaseStorage.ref("images").child(destination);
    TaskSnapshot _fileUpload = await _filedestionation.putFile(imageFile);

    return TaskSnap(_fileUpload);
  }
}
