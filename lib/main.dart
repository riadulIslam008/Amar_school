import 'package:amer_school/App/presentation/Auth_Section/AuthPage.dart';
import 'package:amer_school/App/rotues/App_Pages.dart';
import 'package:amer_school/MyApp/Utiles/UniversalString.dart';
import 'package:amer_school/App/presentation/Home_Section/HomePageView.dart';
import 'package:amer_school/di/Bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage().initStorage;
  await FlutterDownloader.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GetStorage getStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      title: 'Amar_School',
      theme: ThemeData.dark(),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: getStorage.read(teacherUid) != null
              ? HomePageView(isTeacher: true)
              : getStorage.read(studentUid) != null
                  ? HomePageView(isTeacher: false)
                  : AuthPage(),
        ),
      ),
    );
  }
}
