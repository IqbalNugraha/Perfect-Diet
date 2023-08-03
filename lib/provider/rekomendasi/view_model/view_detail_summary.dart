import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/model_detail_summary.dart';
import 'package:translator/translator.dart';

enum ClassViewDetailSummary {
  loading,
  loaded,
  error,
  empty,
}

class ViewDetailSummary with ChangeNotifier {
  ApiService apiService = ApiService();
  ResponseDetailSummary responseDetailSummary = ResponseDetailSummary();
  ClassViewDetailSummary _state = ClassViewDetailSummary.empty;
  ClassViewDetailSummary get state => _state;
  bool isValid = false;
  final translator = GoogleTranslator();
  String deskripsi = "";

  changeState(ClassViewDetailSummary s) {
    _state = s;
    notifyListeners();
  }

  Future<ResponseDetailSummary> fetchDetailSummary(int id) async {
    isValid = true;
    notifyListeners();
    final baseUrl = apiService.baseUrlSpoonacular;
    var apiKey = apiService.apiKey1;
    final detailSummary =
        "$baseUrl/recipes/$id/information?apiKey=$apiKey&includeNutrition=false";
    changeState(ClassViewDetailSummary.loading);
    try {
      final url = Uri.parse(detailSummary);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        isValid = false;
        changeState(ClassViewDetailSummary.loaded);
        final item = json.decode(response.body);
        responseDetailSummary = ResponseDetailSummary.fromJson(item);
        notifyListeners();
        if (responseDetailSummary.winePairing!.productMatches!.isEmpty) {
          isValid = true;
          notifyListeners();
        } else {
          isValid = false;
          var translate = await translator.translate(
              responseDetailSummary
                      .winePairing?.productMatches?[0].description ??
                  "",
              to: 'id');
          deskripsi = translate.text;
          notifyListeners();
        }
        if (responseDetailSummary.cuisines!.isEmpty &&
            responseDetailSummary.diet!.isEmpty &&
            responseDetailSummary.dishType!.isEmpty &&
            responseDetailSummary.extendedIngredients!.isEmpty &&
            responseDetailSummary.summary!.isEmpty &&
            responseDetailSummary.winePairing!.productMatches!.isEmpty) {
          changeState(ClassViewDetailSummary.empty);
        }
      } else if (response.statusCode == 400) {
        changeState(ClassViewDetailSummary.empty);
      } else {
        changeState(ClassViewDetailSummary.error);
        final item = json.decode(response.body);
        responseDetailSummary = ResponseDetailSummary.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      changeState(ClassViewDetailSummary.error);
      log(error.toString());
    }
    return responseDetailSummary;
  }
}
