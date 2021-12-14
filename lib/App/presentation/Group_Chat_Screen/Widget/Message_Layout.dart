import 'package:amer_school/App/Core/asstes/Assest_Image.dart';
import 'package:amer_school/App/domain/entites/Message_Model_entity.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/Url_Image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Messagelayout extends GetWidget<GroupChatScreenController> {
  final _personInfo;
  final bool sendByStudent;
  const Messagelayout(this._personInfo, this.sendByStudent, {Key key})
      : super(key: key);

  static const SizedBox _sizedBox = SizedBox(width: 10);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.messageModel != null
        ? ListView.builder(
            reverse: true,
            itemCount: controller.messageModel.length,
            itemBuilder: (context, index) {
              //?? ============= veriable Start================ */

              controller.listBool.add(false);
              MessageModelEntity _messageModel = controller.messageModel[index];
              bool _sendByMe = sendByMe(_messageModel);
              Color _teacherMessageColor = teacherMessageColor(_messageModel);
              Alignment _alignment = textAlign(_messageModel);
              BorderRadius _borderRadius = borderRadius(_messageModel);

              //?? ============= veriable End================ */

              return Container(
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text("${_messageModel.date}"
                          .split(" ")[1]
                          .substring(0, 5)),
                    ),
                    Container(
                      alignment: _alignment,
                      child: Row(
                        mainAxisAlignment: _sendByMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (_sendByMe) ...[
                            _showMessageOrImage(
                                borderRadius: _borderRadius,
                                imageUrl: _messageModel.imageLink,
                                index: index,
                                message: _messageModel.message,
                                messageColor: _teacherMessageColor,
                                messageType: _messageModel.type),
                            _sizedBox,
                            _circleAvater(_messageModel.personProfilLink)
                          ] else ...[
                            _circleAvater(_messageModel.personProfilLink),
                            _sizedBox,
                            _showMessageOrImage(
                                borderRadius: _borderRadius,
                                imageUrl: _messageModel.imageLink,
                                index: index,
                                message: _messageModel.message,
                                messageColor: _teacherMessageColor,
                                messageType: _messageModel.type),
                          ]
                        ],
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.listBool[index],
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          alignment: _alignment,
                          margin: EdgeInsets.only(top: 5),
                          child: _messageModel.sendByStudent
                              ? Text("sendBy ${_messageModel.sendBy}")
                              : Text("sendBy Sir ${_messageModel.sendBy}"),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.listBool[index],
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          alignment: _alignment,
                          margin: EdgeInsets.only(top: 5),
                          child: Text("${_messageModel.date}".substring(0, 10)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : Container());
  }

  bool sendByMe(_messageModelEntity) {
    final String sendBy =
        sendByStudent ? _personInfo.studentName : _personInfo.teacherName;
    return _messageModelEntity.sendBy == sendBy;
  }

  Color color(_messageModelEntity) {
    return sendByMe(_messageModelEntity) ? Colors.blue : Colors.grey;
  }

  Color teacherMessageColor(_messageModelEntity) {
    return _messageModelEntity.sendByStudent
        ? color(_messageModelEntity)
        : Colors.teal;
  }

  Alignment textAlign(_messageModelEntity) {
    return sendByMe(_messageModelEntity)
        ? Alignment.centerRight
        : Alignment.centerLeft;
  }

  BorderRadius borderRadius(_messageModelEntity) {
    return sendByMe(_messageModelEntity)
        ? BorderRadius.circular(10)
        : BorderRadius.circular(10);
  }

  CircleAvatar _circleAvater(String personProfileLink) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black54,
      backgroundImage: personProfileLink != null
          ? NetworkImage(personProfileLink)
          : AssetImage(PERSON_AVATER),
    );
  }

  Container _textMessageLayout({
    BorderRadius borderRadius,
    Color messageColor,
    String message,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: messageColor,
      ),
      constraints: BoxConstraints(
        maxWidth: Get.width / 2,
      ),
      child: Text(message),
    );
  }

  GestureDetector _showMessageOrImage(
      {int index,
      String messageType,
      String imageUrl,
      BorderRadius borderRadius,
      Color messageColor,
      String message}) {
    return GestureDetector(
      onDoubleTap: () => controller.visiable(index),
      onTap: () {
        print("Working"); // New Page
      },
      child: messageType == "message"
          ? _textMessageLayout(
              borderRadius: borderRadius,
              message: message,
              messageColor: messageColor)
          : UrlImage(imageUrl: imageUrl),
    );
  }
}
