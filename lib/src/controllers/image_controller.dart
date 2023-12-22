import 'dart:io';

import 'package:get/get.dart';

class ImageController extends GetxController {
  Rx<File?> image = Rx<File?>(null);

  void setImage(File? file) {
    image.value = file;
  }

  File? getImage() {
    return image.value;
  }
}