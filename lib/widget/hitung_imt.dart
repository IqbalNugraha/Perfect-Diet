import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';

class FunctionIMT {
  MessageDialog messageDialog = MessageDialog();

  double hitungIMT(int weight, int height) {
    var tinggi = height / 100;
    var imt = (weight / (tinggi * tinggi));
    return imt;
  }

  String formatDouble(double imt, int decimalNumber) {
    NumberFormat numberFormat = NumberFormat.currency(
        locale: 'id', symbol: '', decimalDigits: decimalNumber);
    var hasilIMT = numberFormat.format(imt);
    return hasilIMT;
  }

  String validasiIMT(double imt) {
    String nilaiIMT = "";
    if (imt < 18.5) {
      nilaiIMT = "Kekurangan Berat Badan";
    } else if (18.5 <= imt && imt <= 25) {
      nilaiIMT = "Normal";
    } else if (25 < imt && imt <= 27) {
      nilaiIMT = "Kelebihan Berat Badan";
    } else {
      nilaiIMT = "Kelebihan Berat Badan Parah";
    }
    return nilaiIMT;
  }

  double hitungIMTLemak(double imt, int usia) {
    var imtLemak = ((1.2 * imt) + (0.23 * usia) - 5.4);
    return imtLemak;
  }

  double hitungKalori(int weight, int height, int age, String activity) {
    double active = 0;
    if (activity == "Pilih Aktivitas Harian") {
      active = 0;
    } else if (activity == "Aktivitas Ringan") {
      active = 1.4;
    } else if (activity == "Aktivitas Sedang") {
      active = 1.64;
    } else if (activity == "Aktivitas Berat") {
      active = 1.82;
    }
    var bmrTemp = (447.6 + (9.25 * weight) + (3.1 * height) - (4.33 * age));
    var bmr = bmrTemp * active;
    return bmr;
  }

  double hitungTarget(
    TextEditingController textHari,
    TextEditingController textKalori,
    double bmr,
  ) {
    var tempKalori = double.parse(textKalori.text);
    var textDay = int.parse(textHari.text);
    var weightPerCalory = tempKalori / 1000;
    var day = 7;
    var tempDay = textDay / day;
    var result = tempDay * weightPerCalory;
    return result;
  }

  Future<double> hitungTargetPengguna(
    TextEditingController textKalori,
    double bmr,
    BuildContext context,
  ) async {
    int? tempHari;
    double? result;
    var tempKalori = int.parse(textKalori.text);
    if (tempKalori > 1000) {
      messageDialog.showErrorCalory(
        context,
        "Kalori tidak boleh lebih dari 1000",
        textKalori,
      );
    }
    if (tempKalori < 500) {
      tempHari = 14;
    } else {
      tempHari = 14;
    }
    var weightPerCalory = tempKalori / 1000;
    var day = 7;
    var tempDay = tempHari / day;
    await Future.delayed(const Duration(seconds: 2), () {
      result = tempDay * weightPerCalory;
    });

    return result ?? 0;
  }

  double hitungBatasKalori(double bmr, TextEditingController textKalori) {
    var kalori = bmr - double.parse(textKalori.text);
    return kalori;
  }

  int hitungLemakHarian(int usia) {
    var result = 0;
    if (1 <= usia && usia >= 6) {
      result = 45;
    } else if (7 <= usia && usia >= 12) {
      result = 50;
    } else if (13 <= usia && usia >= 18) {
      result = 70;
    } else if (19 <= usia && usia >= 29) {
      result = 65;
    } else if (30 <= usia && usia >= 49) {
      result = 60;
    } else if (50 <= usia && usia >= 64) {
      result = 50;
    } else if (65 <= usia && usia >= 80) {
      result = 45;
    }
    return result;
  }

  double hitungKarbo(double kalori) {
    var karboTemp = kalori * 0.45;
    var karbo = karboTemp * 0.129568;
    return karbo;
  }

  double hitungDietKalori(double kaloriUtama, double kaloriDiet) {
    var diet = kaloriUtama - kaloriDiet;
    return diet;
  }

  double hitungPersen(TextEditingController textEditing) {
    var text = double.parse(textEditing.text);
    var hasil = text / 100;
    return hasil;
  }

  String persenToText(double value) {
    var textTemp = value * 100;
    var text = formatDouble(textTemp, 0);
    return text;
  }

  String hitungPolaMakan(double persen, double value) {
    var polaMakanTemp = persen * value;
    var polaMakan = formatDouble(polaMakanTemp, 0);
    return polaMakan;
  }

  double convertNgemil(String text) {
    double value = 0;
    if (text == "Tidak Ngemil") {
      value = 0;
    } else if (text == "Ngemil") {
      value = 0.1;
    }
    return value;
  }

  String convertNgemilToText(double value) {
    String result = "";
    if (value == 0) {
      result = "Tidak Ngemil";
    } else if (value == 0.1) {
      result = "Ngemil";
    }
    return result;
  }
}
