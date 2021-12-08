import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/data/models/Group_Model.dart';
import 'package:amer_school/App/data/models/MessageModel.dart';
import 'package:amer_school/App/data/models/StudentDetailsModel.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/App/data/models/VideoFileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class FirebaseDatabaseApi {
  Future<void> personDetailsSave({@required StudentDetailsModel personInfo});

  Future<void> addStudentInGroup({
    @required String name,
    @required String roll,
    @required String standerd,
    @required String profilePic,
  });

  Future<void> saveVideoFileInfos(VideoFileModel videoFileModel);

  Future<StudentDetailsModel> fetchStudentData({@required String userid});

  Future<TeacherDetailsModel> fetchTeacherDetailsModel(
      {@required String userid});

  Stream<List<VideoFileModel>> videoFile({@required String collectionName});

//** =============== Group Section =========== */
  Future<void> createGroup(GroupListModel groupListModel);

  Stream<List<GroupListModel>> fetchGroupList();

  //** ============ Message Section ========= */
  Future<void> sendMessageInDb(
      {@required MessageModel messageModel, @required String studentStanderd});

  Stream<List<MessageModel>> fetchAllMessage({@required String standerd});

  Future<List<TeacherDetailsModel>> fetchTeacherList();
}

//** **/ =============== Implemention Class ================ //
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

  @override
  Future<void> saveVideoFileInfos(VideoFileModel videoFileModel) async {
    return await _firebaseFirestore
        .collection(COLLECTION_NAME)
        .doc()
        .set(videoFileModel.toJson());
  }

  Stream<QuerySnapshot> watchCollection(String collectionName) {
    return _firebaseFirestore.collection(collectionName).snapshots();
  }

  @override
  Stream<List<GroupListModel>> fetchGroupList() {
    return _firebaseFirestore
        .collection(GROUPS)
        .snapshots()
        .map((QuerySnapshot querySnapShot) {
      List<GroupListModel> groupModel = [];
      querySnapShot.docs.forEach((QueryDocumentSnapshot element) {
        groupModel.add(GroupListModel.fromMap(element.data()));
      });
      return groupModel;
    });
  }

  @override
  Future<void> createGroup(GroupListModel groupListModel) async {
    return await _firebaseFirestore
        .collection(GROUPS)
        .doc(groupListModel.groupName)
        .set(groupListModel.toMap());
  }

  @override
  Stream<List<MessageModel>> fetchAllMessage({String standerd}) {
    return _firebaseFirestore
        .collection(GROUPS)
        .doc(standerd)
        .collection(CHATS)
        .orderBy("date", descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<MessageModel> _messageModel = [];
      querySnapshot.docs.forEach((element) {
        _messageModel.add(MessageModel.fromJson(element.data()));
      });
      return _messageModel;
    });
  }

  @override
  Stream<List<VideoFileModel>> videoFile({String collectionName}) {
    return _firebaseFirestore
        .collection("videos")
        .orderBy("date", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<VideoFileModel> _videoFileModel = [];
      query.docs.forEach((element) {
        _videoFileModel.add(VideoFileModel.fromJson(element.data()));
      });

      return _videoFileModel;
    });
  }

  @override
  Future<void> sendMessageInDb(
      {MessageModel messageModel, String studentStanderd}) async {
    return await _firebaseFirestore
        .collection(GROUPS)
        .doc(studentStanderd)
        .collection(CHATS)
        .add(messageModel.toJson());
  }

  @override
  Future<List<TeacherDetailsModel>> fetchTeacherList() async {
    final QuerySnapshot _snapshot =
        await _firebaseFirestore.collection(TEACHER_COLLECTION).get();

    List<TeacherDetailsModel> _teacherList = [];
    _snapshot.docs.forEach((QueryDocumentSnapshot element) {
      _teacherList.add(TeacherDetailsModel.fromJson(element.data()));
      return _teacherList;
    });

    return _teacherList;
  }
}
