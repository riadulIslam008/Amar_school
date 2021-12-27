import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class DeleteGroupCallInstance extends UseCases<void, String> {
  final FirebaseService _firebaseService;

  DeleteGroupCallInstance(this._firebaseService);

  @override
  Future<Either<AppError, void>> call(String studentSection) async =>
      await _firebaseService.deleteGroupCall(studentStanderd: studentSection);
}
