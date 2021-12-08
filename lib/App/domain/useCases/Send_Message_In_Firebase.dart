import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/Send_Message_Params.dart';
import 'package:amer_school/App/domain/useCases/UseCases.dart';
import 'package:dartz/dartz.dart';

class SendMessageInFirebase extends UseCases<void, SendMessageParams> {
  final FirebaseService _firebaseService;

  SendMessageInFirebase(this._firebaseService);
  @override
  Future<Either<AppError, void>> call(
      SendMessageParams sendMessageParams) async {
    return await _firebaseService.sendMessageInDatabase(sendMessageParams);
  }
}
