import 'package:amer_school/App/domain/entites/Members_Param.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';

class StreamStudentList {
  final FirebaseService _firebaseService;

  StreamStudentList(this._firebaseService);

  Stream<List<MembersModelEntity>> call({String channelName}) =>
      _firebaseService.streamStudentList(channelName: channelName);
}
