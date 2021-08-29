import 'package:amer_school/MyApp/View/UpoloadFileView/Widgets/DorpDownButton.dart';
import 'package:amer_school/MyApp/View/UpoloadFileView/Widgets/TextContainerWidget.dart';
import 'package:amer_school/MyApp/View/UpoloadFileView/Widgets/TextFieldWidget.dart';
import 'package:amer_school/MyApp/View/UpoloadFileView/Widgets/UploadItemIndiactor.dart';
import 'package:amer_school/MyApp/controller/UploadFileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadFileView extends GetWidget<UploadFileController> {
  final SizedBox _height = SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      //
      //
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.isUploading.value = false;
            controller.imageParcentage.value = 0.0;
            controller.videoParcentage.value = 0.0;
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      //
      //
      //
      //
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          
          DropDownItem(),
          _height,
          Obx(
            () => TextFieldWidget(
              titleName: "Video Title",
              maxLine: 1,
              controller: controller.titleController.value,
            ),
          ),
          _height,
          Obx(
            () => TextContainerWidget(
              onClick: () {
                controller.selectImage();
              },
              buttonText: "select image",
              fileName: controller.imageFileName.value,
            ),
          ),
          _height,
          Obx(
            () => controller.isUploading.value
                ? UploadItemIndicator(
                    icon: Icons.image,
                    title: controller.imageFileName.value,
                    value: controller.imageParcentage.value,
                  )
                : Container(),
          ),
          Obx(
            () => TextContainerWidget(
              onClick: () {
                controller.selectVideo();
              },
              buttonText: "select video",
              fileName: controller.videoFileName.value,
            ),
          ),
          _height,
          Obx(
            () => controller.isUploading.value
                ? UploadItemIndicator(
                    icon: Icons.video_collection,
                    title: controller.videoFileName.value,
                    value: controller.videoParcentage.value,
                  )
                : Container(),
          ),
          Obx(
            () => TextFieldWidget(
              titleName: "Video description",
              maxLine: 2,
              controller: controller.discriptionController.value,
            ),
          ),
          _height,
          ElevatedButton(
            onPressed: () {
               controller.uploadVideosAndImage();
             // NotificationApi().instantNotification();
            },
            child: Text("Upload File"),
          ),
        ],
      ),
    );
  }
}
