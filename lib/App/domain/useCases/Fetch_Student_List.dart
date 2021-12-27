import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class FetchStudentList extends UseCases<List, String> {
  final FirebaseService _firebaseServies;

  FetchStudentList(this._firebaseServies);

  @override
  Future<Either<AppError, List>> call(String standerd) async =>
      await _firebaseServies.fetchStudentList(standerd: standerd);
}
