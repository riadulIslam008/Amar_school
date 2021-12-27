import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/GroupCall_Params.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class GroupCallInstance extends UseCases<void, GroupCallTeacherParams> {
  final FirebaseService _firebaseService;

  GroupCallInstance(this._firebaseService);
  @override
  Future<Either<AppError, void>> call(
          GroupCallTeacherParams groupCallTeacherParams) async =>
      await _firebaseService.createGroupCallInstance(groupCallTeacherParams);
}
