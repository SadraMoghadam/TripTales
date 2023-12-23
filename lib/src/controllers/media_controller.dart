import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MediaController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  Rx<XFile?> video = Rx<XFile?>(null);

  void setImage(File? file) {
    image.value = file;
  }

  File? getImage() {
    return image.value;
  }

  void setVideo(XFile? file) {
    video.value = file;
  }

  XFile? getVideo() {
    return video.value;
  }
}