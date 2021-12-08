//? ============ Error Dialogbo ============ //
import 'package:amer_school/App/Core/useCases/Alert_Message.dart';

//? ============ group List Model ========== //
import 'package:amer_school/App/domain/entites/Group_List_Model_Entity.dart';

//? =========== Create Group Class ========= //
import 'package:amer_school/App/domain/useCases/Create_Group.dart';

//? =========== Fetch Group list Class ===== //
import 'package:amer_school/App/domain/useCases/Fetch_Group_List.dart';

//? ========== packages =========== //
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupListViewController extends GetxController {
  final _firebaseRepository;

  String fristItemClassList;
  List groupList = [];

  Rxn<List<GroupModelEntity>> _grounModelEntity = Rxn<List<GroupModelEntity>>();
  List<GroupModelEntity> get groupModelEntity => _grounModelEntity.value;

  GroupListViewController(this._firebaseRepository);

  @override
  void onInit() {
    _grounModelEntity.bindStream(fetchGroupList());
    super.onInit();
  }

  void createGroup({@required String className}) async {
    List memberList = [];
    GroupModelEntity _groupModelEntity =
        GroupModelEntity(className, memberList);
    CreateGroup _createGroup = CreateGroup(_firebaseRepository);

    final _either = await _createGroup(_groupModelEntity);

    _either.fold((l) => errorDialogBox(description: l.toString()),
        (r) => fetchGroupList());
  }

  fetchGroupList() {
    FetchGroupList _fetchGroupList = FetchGroupList(_firebaseRepository);
    return _fetchGroupList();
  }
}
