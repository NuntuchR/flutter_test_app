import 'dart:io';

import 'package:flutter_test_app/models/post_model.dart';
import 'package:image_picker/image_picker.dart';

import '../constant.dart';

class PickImage {
  final picker = ImagePicker();

  ///Get image form the selected [source]
  ///
  ///
  Future<void> getPhoto(
      PostModel post, ImageSource source) async {
    File imageFile;
    if (post.photoWidget.length < MAX_PIC_PER_POST) {
      final pickedFile = await picker.getImage(source: source);
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        post.photoFile.add(imageFile);
      }
    }
  }
}
