import 'package:get/get.dart';

class DropDownController extends GetxController {
  final List<String> classList = <String>[
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9",
    "Class 10",
  ];

  String fristItemClassListVariable;

  updateStudentSection(String currentSection) {
    fristItemClassListVariable = currentSection;
    update();
  }

  @override
  void onClose() {
    fristItemClassListVariable = null;
    super.onClose();
  }
}
