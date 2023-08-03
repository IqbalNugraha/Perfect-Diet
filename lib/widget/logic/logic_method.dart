import 'package:flutter/cupertino.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

class LogicMethod {
  MessageDialog messageDialog = MessageDialog();
  StringCustom stringCustom = StringCustom();

  Future<void> sendTablePolaMakan(
    double calories,
    double ngemil,
    int fat,
    int carb,
    String hasilIMT,
    String userId,
    String idToken,
    BuildContext context,
  ) {
    ViewPolaMakan viewPolaMakan = ViewPolaMakan();
    double? sarapan, makanSiang, makanMalam, camilan;
    if (hasilIMT == "Kekurangan Berat Badan" && ngemil == 0.1) {
      sarapan = 0.25 * calories;
      makanSiang = 0.4 * calories;
      makanMalam = 0.25 * calories;
      camilan = 0.1 * calories;
    } else if (hasilIMT == "Kekurangan Berat Badan" && ngemil == 0.0) {
      sarapan = 0.3 * calories;
      makanSiang = 0.4 * calories;
      makanMalam = 0.3 * calories;
      camilan = 0.0 * calories;
    } else if (hasilIMT == "Normal" && ngemil == 0.1) {
      sarapan = 0.3 * calories;
      makanSiang = 0.4 * calories;
      makanMalam = 0.2 * calories;
      camilan = 0.1 * calories;
    } else if (hasilIMT == "Normal" && ngemil == 0.0) {
      sarapan = 0.3 * calories;
      makanSiang = 0.4 * calories;
      makanMalam = 0.3 * calories;
      camilan = 0.0 * calories;
    } else if (hasilIMT == "Kelebihan Berat Badan" && ngemil == 0.1) {
      sarapan = 0.3 * calories;
      makanSiang = 0.35 * calories;
      makanMalam = 0.25 * calories;
      camilan = 0.1 * calories;
    } else if (hasilIMT == "Kelebihan Berat Badan" && ngemil == 0.0) {
      sarapan = 0.35 * calories;
      makanSiang = 0.4 * calories;
      makanMalam = 0.25 * calories;
      camilan = 0.0 * calories;
    } else if (hasilIMT == "Kelebihan Berat Badan Parah" && ngemil == 0.1) {
      sarapan = 0.3 * calories;
      makanSiang = 0.35 * calories;
      makanMalam = 0.25 * calories;
      camilan = 0.1 * calories;
    } else if (hasilIMT == "Kelebihan Berat Badan Parah" && ngemil == 0.0) {
      sarapan = 0.35 * calories;
      makanSiang = 0.45 * calories;
      makanMalam = 0.2 * calories;
      camilan = 0.0 * calories;
    } else {
      sarapan = 0.0 * calories;
      makanSiang = 0.0 * calories;
      makanMalam = 0.0 * calories;
      camilan = 0.0 * calories;
    }
    int valueSarapan = sarapan.toInt();
    int valueMakanSiang = makanSiang.toInt();
    int valueMakanMalam = makanMalam.toInt();
    int valueNgemil = camilan.toInt();

    return viewPolaMakan.sendTablePolaMakan(valueSarapan, valueMakanSiang,
        valueMakanMalam, valueNgemil, fat, carb, userId, idToken, ngemil);
  }
}
