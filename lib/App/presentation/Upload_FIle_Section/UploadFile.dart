import 'dart:io';

import 'package:amer_school/App/Core/useCases/Seletec_File.dart';
import 'package:amer_school/App/presentation/DropDown_Section/DropDown_Section.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/UploadFileController.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/TextContainerWidget.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/TextFieldWidget.dart';
import 'package:amer_school/App/presentation/Upload_FIle_Section/Widgets/UploadItemIndiactor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadFileView extends GetWidget<UploadFileController> {
  final SizedBox _height = SizedBox(
    height: Get.height * 0.02,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        padding: const EdgeInsets.all(8.0),
        children: [
          _height,
          DropDownSection(),
          _height,
          TextFieldWidget(
            titleName: "Video Title",
            maxLine: 1,
            controller: controller.titleController,
          ),
          _height,
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
          _height,
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
          _height,
          TextFieldWidget(
            titleName: "Video description",
            maxLine: 2,
            controller: controller.discriptionController,
          ),
          _height,
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
    );
  }
}
