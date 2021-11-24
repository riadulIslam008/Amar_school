import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/AuthParam.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class FirebaseSignIn extends UseCases<String, AuthParam> {
  final FirebaseService _firebaseService;

  FirebaseSignIn(this._firebaseService);
  @override
  Future<Either<AppError, String>> call(AuthParam authParam) async {
    return await _firebaseService.signin(authParam: authParam);
  }
}
