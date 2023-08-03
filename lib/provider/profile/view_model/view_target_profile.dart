import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/profile/model/target_profile.dart';

enum ClassViewTarget {
  loading,
  loaded,
  error,
  empty,
}

class ViewTargetProfile with ChangeNotifier {
  ClassViewTarget _state = ClassViewTarget.empty;
  ClassViewTarget get state => _state;
  ApiService apiService = ApiService();
  TargetProfile targetProfile = TargetProfile();
  bool isValid = false;

  changeState(ClassViewTarget s) {
    _state = s;
    notifyListeners();
  }

  Future<TargetProfile> sendTarget(
    double calories,
    double caloriesDiet,
    double carb,
    int fat,
    String weight,
    int day,
    String userId,
    String idToken,
  ) async {
    final url =
        Uri.parse("${apiService.targetProfileUrl + userId}.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode({
          "berat_badan": weight,
          "hari": day,
          "kalori": calories,
          "kalori_diet": caloriesDiet,
          "lemak": fat,
          "karbo": carb,
        }),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        targetProfile = TargetProfile.fromJson(item);
        notifyListeners();
      } else if (response.statusCode == 400) {
        log(response.body);
      } else if (response.statusCode == 401) {
        log(response.body);
      }
    } catch (error) {
      log(error.toString());
    }
    return targetProfile;
  }

  Future<TargetProfile> fetchTarget(String userId, String idToken) async {
    isValid = true;
    notifyListeners();
    changeState(ClassViewTarget.loading);
    final url =
        Uri.parse("${apiService.targetProfileUrl + userId}.json?auth=$idToken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        isValid = false;
        notifyListeners();
        changeState(ClassViewTarget.loaded);
        final item = json.decode(response.body);
        targetProfile = TargetProfile.fromJson(item);
        notifyListeners();
        if (targetProfile.calories == null &&
            targetProfile.caloriesDiet == null &&
            targetProfile.carb == null &&
            targetProfile.day == null &&
            targetProfile.fat == null &&
            targetProfile.weight == null) {
          isValid = true;
          notifyListeners();
        }
      } else {
        isValid = true;
        notifyListeners();
        changeState(ClassViewTarget.empty);
      }
    } catch (error) {
      isValid = true;
      notifyListeners();
      changeState(ClassViewTarget.error);
      log(error.toString());
    }
    return targetProfile;
  }
}
