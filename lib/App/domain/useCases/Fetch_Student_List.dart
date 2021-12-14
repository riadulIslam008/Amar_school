import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';

class FetchStudentList {
  final FirebaseService _firebaseServies;

  FetchStudentList(this._firebaseServies);

  Future<List> call({String standerd}) =>
      _firebaseServies.fetchStudentList(standerd: standerd);
}
