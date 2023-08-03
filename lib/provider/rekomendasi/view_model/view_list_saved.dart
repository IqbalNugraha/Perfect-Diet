import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skiripsi_app/provider/api_service.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/model_list_saved.dart';

enum ClassViewListSaved {
  loading,
  loaded,
  error,
  empty,
}

class ViewListSaved with ChangeNotifier {
  ApiService apiService = ApiService();
  ClassViewListSaved _state = ClassViewListSaved.empty;
  ClassViewListSaved get state => _state;
  ListSaved responseListSaved = ListSaved();
  List<ListSaved> list = [];

  changeState(ClassViewListSaved s) {
    _state = s;
    notifyListeners();
  }

  Future<ListSaved> sendListBreakfast(
    String namaMakanan,
    String imgUrl,
    int kalori,
    int lemak,
    int karbo,
    String userId,
    String idToken,
  ) async {
    changeState(ClassViewListSaved.loading);
    final url =
        Uri.parse("${apiService.listSarapan}$userId.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            "nama_makanan": namaMakanan,
            "img_url": imgUrl,
            "kalori": kalori,
            "lemak": lemak,
            "karbo": karbo
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        responseListSaved = ListSaved.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewListSaved.error);
    }
    return responseListSaved;
  }

  Future<ListSaved> sendListLunch(
    String namaMakanan,
    String imgUrl,
    int kalori,
    int lemak,
    int karbo,
    String userId,
    String idToken,
  ) async {
    changeState(ClassViewListSaved.loading);
    final url =
        Uri.parse("${apiService.listMakanSiang}$userId.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            "nama_makanan": namaMakanan,
            "img_url": imgUrl,
            "kalori": kalori,
            "lemak": lemak,
            "karbo": karbo
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        responseListSaved = ListSaved.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewListSaved.error);
    }
    return responseListSaved;
  }

  Future<ListSaved> sendListDinner(
    String namaMakanan,
    String imgUrl,
    int kalori,
    int lemak,
    int karbo,
    String userId,
    String idToken,
  ) async {
    changeState(ClassViewListSaved.loading);
    final url =
        Uri.parse("${apiService.listMakanMalam}$userId.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            "nama_makanan": namaMakanan,
            "img_url": imgUrl,
            "kalori": kalori,
            "lemak": lemak,
            "karbo": karbo
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        responseListSaved = ListSaved.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewListSaved.error);
    }
    return responseListSaved;
  }

  Future<ListSaved> sendListSnack(
    String namaMakanan,
    String imgUrl,
    int kalori,
    int lemak,
    int karbo,
    String userId,
    String idToken,
  ) async {
    changeState(ClassViewListSaved.loading);
    final url =
        Uri.parse("${apiService.listCamilan}$userId.json?auth=$idToken");
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            "nama_makanan": namaMakanan,
            "img_url": imgUrl,
            "kalori": kalori,
            "lemak": lemak,
            "karbo": karbo
          },
        ),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        responseListSaved = ListSaved.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewListSaved.error);
    }
    return responseListSaved;
  }

  Future<ListSaved> fetchListSarapan(
    String userId,
    String idToken,
  ) async {
    changeState(ClassViewListSaved.loading);
    final url =
        Uri.parse("${apiService.listSarapan}$userId.json?auth=$idToken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        changeState(ClassViewListSaved.loaded);
        final item = json.decode(response.body);
        responseListSaved = ListSaved.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewListSaved.error);
    }
    return responseListSaved;
  }

  Future<ListSaved> fetchListMakanSiang(
    String userId,
    String idToken,
  ) async {
    changeState(ClassViewListSaved.loading);
    final url =
        Uri.parse("${apiService.listMakanSiang}$userId.json?auth=$idToken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        changeState(ClassViewListSaved.loaded);
        final item = json.decode(response.body);
        responseListSaved = ListSaved.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewListSaved.error);
    }
    return responseListSaved;
  }

  Future<ListSaved> fetchListMakanMalam(
    String userId,
    String idToken,
  ) async {
    changeState(ClassViewListSaved.loading);
    final url =
        Uri.parse("${apiService.listMakanMalam}$userId.json?auth=$idToken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        changeState(ClassViewListSaved.loaded);
        final item = json.decode(response.body);
        responseListSaved = ListSaved.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewListSaved.error);
    }
    return responseListSaved;
  }

  Future<ListSaved> fetchListCamilan(
    String userId,
    String idToken,
  ) async {
    changeState(ClassViewListSaved.loading);
    final url =
        Uri.parse("${apiService.listCamilan}$userId.json?auth=$idToken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        changeState(ClassViewListSaved.loaded);
        final item = json.decode(response.body);
        responseListSaved = ListSaved.fromJson(item);
        notifyListeners();
      }
    } catch (error) {
      log(error.toString());
      changeState(ClassViewListSaved.error);
    }
    return responseListSaved;
  }
}
