import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_translate/learning_translate.dart';

enum ClassViewTranslate {
  loading,
  loaded,
  error,
}

class ViewTranslate with ChangeNotifier {
  Translator translator = Translator(from: ENGLISH, to: INDONESIAN);
  String value = "";
  ClassViewTranslate _state = ClassViewTranslate.loading;
  ClassViewTranslate get state => _state;
  bool isLoading = false;

  changeState(ClassViewTranslate s) {
    _state = s;
    notifyListeners();
  }

  Future<void> translateIndo(String text) async {
    changeState(ClassViewTranslate.loading);
    try {
      changeState(ClassViewTranslate.loaded);
      value = await translator.translate(text);
      notifyListeners();
    } catch (error) {
      changeState(ClassViewTranslate.error);
      log(error.toString());
    }
  }
  // void translate(String name) async {
  //   var title = await translator.translate(name);
  //   print(name);
  // }
}
