import 'package:amer_school/App/presentation/Group_List_Section/Widgets/Bottom_Button.dart';
import 'package:amer_school/App/presentation/Group_List_Section/GroupListViewController.dart';
import 'package:amer_school/App/presentation/Group_List_Section/Widgets/Group_Item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //*
      //*
      appBar: AppBar(
        title: Text("Group List"),
        centerTitle: true,
      ),
      //*
      //*
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GetBuilder<GroupListViewController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.groupList.length,
                    itemBuilder: (_, index) {
                      return GroupItem(
                          groupName: controller.groupList[index].groupName);
                    },
                  );
                },
              ),
            ),
          ),
          //*
          //*
          //Todo =================== Button =====================##
          BottomButton(),
        ],
      ),
    );
  }
}
