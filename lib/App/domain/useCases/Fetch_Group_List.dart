import 'package:amer_school/App/domain/entites/Group_List_Model_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';

class FetchGroupList {
  final FirebaseService _firebaseService;

  FetchGroupList(this._firebaseService);

  Stream<List<GroupModelEntity>> call() => _firebaseService.fetchGroupList();
}
