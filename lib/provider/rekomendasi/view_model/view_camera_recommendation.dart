import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:skiripsi_app/provider/rekomendasi/model/model_detection.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/model_recognition.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/rekomendasi.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/model_detail_summary.dart';

enum ClassViewCamera {
  staging,
  loading,
  loaded,
  error,
  empty,
}

class ViewCamera with ChangeNotifier {
  ApiService apiService = ApiService();
  ResponseDataRekomendasi responseData = ResponseDataRekomendasi();
  ResponseDataFood responseDataFood = ResponseDataFood();
  ResponseDetailSummary responseDetailSummary = ResponseDetailSummary();
  ResponseDetection responseDetection = ResponseDetection();
  ClassViewCamera _state = ClassViewCamera.empty;
  ClassViewCamera get state => _state;
  double? cal, fat, carb;
  String? name, food, imgUrl;

  changeState(ClassViewCamera s) {
    _state = s;
    notifyListeners();
  }

  Future<ResponseDataFood> recogImage(String base64Image) async {
    final apiKey = apiService.personalKey;
    final url = Uri.parse(apiService.urlFoodClarifai);
    changeState(ClassViewCamera.staging);
    try {
      changeState(ClassViewCamera.loading);
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
                    "base64": base64Image,
                  }
                }
              }
            ]
          },
        ),
      );
      log(response.body);
      if (response.statusCode == 200) {
        changeState(ClassViewCamera.loaded);
        final item = json.decode(response.body);
        responseDataFood = ResponseDataFood.fromJson(item);
        // food = responseDataFood.outputs![0].data!.concepts![0].name;
        notifyListeners();
      } else {
        changeState(ClassViewCamera.error);
      }
    } catch (error) {
      changeState(ClassViewCamera.error);
      log(error.toString());
    }
    return responseDataFood;
  }

  Future<ResponseDataRekomendasi> getDataFood(
      String query, int maxCal, int maxFat, int maxCarb) async {
    final recommendation =
        apiService.baseUrlSpoonacular + apiService.getListFood;
    final apiKey1 = apiService.apiKey;
    changeState(ClassViewCamera.empty);
    try {
      changeState(ClassViewCamera.loading);
      final url = Uri.parse(
        "$recommendation?apiKey=$apiKey1&query=$query&maxCarbs=$maxCarb&maxCalories=$maxCal&maxFat=$maxFat&number=1",
      );
      print(url);
      final response = await http.get(url);
      log(response.body);
      if (response.statusCode == 200) {
        changeState(ClassViewCamera.loaded);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        cal = responseData.result![0].nutrition!.nutrients![0].amount;
        fat = responseData.result![0].nutrition!.nutrients![1].amount;
        carb = responseData.result![0].nutrition!.nutrients![2].amount;
        imgUrl = responseData.result![0].image;
        notifyListeners();
        if (responseData.result!.isEmpty) {
          changeState(ClassViewCamera.empty);
        }
      } else if (response.statusCode == 400) {
        changeState(ClassViewCamera.empty);
      } else {
        changeState(ClassViewCamera.error);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      changeState(ClassViewCamera.error);
      log(error.toString());
    }
    return responseData;
  }

  Future<ResponseDetailSummary> fetchDetailSummary(int id) async {
    notifyListeners();
    final baseUrl = apiService.baseUrlSpoonacular;
    var apiKey = apiService.apiKey1;
    final detailSummary =
        "$baseUrl/recipes/$id/information?apiKey=$apiKey&includeNutrition=false";
    changeState(ClassViewCamera.loading);
    try {
      final url = Uri.parse(detailSummary);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        changeState(ClassViewCamera.loaded);
        final item = json.decode(response.body);
        responseDetailSummary = ResponseDetailSummary.fromJson(item);
        notifyListeners();
        if (responseDetailSummary.cuisines!.isEmpty &&
            responseDetailSummary.diet!.isEmpty &&
            responseDetailSummary.dishType!.isEmpty &&
            responseDetailSummary.extendedIngredients!.isEmpty &&
            responseDetailSummary.summary!.isEmpty &&
            responseDetailSummary.winePairing!.productMatches!.isEmpty) {
          changeState(ClassViewCamera.empty);
        }
      } else if (response.statusCode == 400) {
        changeState(ClassViewCamera.empty);
      } else {
        changeState(ClassViewCamera.error);
        final item = json.decode(response.body);
        responseDetailSummary = ResponseDetailSummary.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      changeState(ClassViewCamera.error);
      log(error.toString());
    }
    return responseDetailSummary;
  }
}
