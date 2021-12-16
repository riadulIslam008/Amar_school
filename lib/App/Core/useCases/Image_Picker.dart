import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File> imagePicker({@required ImageSource imageSource}) async {
  XFile selectedFile = await ImagePicker().pickImage(source: imageSource);

  return File(selectedFile.path);
}
