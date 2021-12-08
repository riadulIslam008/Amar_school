import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:amer_school/App/domain/entites/Message_Model_entity.dart';
import 'package:amer_school/App/presentation/ClassRouten/Routen.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/TextButtonWidget.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MessageBoxsection extends GetWidget<GroupChatScreenController> {
  @required
  final BuildContext context;
  final String name;
  final String standerd;
  final String personProfileImage;
  final bool isTeacher;

  MessageBoxsection(
      {this.isTeacher,
      this.personProfileImage,
      this.context,
      this.name,
      this.standerd});

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[200],
              )),
          child: IconButton(
            onPressed: () => showDialogButton(context),
            icon: Icon(Icons.link_rounded),
          ),
        ),
        Expanded(
          child: Container(
            height: 60,
            child: TextField(
              onChanged: (String typeText) =>
                  controller.textFieldOnChange(typeText: typeText),
              cursorHeight: 30,
              maxLines: null,
              scrollController: _scrollController,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              controller: controller.messageController,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 50,
          width: 50,
          child: IconButton(
            onPressed: () {
              MessageModelEntity _messageModel = MessageModelEntity(
                  controller.messageController.text,
                  name,
                  DateTime.now(),
                  null,
                  MESSAGE,
                  controller.personType == STUDENT ? true : false,
                  personProfileImage);

              controller.sendMessage(
                messageMap: _messageModel,
                standerd: standerd,
              );
            },
            icon: Icon(
              Icons.send,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showDialogButton(context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButtonWidget(
                buttonText: "Camera",
                onclick: () => controller.pickImage(
                  imageSource: ImageSource.camera,
                  personName: name,
                  sectionName: standerd,
                  personProfileImage: personProfileImage,
                ),
              ),
              Divider(thickness: 1, color: Colors.grey),
              TextButtonWidget(
                buttonText: "Gallery",
                onclick: () => controller.pickImage(
                  imageSource: ImageSource.gallery,
                  personName: name,
                  sectionName: standerd,
                  personProfileImage: personProfileImage,
                ),
              ),
              Divider(thickness: 1, color: Colors.grey),
              TextButtonWidget(
                buttonText: "Class Routen",
                onclick: () {
                  Get.to(Routen(isTeacher: isTeacher));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
