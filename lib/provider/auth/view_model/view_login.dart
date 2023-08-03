import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/auth/model/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewLogin with ChangeNotifier {
  ApiService apiService = ApiService();
  ResponseDataLogin responseData = ResponseDataLogin();
  String? idToken;
  String? userId;

  Future<ResponseDataLogin> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(apiService.signInUrl + apiService.keyFirebase);
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
        responseData = ResponseDataLogin.fromJson(item);
        idToken = responseData.idToken;
        userId = responseData.localId;
        prefs.setString('idToken', idToken ?? "");
        prefs.setString('userId', userId ?? "");
        notifyListeners();
      } else if (response.statusCode == 400) {
        final item = json.decode(response.body);
        responseData = ResponseDataLogin.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
    }
    return responseData;
  }

  Future<String> getStringToken() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      idToken = prefs.getString('idToken');
      return idToken ?? "";
    } catch (error) {
      log(error.toString());
      return "";
    }
  }

  Future<String> getStringUser() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      userId = prefs.getString('userId');
      return userId ?? "";
    } catch (error) {
      log(error.toString());
      return "";
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('idToken') && prefs.containsKey('userId')) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    idToken = null;
    userId = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
