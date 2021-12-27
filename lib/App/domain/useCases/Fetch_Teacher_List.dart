import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/No_Param.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class FetchTeacherList extends UseCases<List<TeacherModelEntity>, NoParam> {
  final FirebaseService _firebaseService;

  FetchTeacherList(this._firebaseService);

  @override
  Future<Either<AppError, List<TeacherModelEntity>>> call(
          NoParam params) async =>
      await _firebaseService.fetchTeacherList();
}
