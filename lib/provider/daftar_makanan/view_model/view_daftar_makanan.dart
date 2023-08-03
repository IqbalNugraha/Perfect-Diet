import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/daftar_makanan/model/model_daftar_makanan.dart';
import 'package:flutter/material.dart';

class ViewListFood with ChangeNotifier {
  ModelListFood modelListFood = ModelListFood();
  ResponseData responseData = ResponseData();
  ApiService apiService = ApiService();
  List<ModelListFood> list = [];

  Future<List<ModelListFood>> fetchListFood() async {
    final getFindByNutrient = apiService.getFindByNutrient;
    final apiKey = apiService.apiKey;
    var maxFat = 67;
    bool includeNutrition = false;
    try {
      final url = Uri.parse(
          "$getFindByNutrient?apiKey=$apiKey&includeNutrition=$includeNutrition&maxFat=$maxFat");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final item = json.decode(response.body).cast<Map<String, dynamic>>();
        list = item
            .map<ModelListFood>((json) => ModelListFood.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        response.statusCode;
      }
    } catch (error) {
      rethrow;
    }
    return list;
  }

  Future<List<ModelListFood>> fetchListFoodByFat() async {
    final getFindByNutrient = apiService.getFindByNutrient;
    final apiKey = apiService.apiKey;
    var minFat = 67;
    bool includeNutrition = false;
    try {
      final url = Uri.parse(
          "$getFindByNutrient?apiKey=$apiKey&includeNutrition=$includeNutrition&minFat=$minFat");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final item = json.decode(response.body).cast<Map<String, dynamic>>();
        list = item
            .map<ModelListFood>((json) => ModelListFood.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        response.statusCode;
      }
    } catch (error) {
      rethrow;
    }
    return list;
  }

  Future<List<ModelListFood>> fetchListFoodByCarb() async {
    final getFindByNutrient = apiService.getFindByNutrient;
    final apiKey = apiService.apiKey;
    var minCarbs = 100;
    bool includeNutrition = false;
    try {
      final url = Uri.parse(
          "$getFindByNutrient?apiKey=$apiKey&includeNutrition=$includeNutrition&minCarbs=$minCarbs");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final item = json.decode(response.body).cast<Map<String, dynamic>>();
        list = item
            .map<ModelListFood>((json) => ModelListFood.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        response.statusCode;
      }
    } catch (error) {
      rethrow;
    }
    return list;
  }

  Future<List<ModelListFood>> fetchListFoodByCalories() async {
    final getFindByNutrient = apiService.getFindByNutrient;
    final apiKey = apiService.apiKey;
    var minCalories = 1000;
    bool includeNutrition = false;
    try {
      final url = Uri.parse(
          "$getFindByNutrient?apiKey=$apiKey&includeNutrition=$includeNutrition&minCalories=$minCalories");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final item = json.decode(response.body).cast<Map<String, dynamic>>();
        list = item
            .map<ModelListFood>((json) => ModelListFood.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        response.statusCode;
      }
    } catch (error) {
      rethrow;
    }
    return list;
  }
}
