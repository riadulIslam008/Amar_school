import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

abstract class FlutterDownload {
  Future<void> downloadFile(
      {@required String videoUrl, @required String fileName});
}

class FlutterDownloadImpl extends FlutterDownload{
  @override
  Future<void> downloadFile({String videoUrl, String fileName}) async{

  final baseName = await getExternalStorageDirectory();
  return await FlutterDownloader.enqueue(
        url: videoUrl, savedDir: baseName.path, fileName: fileName);
  }
  
}
