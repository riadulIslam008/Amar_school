import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/MyApp/View/Profile/Profile.dart';
import 'package:amer_school/MyApp/model/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TeacherList extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TeacherDetailsModel teacherDetailsModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Teacher List"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: firestore.collection(teacherCollection).get(),
          builder: (context, snapshots) {
            if (!snapshots.hasData)
              return Center(
                child: Text("No list"),
              );
            return (snapshots.hasData)
                ? ListView.builder(
                    itemCount: snapshots.data.docs.length,
                    itemBuilder: (context, index) {
                      teacherDetailsModel = TeacherDetailsModel.fromJson(
                          snapshots.data.docs[index].data());
                      return Card(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                              teacherDetailsModel.teacherName.toUpperCase()),
                          subtitle: Text(
                              "${teacherDetailsModel.teacherSubject} Teacher"),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[400],
                            backgroundImage: NetworkImage(
                                teacherDetailsModel.teacherProfileLink),
                          ),
                          trailing: Icon(Icons.arrow_right),
                          onTap: () {
                            Get.to(() => Profile(
                                uid: snapshots.data.docs[index]
                                    .data()["teacherUid"], teacherList: true));
                          },
                        ),
                      );
                    },
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
