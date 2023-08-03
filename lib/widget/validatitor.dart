import 'package:flutter/material.dart';

class Validator {
  String? errorText2(
      TextEditingController textEmail, TextEditingController textPassword) {
    final validatorEmail = textEmail.value.text;
    final validatorPassword = textPassword.value.text;
    if (validatorEmail.isEmpty && validatorPassword.isEmpty) {
      return "Cant't be empty";
    }
    return null;
  }

  String? errorTextEmail(TextEditingController textEditing) {
    final validatorEmail = textEditing.value.text;
    if (validatorEmail.isEmpty) {
      return "Cant't be empty";
    }
    return null;
  }

  String? errorTextPassword(TextEditingController textEditing) {
    final validatorPassword = textEditing.value.text;
    if (validatorPassword.isEmpty) {
      return "Cant't be empty";
    }
    return null;
  }
}
