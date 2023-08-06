import 'package:flutter/widgets.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';

class LogicProfile {
  MessageDialog messageDialog = MessageDialog();
  ViewTargetProfile viewTargetProfile = ViewTargetProfile();
  FunctionIMT functionIMT = FunctionIMT();

  int penguranganKalori(int umur) {
    var kalori = 0;
    if (umur >= 18 && umur < 31) {
      kalori = 600;
    } else if (umur >= 31 && umur < 60) {
      kalori = 400;
    }
    return kalori;
  }

  double hitungTarget(
    int hari,
    int kalori,
    double bmr,
  ) {
    var weightPerCalory = kalori / 1000;
    var day = 7;
    var tempDay = hari / day;
    var result = tempDay * weightPerCalory;
    return result;
  }

  Future<double> hitungTargetPengguna(
    TextEditingController textKalori,
    double bmr,
    String dropdownDay,
    BuildContext context,
  ) async {
    int? tempDay;
    double? result;
    var tempKalori = int.parse(textKalori.text);
    if (tempKalori > 1000) {
      messageDialog.showErrorCalory(
        context,
        "Kalori tidak boleh lebih dari 1000",
        textKalori,
      );
    }
    print(dropdownDay);
    if (dropdownDay == "7 Hari") {
      tempDay = 7;
    } else if (dropdownDay == "14 Hari") {
      tempDay = 14;
    } else if (dropdownDay == "21 Hari") {
      tempDay = 21;
    } else {
      tempDay = 28;
    }

    var weightPerCalory = tempKalori / 1000;
    var day = 7;
    var resultDay = tempDay / day;
    print(resultDay);
    await Future.delayed(const Duration(seconds: 2), () {
      result = resultDay * weightPerCalory;
    });

    return result ?? 0;
  }

  String targetHari(int day) {
    String hari = "";
    if (day == 7) {
      hari = "7 Hari";
    } else if (day == 14) {
      hari = "14 Hari";
    } else if (day == 21) {
      hari = "21 Hari";
    } else {
      hari = "28 Hari";
    }
    return hari;
  }

  int parseTargetHari(String dropdownValue) {
    int value = 0;
    if (dropdownValue == "7 Hari") {
      value = 7;
    } else if (dropdownValue == "14 Hari") {
      value = 14;
    } else if (dropdownValue == "21 Hari") {
      value = 21;
    } else {
      value = 28;
    }
    return value;
  }

  void updateTarget(
    double cal,
    double bmr,
    String weight,
    int day,
    int age,
    String userId,
    String idToken,
    BuildContext context,
  ) {
    var calDiet = functionIMT.hitungDietKalori(
      bmr,
      cal,
    );
    var fat = functionIMT.hitungLemakHarian(age);
    var carb = functionIMT.hitungKarbo(calDiet);
    viewTargetProfile
        .sendTarget(
      cal,
      calDiet,
      carb,
      fat,
      weight,
      day,
      userId,
      idToken,
    )
        .then((_) {
      messageDialog.showDialogSuccessProfile(
        context,
        userId,
        idToken,
        "Tambah Target Pengguna Berhasil",
      );
    });
  }
}
