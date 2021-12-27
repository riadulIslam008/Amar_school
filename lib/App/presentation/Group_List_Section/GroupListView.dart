import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/presentation/Group_List_Section/GroupListViewController.dart';
import 'package:amer_school/App/presentation/Group_List_Section/Widgets/Bottom_Button.dart';
import 'package:amer_school/App/presentation/Group_List_Section/Widgets/Group_Item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupListView extends GetWidget<GroupListViewController> {
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
              child: StreamBuilder(
                stream: controller.fetchGroupList(),
                builder: (context, snapShots) {
                  if(snapShots.hasError) errorDialogBox(description: "Something Wrong");
                  return snapShots.hasData ? 
                       ListView.builder(
                          itemCount: snapShots.data.length,
                          itemBuilder: (_, index) {
                            return GroupItem(
                                groupName:
                                    snapShots.data[index].groupName);
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
