import 'dart:io';
import 'dart:typed_data';

import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/model/MessageModel.dart';
import 'package:amer_school/MyApp/model/RoutenModel.dart';
import 'package:amer_school/MyApp/model/TeacherDetailsModel.dart';
import 'package:amer_school/MyApp/model/VideoFileModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseApi {
  Reference fireStorage;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  uploadFile(String destination, File image) async {
    try {
      fireStorage = FirebaseStorage.instance.ref("class10").child(destination);

      TaskSnapshot fileUpload = await fireStorage.putFile(image);
      print(fileUpload);
      return fileUpload;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  // uploadBytes(String destination, Uint8List data) async {
  //   try {
  //     fireStorage = FirebaseStorage.instance.ref("class10").child(destination);

  //     return fireStorage.putData(data);
  //   } on FirebaseException catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  uploadVideoInfoToDb(VideoFileModel info) async {
    await firestore.collection(COLLECTION_NAME).doc().set(info.toJson());
  }

  //Todo ==================== create Group function ==================##
  createGroupInDB(List user, String groupClassName) async {
    try {
      await firestore.collection("groups").doc(groupClassName).set({
        "GroupName": groupClassName,
        "members": user,
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  //Todo ==================== Sign UP function ==================##
  Future<UserCredential> signUP(
      {@required String email, @required String password}) async {
    UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result;
  }

  //Todo ================== ## Add members In Group ## ==================
  Future<void> addMembersInGroup(
      {@required String studentName,
      @required String studentRoll,
      @required String studentClass,
      String profilePic}) async {
    List members = [];
    try {
      members.add({
        "name": studentName,
        "Roll": studentRoll,
        "profileImage": profilePic
      });
      await firestore
          .collection("groups")
          .doc(studentClass)
          .update({"members": FieldValue.arrayUnion(members)});
      print("Array Update Done");
    } catch (e) {
      print("Error $e");
    }
  }

  //Todo ================== ## Add Message In Group ## ==================
  Future<bool> addMessageToGroup(
      {@required MessageModel messageMap, @required String standerd}) async {
    try {
      await firestore
          .collection("groups")
          .doc(standerd)
          .collection(CHAT)
          .add(messageMap.toJson());
      return true;
    } catch (e) {
      print("Message Send Error $e");
      return false;
    }
  }

  //Todo ==================== Sign In function ==================##
  // ignore: missing_return
  Future<UserCredential> signIN(
      {@required String email, @required String password}) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return result;
    } on FirebaseException catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          Get.snackbar("Error", "$error", backgroundColor: Colors.red);
          break;
        case "ERROR_WRONG_PASSWORD":
          Get.snackbar("Error", "$error", backgroundColor: Colors.red);
          break;
        case "ERROR_USER_NOT_FOUND":
          Get.snackbar("Error", "$error", backgroundColor: Colors.red);
          break;
        case "ERROR_USER_DISABLED":
          Get.snackbar("Error", "$error", backgroundColor: Colors.red);
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          Get.snackbar("Error", "$error", backgroundColor: Colors.red);
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          Get.snackbar("Error", "$error", backgroundColor: Colors.red);
          break;
        default:
          Get.snackbar("Error", "$error", backgroundColor: Colors.red);
      }
    }
  }

  //Todo ==================== Teacher Data Save function ==================##
  Future<void> dataSave(
      {@required infos,
      @required String uid,
      @required String collectionName}) async {
    await firestore.collection(collectionName).doc(uid).set(infos.toJson());
  }

//Todo ====================== Student Data Save function ==================##
  // Future<void> studentDataSave(
  //     {@required TeacherDetailsModel studentInfo, @required String uid}) async {
  //   await firestore
  //       .collection(studentCollection)
  //       .doc(uid)
  //       .set(studentInfo.toJson());
  // }

  //Todo ==================== Class Routen ===============================##
  Future<void> classRouten({RoutenModel routenModel}) async {
    await firestore.collection(CLASS_ROUTEN).doc().set(routenModel.toJson());
  }
}
