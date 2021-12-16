import 'package:equatable/equatable.dart';

class UpdateStreamListParam extends Equatable {
  final String channelId;
  final List membersList;

  UpdateStreamListParam({this.channelId, this.membersList});

  @override
  List<Object> get props => [];
}
