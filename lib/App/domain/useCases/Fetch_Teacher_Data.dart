import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/entites/Teacher_Model_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/User_Id.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class FetchTeacherData extends UseCases<TeacherModelEntity, UserId> {
  final FirebaseService _firebaseService;

  FetchTeacherData(this._firebaseService);
  @override
  Future<Either<AppError, TeacherModelEntity>> call(UserId userId) async {
    return await _firebaseService.fetchTeacherModelEntity(useruid: userId);
  }
}
