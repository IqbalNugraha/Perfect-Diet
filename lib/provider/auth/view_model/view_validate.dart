import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/auth/model/validate.dart';
import 'package:http/http.dart' as http;

enum ClassViewValidate {
  staging,
  loaded,
  error,
  empty,
}

class ViewValidate with ChangeNotifier {
  ApiService apiService = ApiService();
  ResponseValidate responseValidate = ResponseValidate();
  ClassViewValidate _state = ClassViewValidate.empty;
  ClassViewValidate get state => _state;
  String name = "";
  String value = "";

  changeState(ClassViewValidate s) {
    _state = s;
    notifyListeners();
  }

  Future<ResponseValidate> sendValidate(String imageUrl) async {
    final apiKey = apiService.personalKey;
    final url = Uri.parse(apiService.urlGenderClarifai);
    changeState(ClassViewValidate.staging);
    try {
      final response = await http.post(
        url,
        headers: {
          'authorization': 'Key $apiKey',
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "inputs": [
              {
                "data": {
                  "image": {
                    "base64": imageUrl,
                  }
                }
              }
            ]
          },
        ),
      );
      if (response.statusCode == 200) {
        changeState(ClassViewValidate.loaded);
        final item = json.decode(response.body);
        responseValidate = ResponseValidate.fromJson(item);
        notifyListeners();
      } else {
        changeState(ClassViewValidate.error);
      }
    } catch (error) {
      changeState(ClassViewValidate.error);
      log(error.toString());
    }
    return responseValidate;
  }
}
