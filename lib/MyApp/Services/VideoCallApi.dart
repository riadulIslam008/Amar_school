import 'dart:async';

import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/model/GroupCallModel.dart';
import 'package:amer_school/MyApp/model/StudentDetailsModel.dart';
import 'package:amer_school/MyApp/model/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class VideoCallApi {
  static final FirebaseFirestore firebaseGroupCall = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> callStream(className) =>
      firebaseGroupCall.collection(GROUP_CALL).doc(className).snapshots();

  Future<bool> groupCallDb(
      {@required String className, TeacherDetailsModel teacherModel}) async {
    List _list = [];

    VideoCallModel groupCallModel = VideoCallModel(
      teacherName: teacherModel.teacherName,
      teacherProfilePic: teacherModel.teacherSubject,
      subject: teacherModel.teacherSubject,
      channelName: className,
      hasReceive: false,
      cutCall: false,
    );
    try {
      await firebaseGroupCall.collection(GROUP_CALL).doc(className).set({
        "details": "Group Discuss",
        "memberList": _list,
        "teacherInfo": groupCallModel.toJson()
      });

      return true;
    } on FirebaseException catch (e) {
      print(e);
    }

    return false;
  }

 Future<bool> groupCallEnd({@required String channelName}) async {
    try {
      // await firebaseGroupCall
      //     .collection(GROUP_CALL)
      //     .doc(channelName)
      //     .update({"members": FieldValue.delete()}).whenComplete(() {
      //   print("Field Deleted");
      // });
      await firebaseGroupCall.collection(GROUP_CALL).doc(channelName).delete();
      return true;
    } on FirebaseException catch (e) {
      print("Call DoesN't End $e");
    }
    return false;
  }
 

  //Todo ================== ## Add members In Group ## ==================
  Future<void> addMembersInGroup(
      {@required String studentName,
      @required String studentRoll,
      @required String studentClass}) async {
    List members = [];
    try {
      members.add({"name": studentName, "Roll": studentRoll});
      await firebaseGroupCall
          .collection(GROUP_CALL)
          .doc(studentClass)
          .update({"members": FieldValue.arrayUnion(members)});
      print("Array Update Done");
    } catch (e) {
      print("Error $e");
    }
  }

  //Todo ================== ## Update TeacherInfo ======================##

  Future<bool> updateCutCall(className) async {
    try {
      await firebaseGroupCall.collection(GROUP_CALL).doc(className).update({
        "teacherInfo": {
          "cutCall": true,
        }
      });
      return true;
    } on FirebaseException catch (e) {
      print(e);
    }
    return false;
  }

  //Todo ================= ## Video Stream Create Group List and show## ==================
  Future<bool> createStreamGroup(String channelName) async {
    List _members = [];
    try {
      await firebaseGroupCall.collection(STREAM_GROUP).doc(channelName).set({
        "members": _members,
      });
      return true;
    } on FirebaseException catch (e) {
      print(e);
    }
    return false;
  }

  Future addMembersInStream(
      {@required StudentDetailsModel studentDetailsModel,@required String channelName}) async {
    List _members = [];
    try {
      _members.add(studentDetailsModel.toJson());
      await firebaseGroupCall.collection(STREAM_GROUP).doc(channelName).update({
        "members": FieldValue.arrayUnion(_members),
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

   Future<bool> onCallEnd({@required String channelName}) async {
    try {
      await firebaseGroupCall
          .collection(STREAM_GROUP)
          .doc(channelName)
          .update({"members": FieldValue.delete()}).whenComplete(() {
        print("Field Deleted");
      });
      await firebaseGroupCall.collection(STREAM_GROUP).doc(channelName).delete();
      return true;
    } on FirebaseException catch (e) {
      print("Call DoesN't End $e");
    }
    return false;
  }
}
