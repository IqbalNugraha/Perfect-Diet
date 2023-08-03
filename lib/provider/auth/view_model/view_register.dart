import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/auth/model/register.dart';
import 'package:http/http.dart' as http;

class ViewAuth with ChangeNotifier {
  ApiService apiService = ApiService();
  ResponseDataRegister responseData = ResponseDataRegister();

  Future<ResponseDataRegister> register(String email, String password) async {
    final url = Uri.parse(apiService.signUpUrl + apiService.keyFirebase);
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        responseData = ResponseDataRegister.fromJson(item);
        notifyListeners();
      } else if (response.statusCode == 400) {
        final item = json.decode(response.body);
        responseData = ResponseDataRegister.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
    return responseData;
  }
}
