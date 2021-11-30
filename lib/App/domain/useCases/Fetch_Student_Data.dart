import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/User_Id.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class FetchStudentData extends UseCases<StudentModelEntity, UserId> {
  final FirebaseService _firebaseService;

  FetchStudentData(this._firebaseService);
  @override
  Future<Either<AppError, StudentModelEntity>> call(UserId useruid) async {
    return await _firebaseService.fetchStudentData(useruid: useruid);
  }
}
