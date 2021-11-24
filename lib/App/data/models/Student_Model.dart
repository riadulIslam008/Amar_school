import 'dart:convert';

import 'package:amer_school/App/domain/entites/Student_Model_Entity.dart';

class StudentModel extends StudentModelEntity {
  final String studentName;
  final String studentRoll;
  final String studentProfileLink;
  final String studentUid;
  final String studentClass;

  StudentModel(
    this.studentName,
    this.studentRoll,
    this.studentProfileLink,
    this.studentUid,
    this.studentClass,
  ) : super(
          studentName: studentName,
          studentRoll: studentRoll,
          studentProfileLink: studentProfileLink,
          studentUid: studentUid,
          studentClass: studentClass,
        );



  

  Map<String, dynamic> toMap() {
    return {
      'studentName': studentName,
      'studentRoll': studentRoll,
      'studentProfileLink': studentProfileLink,
      'studentUid': studentUid,
      'studentClass': studentClass,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      map['studentName'],
      map['studentRoll'],
      map['studentProfileLink'],
      map['studentUid'],
      map['studentClass'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) => StudentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentModel(studentName: $studentName, studentRoll: $studentRoll, studentProfileLink: $studentProfileLink, studentUid: $studentUid, studentClass: $studentClass)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is StudentModel &&
      other.studentName == studentName &&
      other.studentRoll == studentRoll &&
      other.studentProfileLink == studentProfileLink &&
      other.studentUid == studentUid &&
      other.studentClass == studentClass;
  }

  @override
  int get hashCode {
    return studentName.hashCode ^
      studentRoll.hashCode ^
      studentProfileLink.hashCode ^
      studentUid.hashCode ^
      studentClass.hashCode;
  }
}
