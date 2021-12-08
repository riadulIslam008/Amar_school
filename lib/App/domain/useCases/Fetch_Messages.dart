import 'package:amer_school/App/domain/entites/Message_Model_entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';

class FetchMessages {
  final FirebaseService _firebaseService;

  FetchMessages(this._firebaseService);

  Stream<List<MessageModelEntity>> call({String standerd}) =>
      _firebaseService.fetchMessageModel(standerd: standerd);
}
