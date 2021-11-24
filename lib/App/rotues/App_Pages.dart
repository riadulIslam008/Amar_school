import 'package:amer_school/App/presentation/Auth_Section/AuthPage.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/StudentSignUP.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/studentLogin.dart';
import 'package:amer_school/App/presentation/Auth_Section/Teacher_Auth_Section/TeacherLogin.dart';
import 'package:amer_school/App/presentation/INITIAL_Page/INITIAL_VIEW.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:get/get.dart';

class AppPages{
  static const INTIAL_ROUTE = '/';

  static final routes =[
    
    GetPage(name: Routes.INital_Routes, page: ()=> InitalView()),
    GetPage(name: Routes.AuthPage, page: ()=> AuthPage()),
    GetPage(name: Routes.TeacherLogin, page: ()=> TeacherLogin()),
    GetPage(name: Routes.StudentLogin, page: ()=> StudentLogin()),
    GetPage(name: Routes.StudentSignin, page: ()=> StudentSignup()),
  ];
}