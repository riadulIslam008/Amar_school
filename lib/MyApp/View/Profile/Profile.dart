import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/View/Profile/Widget/StudentProfile.dart';
import 'package:amer_school/MyApp/View/Profile/Widget/TeacherProfile.dart';
import 'package:amer_school/App/data/models/StudentDetailsModel.dart';
import 'package:amer_school/App/data/models/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  final String uid;
  final bool isTeacher;
  final bool teacherList;

  Profile({Key key, @required this.uid, this.isTeacher = true, this.teacherList = false})
      : super(key: key);

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  var personModel;

  @override
  Widget build(BuildContext context) {
    final String collection = isTeacher ? teacherCollection : studentCollection;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile Details"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _fireStore.collection(collection).doc(uid).get(),
          builder: (context, snapshots) {
            if (!snapshots.hasData)
              return Center(child: CircularProgressIndicator());

            personModel = isTeacher
                ? TeacherDetailsModel.fromJson(snapshots.data.data())
                : StudentDetailsModel.fromJson(snapshots.data.data());

            return (snapshots.hasData)
                ? isTeacher
                    ? TeacherProfileView(
                        teacherDetailsModel: personModel,
                        comeFromTeacherList: teacherList,
                      )
                    : StudentProfileView(
                        studentDetailsModel: personModel,
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
