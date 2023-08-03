import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConvertImage extends StatelessWidget {
  final String base64Image;
  const ConvertImage({
    required this.base64Image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64Image);
    return Image.memory(
      bytes,
      height: 133,
      width: 81,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/png/error_image.png",
          height: 133,
          width: 81,
        );
      },
    );
  }
}
