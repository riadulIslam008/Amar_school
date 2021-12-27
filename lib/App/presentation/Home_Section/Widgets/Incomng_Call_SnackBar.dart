import 'package:amer_school/App/domain/entites/GroupCall_Teacher_Model_Entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void incomingCallSnackbar(GroupCallTeacherModelEntity teacherInfo,
    VoidCallback callReceiver, VoidCallback cancleCall) {
  Get.snackbar(
    "",
    "",
    padding: const EdgeInsets.all(0),
    duration: Duration(seconds: 10),
    titleText: ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.red,
        child: RotatedBox(
          quarterTurns: 90,
          child: InkWell(
            child: Icon(Icons.call, color: Colors.white),
            onTap: cancleCall,
          ),
        ),
      ),
      title: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: teacherInfo.teacherProfile,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Text(teacherInfo.teacherName)
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Text("is calling you"),
      ),
      trailing: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.green,
        child: InkWell(
          child: Icon(Icons.call, color: Colors.white),
          onTap: callReceiver,
        ),
      ),
    ),
  );
}
