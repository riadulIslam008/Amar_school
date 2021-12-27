import 'package:amer_school/App/Core/useCases/Alert_Message.dart';
import 'package:amer_school/App/domain/useCases/Fetch_Teacher_List.dart';
import 'package:amer_school/App/domain/useCases/Paramitters/No_Param.dart';
import 'package:get/get.dart';

class TeacherListController extends GetxController {
  final _firebaseRepository;
  TeacherListController(this._firebaseRepository);

  RxList teacherList = [].obs;

  @override
  void onInit() {
    fetchList();
    super.onInit();
  }

  Future<void> fetchList() async {
    FetchTeacherList _fetchTeacherList = FetchTeacherList(_firebaseRepository);

    final _either = await _fetchTeacherList(NoParam());

    _either.fold((l) => errorDialogBox(description: l.errorMerrsage), (r) => teacherList.value = r);
  }
}
