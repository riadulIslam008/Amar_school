import 'package:amer_school/App/presentation/Auth_Section/AuthPage.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/StudentSignUP.dart';
import 'package:amer_school/App/presentation/Auth_Section/Student_Auth_Section/studentLogin.dart';
import 'package:amer_school/App/presentation/Auth_Section/Teacher_Auth_Section/TeacherLogin.dart';
import 'package:amer_school/App/presentation/Class_Live_Broadcast/Broad_Cast_View.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/GroupcallORchatscreen.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Student_Chat/StudentchatScreen.dart';
import 'package:amer_school/App/presentation/Group_Chat_Screen/Teacher_Chat_Screen/TeacherViewChatScreen.dart';
import 'package:amer_school/App/presentation/Group_List_Section/GroupListView.dart';
import 'package:amer_school/App/presentation/Profile_Section/StudentProfile.dart';
import 'package:amer_school/App/presentation/Profile_Section/TeacherProfile.dart';
import 'package:amer_school/App/presentation/Teacher_List/TeacherList.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/UploadFile.dart';
import 'package:amer_school/App/rotues/App_Routes.dart';
import 'package:amer_school/App/presentation/Video_Player_Pages/VideoPlayView.dart';
import 'package:get/get.dart';

class AppPages {
  static const INTIAL_ROUTE = '/';

  static final routes = [
    GetPage(name: Routes.AuthPage, page: () => AuthPage()),
    GetPage(name: Routes.TeacherLogin, page: () => TeacherLogin()),
    GetPage(name: Routes.StudentLogin, page: () => StudentLogin()),
    GetPage(name: Routes.StudentSignin, page: () => StudentSignup()),
    GetPage(name: Routes.VIDEO_PLAY_PAGE, page: () => VideoPlayView()),
    GetPage(name: Routes.UploadFile, page: () => UploadFileView()),
    GetPage(name: Routes.TEACHER_LIST, page: () => TeacherList()),
    GetPage(name: Routes.GROUP_LIST_PAGE, page: () => GroupListView()),
    GetPage(
        name: Routes.TEACHER_CHAT_PAGE, page: () => TeacherViewChatScreen()),
    GetPage(name: Routes.STUDENT_CHAT, page: () => StudentChatScreen()),
    GetPage(
        name: Routes.GROUP_CALL_OR_CHATPAGE,
        page: () => GroupCallORchatScreen()),
    GetPage(name: Routes.TEACHER_PROFILE, page: ()=> TeacherProfileView()),
    GetPage(name: Routes.STUDENT_PROFILE, page: ()=> StudentProfileView()),
    GetPage(name: Routes.BROAD_CAST_VIEW, page: ()=> BroadCastview()),
  ];
}
