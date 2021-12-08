import 'package:flutter/material.dart';

class MessageshowArguments {
  final int index;
  final BorderRadius borderRadius;
  final Color messageColor;
  final bool sendBy;
  final String messageType;
  final String message;
  final String imageUrl;
  final String personProfileLink;

  MessageshowArguments({
    @required this.index,
    @required this.borderRadius,
    @required this.messageColor,
    @required this.sendBy,
    @required this.messageType,
    @required this.message,
    @required this.imageUrl,
    @required this.personProfileLink,
  });
}
