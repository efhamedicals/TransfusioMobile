import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:transfusio/src/core/utils/exceptions/photo_exception.dart';

class ImagePickerHelper {
  static ImagePicker imagePicker = ImagePicker();

  static Future<File?> choosePhoto(ImageSource source) async {
    try {
      final photo = await imagePicker.pickImage(
        source: source,
        imageQuality: 100,
      );

      if (photo != null) {
        return File(photo.path);
      }

      return null;
    } on Exception {
      throw const PhotoPickerException();
    }
  }
}
