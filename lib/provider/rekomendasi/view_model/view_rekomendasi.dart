import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:skiripsi_app/provider/rekomendasi/model/rekomendasi.dart';

enum ClassViewRekomendasi {
  loading,
  loaded,
  error,
  empty,
}

class ViewRekomendasi with ChangeNotifier {
  ApiService apiService = ApiService();
  ResponseDataRekomendasi responseData = ResponseDataRekomendasi();
  ClassViewRekomendasi _state = ClassViewRekomendasi.empty;
  ClassViewRekomendasi get state => _state;
  bool isValid = false;
  bool isLoading = false;
  bool isImage = false;
  String? rekomendasiDiet;

  changeState(ClassViewRekomendasi s) {
    _state = s;
    notifyListeners();
  }

  Future<ResponseDataRekomendasi> fetchBreakfast(
    int maxCarb,
    int maxFat,
    int maxCalories,
  ) async {
    final breakfast = apiService.baseUrlSpoonacular + apiService.getListFood;
    final apiKey1 = apiService.apiKey1;
    changeState(ClassViewRekomendasi.loading);
    isValid = true;
    isImage = true;
    notifyListeners();
    try {
      final url = Uri.parse(
        "$breakfast?apiKey=$apiKey1&type=breakfast&maxCarbs=$maxCarb&maxCalories=$maxCalories&maxFat=$maxFat&number=10",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        changeState(ClassViewRekomendasi.loaded);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        isImage = false;
        notifyListeners();
        if (responseData.result!.isEmpty) {
          changeState(ClassViewRekomendasi.empty);
        }
      } else if (response.statusCode == 400) {
        changeState(ClassViewRekomendasi.empty);
      } else {
        changeState(ClassViewRekomendasi.error);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      changeState(ClassViewRekomendasi.error);
      log(error.toString());
    }
    return responseData;
  }

  Future<ResponseDataRekomendasi> fetchSnack(
    int maxCarb,
    int maxFat,
    int maxCalories,
  ) async {
    changeState(ClassViewRekomendasi.loading);
    final breakfast = apiService.baseUrlSpoonacular + apiService.getListFood;
    final apiKey1 = apiService.apiKey1;
    try {
      final url = Uri.parse(
        "$breakfast?apiKey=$apiKey1&type=fingerfood&maxCarbs=$maxCarb&maxCalories=$maxCalories&maxFat=$maxFat&number=7&cuisine=asian",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        changeState(ClassViewRekomendasi.loaded);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
        if (responseData.result!.isEmpty) {
          changeState(ClassViewRekomendasi.empty);
        }
      } else if (response.statusCode == 400) {
        changeState(ClassViewRekomendasi.empty);
      } else {
        changeState(ClassViewRekomendasi.error);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      changeState(ClassViewRekomendasi.error);
      log(error.toString());
    }
    return responseData;
  }

  Future<ResponseDataRekomendasi> fetchMainCourse(
    int maxCarb,
    int maxFat,
    int maxCalories,
  ) async {
    isLoading = true;
    notifyListeners();
    changeState(ClassViewRekomendasi.loading);
    final breakfast = apiService.baseUrlSpoonacular + apiService.getListFood;
    final apiKey = apiService.apiKey1;
    try {
      final url = Uri.parse(
        "$breakfast?apiKey=$apiKey&type=main course&maxCarbs=$maxCarb&maxCalories=$maxCalories&maxFat=$maxFat&number=10&cuisine=asian",
      );
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        isLoading = false;
        changeState(ClassViewRekomendasi.loaded);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
        if (responseData.result!.isEmpty) {
          changeState(ClassViewRekomendasi.empty);
          isLoading = false;
          notifyListeners();
        }
      } else if (response.statusCode == 400) {
        isLoading = false;
        changeState(ClassViewRekomendasi.empty);
        notifyListeners();
      } else {
        changeState(ClassViewRekomendasi.error);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      changeState(ClassViewRekomendasi.error);
      log(error.toString());
    }
    return responseData;
  }

  Future<ResponseDataRekomendasi> fetchSearch(
    int maxCarb,
    int maxFat,
    int maxCalories,
    String query,
  ) async {
    final search = apiService.baseUrlSpoonacular + apiService.getListFood;
    final apiKey = apiService.apiKey1;
    try {
      isLoading = true;
      notifyListeners();
      changeState(ClassViewRekomendasi.loading);
      final url = Uri.parse(
        "$search?apiKey=$apiKey&maxCarbs=$maxCarb&maxCalories=$maxCalories&maxFat=$maxFat&query=$query",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        isLoading = false;
        changeState(ClassViewRekomendasi.loaded);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
        if (responseData.result!.isEmpty) {
          changeState(ClassViewRekomendasi.empty);
          isLoading = false;
          notifyListeners();
        }
      } else if (response.statusCode == 400) {
        changeState(ClassViewRekomendasi.empty);
        isLoading = false;
        notifyListeners();
      } else {
        changeState(ClassViewRekomendasi.error);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
    }
    return responseData;
  }

  Future<ResponseDataRekomendasi> fetchRekomendasi(
    int maxCarb,
    int maxFat,
    int maxCalories,
    String query,
  ) async {
    isLoading = true;
    notifyListeners();
    changeState(ClassViewRekomendasi.loading);
    final breakfast = apiService.baseUrlSpoonacular + apiService.getListFood;
    final apiKey = apiService.apiKey1;
    try {
      final url = Uri.parse(
        "$breakfast?apiKey=$apiKey&type=main course&maxCarbs=$maxCarb&maxCalories=$maxCalories&maxFat=$maxFat&number=5&cuisine=asian&query=$query",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        isLoading = false;
        changeState(ClassViewRekomendasi.loaded);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
        if (responseData.result!.isEmpty) {
          changeState(ClassViewRekomendasi.empty);
          isLoading = false;
          notifyListeners();
        }
      } else if (response.statusCode == 400) {
        isLoading = false;
        changeState(ClassViewRekomendasi.empty);
        notifyListeners();
      } else {
        changeState(ClassViewRekomendasi.error);
        final item = json.decode(response.body);
        responseData = ResponseDataRekomendasi.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      changeState(ClassViewRekomendasi.error);
      log(error.toString());
    }
    return responseData;
  }
}
