import 'package:flutter/material.dart';
import 'package:skiripsi_app/utility/warna.dart';

class InputCustom{
  InputDecoration inputProfile(String hintText) {
    return InputDecoration(
      hintText: hintText,
      counterText: "",
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(
          color: MyColors.grey(),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(
          color: MyColors.grey(),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }
}