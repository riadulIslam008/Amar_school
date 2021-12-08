import 'package:amer_school/App/presentation/Auth_Section/AuthPage.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupChatScreenController.dart';
import 'package:amer_school/App/presentation/Home_Section/HomeViewPageController.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/UploadFileController.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _firebaseAuth;
  final _getStorage;
  ProfileController(this._firebaseAuth, this._getStorage);

  final double boxSize = Get.height / 3;
  final double screenWidth = Get.width;

  logout() async {
    await _getStorage.erase();
    await _firebaseAuth.signOut();
    Get.delete<HomeViewController>(force: true);
    Get.delete<GroupChatScreenController>(force: true);
    Get.delete<UploadFileController>(force: true);
    Get.offAll(() => AuthPage());
  }
}
