import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/data/models/StudentDetailsModel.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

abstract class FirebaseDatabaseApi {
  Future<void> personDetailsSave({@required StudentDetailsModel personInfo});
  Future<void> addStudentInGroup({
    @required String name,
    @required String roll,
    @required String standerd,
    @required String profilePic,
  });

  Future<StudentDetailsModel> fetchStudentData({@required String userid});

  Future<TeacherDetailsModel> fetchTeacherDetailsModel(
      {@required String userid});

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

  @override
  Future<StudentDetailsModel> fetchStudentData({String userid}) async {
    final userdata =
        await _firebaseFirestore.collection(STUDENT).doc(userid).get();

    return StudentDetailsModel.fromJson(userdata.data());
  }

  @override
  Future<TeacherDetailsModel> fetchTeacherDetailsModel({String userid}) async {
    final userdata =
        await _firebaseFirestore.collection(TEACHER).doc(userid).get();

    return TeacherDetailsModel.fromJson(userdata.data());
  }

}
