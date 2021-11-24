import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/MyApp/model/StudentDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

abstract class FirebaseDatabaseApi {
  Future<void> personDetailsSave(
      {@required StudentDetailsModel personInfo});
  Future<void> addStudentInGroup({
    @required String name,
    @required String roll,
    @required String standerd,
    @required String profilePic,
  });
}

class FirebaseDatabaseApiImpl extends FirebaseDatabaseApi {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseDatabaseApiImpl(this._firebaseFirestore);

  @override
  Future<void> addStudentInGroup(
      {String name, String roll, String standerd, String profilePic}) async {
    List members = [];
    members.add({
      "name": name,
      "roll": roll,
      "profilePic": profilePic,
    });

    await _firebaseFirestore
        .collection(groups)
        .doc(standerd)
        .update({"members": FieldValue.arrayUnion(members)});
  }

  @override
  Future<void> personDetailsSave({StudentDetailsModel personInfo}) async {
    await _firebaseFirestore
        .collection("student")
        .doc(personInfo.studentUid)
        .set(personInfo.toJson());
  }
}
