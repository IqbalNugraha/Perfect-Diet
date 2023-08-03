import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImage {
  ImagePicker imagePicker = ImagePicker();

  Future openImage(ImageSource img) async {
    var pickedFile = await imagePicker.pickImage(source: img);
    XFile? xFilePick = pickedFile;
    return xFilePick;
  }

  Image convertImage(String base64Image) {
    Uint8List bytes = base64Decode(base64Image);
    return Image.memory(bytes);
  }
}
