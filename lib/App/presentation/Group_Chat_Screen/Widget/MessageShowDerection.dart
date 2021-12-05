import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';

class MessageShow extends GetWidget<GroupChatScreenController> {
  final int index;
  final BorderRadius borderRadius;
  final Color messageColor;
  final bool sendBy;
  final String messageType;
  final String message;
  final String imageUrl;
  final String personProfileLink;
  MessageShow({
    @required this.messageColor,
    @required this.borderRadius,
    @required this.sendBy,
    @required this.messageType,
    @required this.index,
    this.message,
    this.imageUrl,
    this.personProfileLink,
  });

  @override
  Widget build(BuildContext context) {
    return sendBy
        ? Row(
            children: [
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => controller.visiable(index),
                child: messageType == "message"
                    ? Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          color: messageColor,
                        ),
                        constraints: BoxConstraints(
                          maxWidth: Get.width / 2,
                        ),
                        child: Text(message))
                    : Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.grey[900],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black54,
                backgroundImage: personProfileLink != null
                    ? NetworkImage(personProfileLink)
                    : AssetImage("assets/personAvatar.jpeg"),
              ),
            ],
          )
        : Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black54,
                backgroundImage: personProfileLink != null
                    ? NetworkImage(personProfileLink)
                    : AssetImage("assets/personAvatar.jpeg"),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () => controller.visiable(index),
                child: messageType == "message"
                    ? Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          color: messageColor,
                        ),
                        constraints: BoxConstraints(
                          maxWidth: Get.width / 2,
                        ),
                        child: Text(message))
                    : CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.fill),
              ),
              Expanded(child: Container())
            ],
          );
  }
}
