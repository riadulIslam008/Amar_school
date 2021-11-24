import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

abstract class FireStorage {
  Future<String> uploadFile(
      {@required String destination, @required File imageFile});
}

class FireStorageImpl extends FireStorage {
  final FirebaseStorage _firebaseStorage;

  FireStorageImpl(this._firebaseStorage);

  @override
  Future<String> uploadFile({String destination, File imageFile}) async {
    Reference _filedestionation =
        _firebaseStorage.ref("images").child(destination);
    TaskSnapshot _fileUpload = await _filedestionation.putFile(imageFile);

    return await _fileUpload.ref.getDownloadURL();
  }
}
