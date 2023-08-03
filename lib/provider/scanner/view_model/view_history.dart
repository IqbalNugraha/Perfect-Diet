import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/scanner/model/history.dart';

enum ClassViewHistory {
  staging,
  loading,
  loaded,
  error,
  empty,
}

class ViewHistory with ChangeNotifier {
  ApiService apiService = ApiService();
  History history = History();
  ClassViewHistory _state = ClassViewHistory.empty;
  ClassViewHistory get state => _state;

  changeState(ClassViewHistory s) {
    _state = s;
    notifyListeners();
  }

  Future<History> sendHistory(
    String namaMakanan,
    int cal,
    int fat,
    int carb,
    String imgUrl,
    String userId,
    String idToken,
  ) async {
    final url =
        Uri.parse("${apiService.listHistory + userId}.json?auth=$idToken");
    try {
      changeState(ClassViewHistory.staging);
      final response = await http.post(
        url,
        body: json.encode({
          "nama_makanan": namaMakanan,
          "cal": cal,
          "fat": fat,
          "carb": carb,
          "img_url": imgUrl,
        }),
      );
      if (response.statusCode == 200) {
        changeState(ClassViewHistory.loaded);
        final item = json.decode(response.body);
        history = History.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewHistory.error);
    }
    return history;
  }
}
