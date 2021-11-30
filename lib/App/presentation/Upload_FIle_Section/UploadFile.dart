import 'dart:io';

import 'package:amer_school/App/Core/useCases/Seletec_File.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/UploadFileController.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/DropDown_Section.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/TextContainerWidget.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/TextFieldWidget.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/UploadItemIndiactor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadFileView extends GetWidget<UploadFileController> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropDownSection(),
            TextFieldWidget(
              titleName: "Video Title",
              maxLine: 1,
              controller: controller.titleController,
            ),
            Obx(
              () => TextContainerWidget(
                onClick: () async {
                  final either = await selectFile();
                  either.fold((l) => null, (r) {
                    controller.imageFileName.value = r.split("/").last;
                    controller.imageFile = File(r);
                  });
                },
                buttonText: "select image",
                fileName: controller.imageFileName.value,
              ),
            ),
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
                onClick: () async {
                  
                  final _either = await selectFile();
                  _either.fold((l) => null, (r) {
                    controller.videoFileName.value = r.split("/").last;
                    controller.videoFile = File(r);
                  });
                },
                buttonText: "select video",
                fileName: controller.videoFileName.value,
              ),
            ),
            Obx(
              () => controller.isUploading.value
                  ? UploadItemIndicator(
                      icon: Icons.video_collection,
                      title: controller.videoFileName.value,
                      value: controller.videoParcentage.value,
                    )
                  : Container(),
            ),
            TextFieldWidget(
              titleName: "Video description",
              maxLine: 2,
              controller: controller.discriptionController,
            ),
            SizedBox(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () {
                  controller.uploadVideosAndImage();
                },
                child: Text("Upload File"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
