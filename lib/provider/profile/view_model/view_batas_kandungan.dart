// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:skiripsi_app/provider/api_service.dart';
// import 'package:skiripsi_app/provider/profile/model/batas_kandungan.dart';

// class ViewBatasKandungan with ChangeNotifier {
//   ApiService apiService = ApiService();
//   BatasKandungan batasKandungan = BatasKandungan();

//   Future<BatasKandungan> sendBatasKandungan(
//     double batasSarapan,
//     double batasMakanSiang,
//     double batasMakanMalam,
//     double batasCamilan,
//     String userId,
//     String idToken,
//   ) async {
//     final url =
//         Uri.parse("${apiService.batasKandunganUrl + userId}.json?auth=$idToken");
//     try {
//       final response = await http.put(
//         url,
//         body: json.encode(
//           {
//             "batas_sarapan": batasSarapan,
//             "batas_makan_siang": batasMakanSiang,
//             "batas_makan_malam": batasMakanMalam,
//             "batas_camilan": batasCamilan
//           },
//         ),
//       );
//       if (response.statusCode == 200) {
//         final item = json.decode(response.body);
//         batasKandungan = BatasKandungan.fromJson(item);
//         notifyListeners();
//       } else if (response.statusCode == 400) {
//         log("Error");
//       }
//     } catch (error) {
//       log(error.toString());
//     }
//     return batasKandungan;
//   }

//   Future<BatasKandungan> fetchPolaMakan(String userId, String idToken) async {
//     final url =
//         Uri.parse("${apiService.batasKandunganUrl + userId}.json?auth=$idToken");
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final item = json.decode(response.body);
//         batasKandungan = BatasKandungan.fromJson(item);
//         notifyListeners();
//       } else if (response.statusCode == 400) {
//         const message = "Error";
//       }
//     } catch (error) {
//       log(error.toString());
//     }
//     return batasKandungan;
//   }
// }
