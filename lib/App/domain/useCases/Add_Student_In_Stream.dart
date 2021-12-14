import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Add_Member_Param.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class AddStudentInStream extends UseCases<void, AddMemberParam> {
  final FirebaseService _firebaseService;

  AddStudentInStream(this._firebaseService);
  @override
  Future<Either<AppError, void>> call(AddMemberParam params) async =>
      await _firebaseService.addStudentInStream(addMemberParam: params);
}
