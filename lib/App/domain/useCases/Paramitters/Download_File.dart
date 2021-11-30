import 'package:equatable/equatable.dart';

class DownloadFileParam extends Equatable {
  final String videoUrl;
  final String fileName;

  DownloadFileParam(this.videoUrl, this.fileName);
  @override
  List<Object> get props => [];
}
