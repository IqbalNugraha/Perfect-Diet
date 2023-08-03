import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:skiripsi_app/provider/profile/model/profile.dart';

enum ClassViewProfile {
  loading,
  loaded,
  error,
  empty,
}

class ViewProfile with ChangeNotifier {
  ApiService apiService = ApiService();
  Profile profile = Profile();
  ClassViewProfile _state = ClassViewProfile.empty;
  ClassViewProfile get state => _state;
  bool isLoading = false;

  changeState(ClassViewProfile s) {
    _state = s;
    notifyListeners();
  }

  Future<Profile> fetchProfile(String userId, String idToken) async {
    changeState(ClassViewProfile.loading);
    final url =
        Uri.parse("${apiService.profileUrl + userId}.json?auth=$idToken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        changeState(ClassViewProfile.loaded);
        final item = json.decode(response.body);
        profile = Profile.fromJson(item);
        notifyListeners();
      } else {
        changeState(ClassViewProfile.empty);
      }
    } catch (error) {
      changeState(ClassViewProfile.error);
      log(error.toString());
    }
    return profile;
  }

  Future<Profile> sendProfile(String userId, String idToken, String name,
      int age, int weight, int height, String activity) async {
    final url =
        Uri.parse("${apiService.profileUrl + userId}.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            "aktivitas": activity,
            "berat_badan": weight,
            "nama": name,
            "tinggi_badan": height,
            "usia": age
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        profile = Profile.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
    }
    return profile;
  }
}
