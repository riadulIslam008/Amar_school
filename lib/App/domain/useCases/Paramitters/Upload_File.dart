import 'dart:io';

import 'package:equatable/equatable.dart';

class UploadParam extends Equatable {
  final String sectionName;
  final String destination;
  final File imageFile;

  UploadParam(this.destination, this.imageFile, this.sectionName);
  @override
  List<Object> get props => [];
}
