import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TaskSnap extends Equatable {
  final TaskSnapshot taskSnapshot;

  TaskSnap(this.taskSnapshot);
  @override
  List<Object> get props => [taskSnapshot];
}
