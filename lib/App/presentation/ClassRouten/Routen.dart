import 'package:amer_school/App/presentation/ClassRouten/widgets/BottomSheet.dart';
import 'package:amer_school/App/presentation/ClassRouten/widgets/aContainer.dart';
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/App/presentation/ClassRouten/ClassRoutenController.dart';
import 'package:amer_school/MyApp/model/RoutenModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Routen extends GetWidget<RoutenController> {
  final bool isTeacher;

  Routen({Key key, @required this.isTeacher}) : super(key: key);

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  RoutenModel routenModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Class Shedule"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: _firebaseFirestore.collection(CLASS_ROUTEN).snapshots(),
          builder: (context, snapShot) {
            return Column(
              children: [
                SizedBox(height: 15),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                       
                        child: Container(
                          height: 50,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AContainer(dataName: "TEACHER"),
                              AContainer(dataName: "SUBJECT"),
                              AContainer(dataName: "DATA"),
                              AContainer(dataName: "TIME"),
                            ],
                          ),
                        ),
                      ),
                      if (!snapShot.hasData) Container(),
                      (snapShot.hasData)
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapShot.data.docs.length,
                              itemBuilder: (context, index) {
                                routenModel = RoutenModel.fromJson(
                                    snapShot.data.docs[index].data());
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    AContainer(dataName: routenModel.teacherName),
                                    AContainer(dataName: routenModel.subject),
                                    AContainer(dataName: routenModel.date),
                                    AContainer(dataName: routenModel.time),
                                  ],
                                );
                              })
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isTeacher,
                  child: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        BottomModal(),
                        backgroundColor: Colors.grey,
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.black,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 30),
                            SizedBox(width: 10),
                            Text("ADD SHEDULE"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
