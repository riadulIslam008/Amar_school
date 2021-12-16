import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Update_Stream_list_Param.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class UpdateStreamList extends UseCases<void, UpdateStreamListParam> {
  final FirebaseService _firebaseService;

  UpdateStreamList(this._firebaseService);
  @override
  Future<Either<AppError, void>> call(UpdateStreamListParam params) async =>
      await _firebaseService.updateStreamList(params);
}
