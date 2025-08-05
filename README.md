# 📚 Amer School App

Amer School App is a Flutter-based school communication and virtual classroom platform with separate **Teacher** and **Student** views. It allows teachers to host group video calls, send messages, share recorded classes, and track attendance, while students can access class recordings, view teacher profiles, and participate in group discussions.

---

## ✨ Features

### 👩‍🏫 Teacher View
- **Secure Login**
  - Demo credentials:
    - Username: `ibn sina`
    - Password: `123456`
- **Class Group Management**
  - Join class-specific groups based on standard.
- **Group Video Call**
  - Initiate class video calls via Agora.
  - Notifications sent to all relevant students using Firebase Cloud Messaging (FCM).
  - Automatic video recording (**future feature**).
- **Attendance Tracking**
  - View students present in the call in real-time.
- **Message Broadcasting**
  - Post messages in group chats.
  - Students can reply to messages.
- **Recording Upload**
  - After recording, upload to Firebase Storage for student access.

---

### 👨‍🎓 Student View
- **Sign Up & Login**
  - New students sign up and log in to access the app.
  - - Demo credentials:
    - Username: `demo rafi`
    - Roll: `1`
    - Class 10
    - Password: `123456`
- **Automatic Group Assignment**
  - Added to relevant class group based on standard during sign-up.
- **Recorded Classes**
  - View all recorded sessions.
  - Watch online or download for offline viewing.
- **Teacher Profile**
  - View teacher's name, mobile number, address, and study field.
- **Group Messaging**
  - Participate in class group discussions.
- **Video Call Notifications**
  - Get a dialog notification when a teacher starts a live session so they never miss class.

---

---

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Backend & Storage:** Firebase
- **Real-time Video:** Agora RTC
- **Messaging & Notifications:** Firebase Cloud Messaging (FCM)

---

## 🖼️ Screenshots

|   |   |
|---|---|
<p align="center">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-1.webp" height="300">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-2.webp" height="300">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-3.webp" height="300">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-4.webp" height="300">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-5.webp" height="300">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-6.webp" height="300">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-7.webp" height="300">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-8.webp" height="300">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-9.webp" height="300">
  <img src="https://raw.githubusercontent.com/riadulIslam008/Amer-School-Images/refs/heads/main/image-10.webp" height="300">
</p>


---

## 📂 Folder Structure

```plain Text
---
my_project/
├── lib/
│   ├── presentation/
│   │   ├── AuthSection.dart
│   │   ├── ClassLiveBroadcast.dart
│   │   ├── DropDownSection.dart
│   │   ├── GroupCall.dart
│   │   ├── GroupChatScreen.dart
│   │   ├── GroupListSection.dart
│   │   ├── HomeSection.dart
│   │   ├── ProfileSection.dart
│   │   ├── TeacherList.dart
│   │   ├── UploadFileSection.dart
│   │   └── VideoPlayerPages.dart
│   ├── routes/
│   │   ├── AppRoutes.dart
│   │   └── routes.dart
│   ├── di/
│   │   └── Bindings.dart
│   ├── main.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── GroupCallTeacher_ModelEntity.dart
│   │   │   ├── Group_List_ModelEntity.dart
│   │   │   ├── Members_Param.dart
│   │   │   ├── Message_ModelEntity.dart
│   │   │   ├── Student_ModelEntity.dart
│   │   │   ├── Task_Snapshot.dart
│   │   │   ├── Teacher_ModelEntity.dart
│   │   │   └── Video_FileEntity.dart
│   │   ├── repositories/
│   │   │   └── Firebase_Service.dart
│   │   └── usecases/
│   │       ├── AddMember.dart
│   │       ├── AddMemberToGroup.dart
│   │       ├── AddMessage.dart
│   │       ├── AddStudent.dart
│   │       ├── AddTeacher.dart
│   │       ├── AddVideoFile.dart
│   │       ├── CheckGroupCall.dart
│   │       ├── CreateGroup.dart
│   │       ├── DeleteGroup.dart
│   │       ├── DeleteMessage.dart
│   │       ├── DeleteStudent.dart
│   │       ├── DeleteTeacher.dart
│   │       ├── DeleteVideoFile.dart
│   │       ├── FetchGroup.dart
│   │       ├── FetchMessage.dart
│   │       ├── FetchStudent.dart
│   │       ├── FetchTeacher.dart
│   │       ├── FetchVideoFile.dart
│   │       ├── GetGroupMembers.dart
│   │       ├── GetMessages.dart
│   │       ├── GetStudents.dart
│   │       ├── GetTeachers.dart
│   │       ├── GetVideoFiles.dart
│   │       ├── JoinGroupCall.dart
│   │       ├── LeaveGroupCall.dart
│   │       ├── LoginUser.dart
│   │       ├── LogoutUser.dart
│   │       ├── RegisterUser.dart
│   │       ├── RemoveMember.dart
│   │       ├── SendMessage.dart
│   │       ├── SignUp.dart
│   │       ├── UpdateGroup.dart
│   │       ├── UpdateMessage.dart
│   │       ├── UpdateStudent.dart
│   │       ├── UpdateTeacher.dart
│   │       ├── UpdateVideoFile.dart
│   │       ├── UploadFile.dart
│   │       └── UploadVideo.dart
│   ├── data/
│   │   ├── dataSources/
│   │   │   ├── remote/
│   │   │   │   ├── FirebaseAuth.dart
│   │   │   │   ├── FirebaseFirestore.dart
│   │   │   │   └── FirebaseStorage.dart
│   │   │   └── FlutterDownloader.dart
│   │   ├── models/
│   │   │   ├── GroupCallModel.dart
│   │   │   ├── GroupCallTeacherModel.dart
│   │   │   ├── MemberListModel.dart
│   │   │   ├── MessageModel.dart
│   │   │   ├── StudentDetailsModel.dart
│   │   │   ├── TeacherDetailsModel.dart
│   │   │   └── VideoFileModel.dart
│   ├── repositories/
│   │   └── FirebaseServiceImpl.dart
│   ├── app/
│   │   ├── Core/
│   │   │   ├── Widgets/
│   │   │   │   └── TeacherProfileArgument.dart
│   │   │   ├── assets/
│   │   │   │   └── AssetImage.dart
│   │   │   ├── errors/
│   │   │   │   └── FirebaseExceptionError.dart
│   │   │   ├── usecases/
│   │   │   │   ├── AppPermission.dart
│   │   │   │   ├── GlobalKey.dart
│   │   │   │   ├── ImagePicker.dart
│   │   │   │   ├── MakeValidateEmail.dart
│   │   │   │   ├── RandomString.dart
│   │   │   │   ├── SelectAVideo.dart
│   │   │   │   ├── SelectFile.dart
│   │   │   │   ├── SuccessfulSnackBar.dart
│   │   │   │   └── UniversalString.dart
│   │   │   └── app.dart
│   │   └── widgets/
│   │       └── CircularPage.dart

```

### 📦 Dependencies

```
dependencies:
  agora_rtc_engine: ^4.0.6
  cached_network_image: ^3.1.0+1
  chewie: ^1.2.2
  cloud_firestore: ^3.1.0
  cupertino_icons: ^1.0.2
  dartz: ^0.10.0
  equatable: ^2.0.3
  file_picker: ^4.2.4
  firebase_auth: ^3.2.0
  firebase_core: ^1.10.0
  firebase_storage: ^10.1.0
  flutter:
    sdk: flutter
  flutter_downloader: ^1.7.1
  focused_menu: ^1.0.5
  get: ^4.3.8
  get_storage: ^2.0.3
  image_picker: ^0.8.2
  path_provider: ^2.0.7
  permission_handler: ^8.3.0
  shimmer: ^2.0.0
  url_launcher: ^6.0.15
  video_player: ^2.2.7
```
