import 'package:amer_school/App/domain/repositories/Firebase_Service.dart';
import 'package:amer_school/App/domain/useCases/Delete_GRoup_Call_Instance.dart';
import 'package:get/get.dart';

class GroupCallController extends GetxController {
  final FirebaseService _firebaseService;

  GroupCallController(this._firebaseService);

   void deleteGroupCallStream(studentClass) async {
    DeleteGroupCallInstance _deleteGroupCall =
        DeleteGroupCallInstance(_firebaseService);

    await _deleteGroupCall(studentClass);
  }
}
