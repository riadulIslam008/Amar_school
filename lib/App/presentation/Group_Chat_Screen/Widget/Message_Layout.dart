import 'package:amer_school/App/Core/Widgets_Arguments/Message_Show_Argum.dart';
import 'package:amer_school/App/domain/entites/Message_Model_entity.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Widget/MessageShowDerection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Messagelayout extends GetWidget<GroupChatScreenController> {
  final _personInfo;
  final bool sendByStudent;
  const Messagelayout(this._personInfo, this.sendByStudent, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<GroupChatScreenController>(
      builder: (controller) => controller.messageModel != null
          ? ListView.builder(
              reverse: true,
              physics: BouncingScrollPhysics(),
              itemCount: controller.messageModel.length,
              itemBuilder: (context, index) {
                MessageModelEntity _messageModelEntity =
                    controller.messageModel[index];

                //** ============= veriable Start================ */
                controller.listBool.add(false);
                bool _sendByMe = sendByMe(_messageModelEntity);
                Color _teacherMessageColor =
                    teacherMessageColor(_messageModelEntity);
                Alignment _alignment = textAlign(_messageModelEntity);
                BorderRadius _borderRadius = borderRadius(_messageModelEntity);
                //** ============= veriable Start================ */

                return Container(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text("${_messageModelEntity.date}"
                            .split(" ")[1]
                            .substring(0, 5)),
                      ),
                      // layout,
                      MessageShow(
                        messageShowArguments: MessageshowArguments(
                          borderRadius: _borderRadius,
                          imageUrl: _messageModelEntity.imageLink,
                          index: index,
                          messageColor: _teacherMessageColor,
                          sendBy: _sendByMe,
                          messageType: _messageModelEntity.type,
                          message: _messageModelEntity.message,
                          personProfileLink:
                              _messageModelEntity.personProfilLink,
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.listBool[index],
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: _alignment,
                            margin: EdgeInsets.only(top: 5),
                            child: _messageModelEntity.sendByStudent
                                ? Text("sendBy ${_messageModelEntity.sendBy}")
                                : Text(
                                    "sendBy Sir ${_messageModelEntity.sendBy}"),
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
                            child: Text(
                                "${_messageModelEntity.date}".substring(0, 10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(),
    );
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
}
