import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/profile/model/pola_makan.dart';
import 'package:http/http.dart' as http;

enum ClassViewPola {
  loading,
  loaded,
  error,
  empty,
}

class ViewPolaMakan with ChangeNotifier {
  ClassViewPola _state = ClassViewPola.empty;
  ClassViewPola get state => _state;
  ApiService apiService = ApiService();
  PolaMakan polaMakan = PolaMakan();
  TablePolaMakan tablePolaMakan = TablePolaMakan();
  NutrisiPolaMakan nutrisiPolaMakan = NutrisiPolaMakan();

  List<ListTablePola> list = [];
  bool isValid = false;
  bool isCamilan = false;

  changeState(ClassViewPola s) {
    _state = s;
    notifyListeners();
  }

  Future<PolaMakan> sendPolaMakan(double sarapan, double makanSiang,
      double makanMalam, double ngemil, String userId, String idToken) async {
    final url =
        Uri.parse("${apiService.polaMakanUrl + userId}.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            "sarapan": sarapan,
            "makan_siang": makanSiang,
            "makan_malam": makanMalam,
            "ngemil": ngemil
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        polaMakan = PolaMakan.fromJson(item);
        notifyListeners();
      } else if (response.statusCode == 400) {
        log("Error");
      }
    } catch (error) {
      log(error.toString());
    }
    return polaMakan;
  }

  Future<PolaMakan> fetchPolaMakan(String userId, String idToken) async {
    changeState(ClassViewPola.loading);
    isValid = false;
    isCamilan = false;
    notifyListeners();
    final url =
        Uri.parse("${apiService.polaMakanUrl + userId}.json?auth=$idToken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        isValid = true;
        isCamilan = true;
        changeState(ClassViewPola.loaded);
        final item = json.decode(response.body);
        polaMakan = PolaMakan.fromJson(item);
        notifyListeners();
        if (polaMakan.ngemil == 0.1) {
          isCamilan = true;
          notifyListeners();
        } else {
          isCamilan = false;
          notifyListeners();
        }
      } else {
        changeState(ClassViewPola.empty);
      }
    } catch (error) {
      changeState(ClassViewPola.error);
      log(error.toString());
      isValid = false;
      isCamilan = false;
      notifyListeners();
    }
    return polaMakan;
  }

  Future<TablePolaMakan> sendTablePolaMakan(
    int sarapan,
    int makanSiang,
    int makanMalam,
    int ngemil,
    int fat,
    int carb,
    String userId,
    String idToken,
    double ngemilValue,
  ) async {
    final url =
        Uri.parse("${apiService.tablePolaMakan + userId}.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            "sarapan": sarapan,
            "makan_siang": makanSiang,
            "makan_malam": makanMalam,
            "ngemil": ngemil,
            "ngemil_value": ngemilValue,
            "carb": carb,
            "fat": fat
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        tablePolaMakan = TablePolaMakan.fromJson(item);
        notifyListeners();
      } else if (response.statusCode == 400) {
        log("Error");
      }
    } catch (error) {
      log(error.toString());
    }
    return tablePolaMakan;
  }

  Future<TablePolaMakan> fetchTablePolaMakan(
      String userId, String idToken) async {
    changeState(ClassViewPola.loading);
    isValid = false;
    isCamilan = false;
    notifyListeners();
    final url =
        Uri.parse("${apiService.tablePolaMakan + userId}.json?auth=$idToken");
    try {
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        isValid = true;
        isCamilan = true;
        changeState(ClassViewPola.loaded);
        final item = json.decode(response.body);
        tablePolaMakan = TablePolaMakan.fromJson(item);
        notifyListeners();
        if (tablePolaMakan.ngemil != 0) {
          isCamilan = true;
          notifyListeners();
        } else {
          isCamilan = false;
          notifyListeners();
        }
      } else {
        changeState(ClassViewPola.empty);
      }
    } catch (error) {
      changeState(ClassViewPola.error);
      log(error.toString());
      isValid = false;
      isCamilan = false;
      notifyListeners();
    }
    return tablePolaMakan;
  }

  Future<NutrisiPolaMakan> sendNutrisiPolaMakan(
    int cal,
    int fat,
    int carb,
    String userId,
    String idToken,
  ) async {
    final url =
        Uri.parse("${apiService.nutrisiPolaMakan + userId}.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {"cal": cal, "carb": carb, "fat": fat},
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        nutrisiPolaMakan = NutrisiPolaMakan.fromJson(item);
        notifyListeners();
      } else if (response.statusCode == 400) {
        log("Error");
      }
    } catch (error) {
      log(error.toString());
    }
    return nutrisiPolaMakan;
  }

  Future<NutrisiPolaMakan> fetchNutrisiPolaMakan(
      String userId, String idToken) async {
    changeState(ClassViewPola.loading);
    isValid = false;
    isCamilan = false;
    notifyListeners();
    final url =
        Uri.parse("${apiService.nutrisiPolaMakan + userId}.json?auth=$idToken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        isValid = true;
        isCamilan = true;
        changeState(ClassViewPola.loaded);
        final item = json.decode(response.body);
        nutrisiPolaMakan = NutrisiPolaMakan.fromJson(item);
        notifyListeners();
        if (tablePolaMakan.ngemil != 0) {
          isCamilan = true;
          notifyListeners();
        } else {
          isCamilan = false;
          notifyListeners();
        }
      } else {
        changeState(ClassViewPola.empty);
      }
    } catch (error) {
      changeState(ClassViewPola.error);
      log(error.toString());
      isValid = false;
      isCamilan = false;
      notifyListeners();
    }
    return nutrisiPolaMakan;
  }

  Future<List<ListTablePola>> fetchListPola() async {
    changeState(ClassViewPola.loading);
    final url = Uri.parse("${apiService.listTablePola}.json");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        changeState(ClassViewPola.loaded);
        final item = json.decode(response.body).cast<Map<String, dynamic>>();
        list = item
            .map<ListTablePola>((json) => ListTablePola.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        changeState(ClassViewPola.error);
      }
    } catch (error) {
      changeState(ClassViewPola.error);
      log(error.toString());
    }
    return list;
  }
}
