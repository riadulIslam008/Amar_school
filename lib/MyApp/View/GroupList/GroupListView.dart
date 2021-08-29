import 'package:amer_school/MyApp/controller/GroupListViewController.dart';
import 'package:amer_school/MyApp/model/TeacherDetailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupListView extends GetWidget<GroupListViewController> {

  final TeacherDetailsModel teacherInfo;
    GroupListView({this.teacherInfo});
  
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<String> classList = <String>[
    "Select a Class",
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9",
    "Class 10",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //*
      //*
      //*
      appBar: AppBar(
        title: Text("Group List"),
        centerTitle: true,
      ),
      //*
      //*
      //*
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: firestore.collection("groups").snapshots(),
                builder: (context, snapShot) {
                  if (!snapShot.hasData) return Container();
                  return (snapShot.hasData)
                      ? ListView.builder(
                          itemCount: snapShot.data.docs.length,
                          itemBuilder: (context, index) {
                            String groupName =
                                snapShot.data.docs[index].data()["GroupName"];
                            Row number = classAddTH(groupName);

                            //*
                            //*
                            //*
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ListTile(
                                onTap: ()=> controller.submittedButton(teacherModel: teacherInfo, groupName: groupName),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[800],
                                  ),
                                  child: Center(child: number),
                                ),
                                title: Text(groupName),
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
          ),
          //*
          //*
  //Todo =================== Button =====================##
          MaterialButton(
            color: Colors.grey[800],
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () => showDialogButton(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text(
                      "Create Group ...",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //*
  //*
//Todo ===================== Dialog ====================
  Future showDialogButton(context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Must Select Class"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => DropdownButton(
                  value: controller.fristItemClassList.value,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: classList
                      .map(
                        (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (currentDistrick) {
                    controller.fristItemClassList.value = currentDistrick;
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    controller.createGroup(
                        className: controller.fristItemClassList.value);
                    Get.back();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  classAddTH(String groupName) {
    String classNumber = groupName.split(" ")[1];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          classNumber,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          "th",
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
