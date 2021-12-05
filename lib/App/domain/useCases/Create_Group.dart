import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/entites/Group_List_Model_Entity.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class CreateGroup extends UseCases<void, GroupModelEntity> {
  final FirebaseService _firebaseService;

  CreateGroup(this._firebaseService);
  @override
  Future<Either<AppError, void>> call(
      GroupModelEntity _groupModelEntity) async {
    return _firebaseService.createGroup(_groupModelEntity);
  }
}
