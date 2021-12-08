import 'package:equatable/equatable.dart';

class MessageModelEntity extends Equatable {
  final String message;
  final String sendBy;
  final DateTime date;
  final String imageLink;
  final String type;
  final bool sendByStudent;
  final String personProfilLink;

  MessageModelEntity(
    this.message,
    this.sendBy,
    this.date,
    this.imageLink,
    this.type,
    this.sendByStudent,
    this.personProfilLink,
  );

  @override
  List<Object> get props => [sendBy, message];
}
