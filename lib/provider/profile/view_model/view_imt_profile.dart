import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/profile/model/imt_profile.dart';

enum ClassViewIMT {
  loading,
  loaded,
  error,
  empty,
}

class ViewImtProfile with ChangeNotifier {
  ClassViewIMT _state = ClassViewIMT.empty;
  ClassViewIMT get state => _state;
  ApiService apiService = ApiService();
  ImtProfile imtProfile = ImtProfile();

  changeState(ClassViewIMT s) {
    _state = s;
    notifyListeners();
  }

  Future<ImtProfile> sendIMT(
    double bmr,
    double imtLemak,
    double imt,
    String userId,
    String idToken,
    String hasilIMT,
  ) async {
    final url =
        Uri.parse("${apiService.imtProfileUrl + userId}.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            "bmrKalori": bmr,
            "imtLemak": imtLemak,
            "imt": imt,
            "hasil_imt" : hasilIMT,
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        imtProfile = ImtProfile.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
    }
    return imtProfile;
  }

  Future<ImtProfile> fetchIMT(String userId, String idToken) async {
    changeState(ClassViewIMT.loading);
    final url =
        Uri.parse("${apiService.imtProfileUrl + userId}.json?auth=$idToken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        changeState(ClassViewIMT.loaded);
        final item = json.decode(response.body);
        imtProfile = ImtProfile.fromJson(item);
        notifyListeners();
      } else {
        changeState(ClassViewIMT.empty);
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewIMT.error);
    }
    return imtProfile;
  }
}
