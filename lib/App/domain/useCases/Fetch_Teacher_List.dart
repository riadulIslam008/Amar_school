import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';

class FetchTeacherList {
  final FirebaseService _firebaseService;

  FetchTeacherList(this._firebaseService);

  Future<List<TeacherModelEntity>> call() =>
      _firebaseService.fetchTeacherList();
}
