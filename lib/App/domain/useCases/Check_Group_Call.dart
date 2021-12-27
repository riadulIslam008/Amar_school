import 'package:amer_school/App/domain/entites/GroupCall_Teacher_Model_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';

class CheckGroupCall {
  final FirebaseService _firebaseService;

  CheckGroupCall(this._firebaseService);

    Stream<GroupCallTeacherModelEntity> call({String standerd}) =>
      _firebaseService.cheackGroupCall(studentStanderd: standerd);
}
