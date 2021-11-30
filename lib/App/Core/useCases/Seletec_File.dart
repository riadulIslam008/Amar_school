import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

Future<Either<AppError, String>> selectFile() async {
  final result = await FilePicker.platform.pickFiles();

  try {
    final String path = result.files.single.path;
    return Right(path);
  } catch (e) {
    return Left(AppError(e.toString()));
  }
}
