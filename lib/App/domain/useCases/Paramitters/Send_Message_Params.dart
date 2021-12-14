import 'package:amer_school/App/domain/entites/Message_Model_entity.dart';
import 'package:equatable/equatable.dart';

class SendMessageParams extends Equatable {
  final MessageModelEntity messageModelEntity;
  final String studentStanderd;

  SendMessageParams(this.messageModelEntity, this.studentStanderd);
  @override
  List<Object> get props => [];
}
