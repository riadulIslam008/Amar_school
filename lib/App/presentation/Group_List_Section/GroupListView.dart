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
              child: GetX<GroupListViewController>(
                builder: (controller) {
                  return controller.groupModelEntity != null
                      ? ListView.builder(
                          itemCount: controller.groupModelEntity.length,
                          itemBuilder: (_, index) {
                            return GroupItem(
                                groupName:
                                    controller.groupModelEntity[index].groupName);
                          },
                        )
                      : Container();
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
