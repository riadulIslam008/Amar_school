import 'package:amer_school/App/Core/Widgets_Arguments/Message_Show_Argum.dart';
import 'package:amer_school/App/Core/asstes/Assest_Image.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/Url_Image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';

class MessageShow extends GetWidget<GroupChatScreenController> {
  final MessageshowArguments messageShowArguments;
  MessageShow({@required this.messageShowArguments});

  static const SizedBox _sizedBox = SizedBox(width: 10);

  @override
  Widget build(BuildContext context) {
    return messageShowArguments.sendBy
        ? Row(
            children: [
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => controller.visiable(messageShowArguments.index),
                child: messageShowArguments.messageType == "message"
                    ? _textMessageLayout()
                    : UrlImage(imageUrl: messageShowArguments.imageUrl),
              ),
              _sizedBox,
              _circleAvater(),
            ],
          )
        : Row(
            children: [
              _circleAvater(),
              _sizedBox,
              GestureDetector(
                onTap: () => controller.visiable(messageShowArguments.index),
                child: messageShowArguments.messageType == "message"
                    ? _textMessageLayout()
                    : UrlImage(imageUrl: messageShowArguments.imageUrl),
              ),
              Expanded(child: Container())
            ],
          );
  }

  CircleAvatar _circleAvater() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black54,
      backgroundImage: messageShowArguments.personProfileLink != null
          ? NetworkImage(messageShowArguments.personProfileLink)
          : AssetImage(PERSON_AVATER),
    );
  }

  Container _textMessageLayout() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: messageShowArguments.borderRadius,
        color: messageShowArguments.messageColor,
      ),
      constraints: BoxConstraints(
        maxWidth: Get.width / 2,
      ),
      child: Text(messageShowArguments.message),
    );
  }
}
