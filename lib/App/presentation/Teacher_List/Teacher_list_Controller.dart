import 'package:amer_school/App/domain/useCases/Fetch_Teacher_List.dart';
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

    teacherList.value = await _fetchTeacherList();
  }
}
