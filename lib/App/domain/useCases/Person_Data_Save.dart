import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class PersonDataSave extends UseCases<void, StudentModelEntity> {
  final FirebaseService _firebaseService;

  PersonDataSave(this._firebaseService);
  @override
  Future<Either<AppError, void>> call(StudentModelEntity studentModelEntity) async {
    return await _firebaseService.savePersonData(studentModelEntity: studentModelEntity);
  }
}
