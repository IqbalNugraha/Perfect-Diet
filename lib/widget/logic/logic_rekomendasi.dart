import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_list_saved.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';

class LogicRekomendasi {
  ViewListSaved viewListSaved = ViewListSaved();
  ViewPolaMakan viewPolaMakan = ViewPolaMakan();
  MessageDialog messageDialog = MessageDialog();

  void sendBreakfast(
    String title,
    String imgUrl,
    int calValue,
    int fatValue,
    int carbValue,
    int sarapanValue,
    int fatMax,
    int carbMax,
    int nutrisiCal,
    int nutrisiFat,
    int nutrisiCarb,
    String userId,
    String idToken,
    BuildContext context,
  ) {
    if (calValue > sarapanValue || fatValue > fatMax || carbValue > carbMax) {
      messageDialog.showDialogSuccessLogin(
        context,
        "Kandugan telah melebihi batas harian",
      );
    } else {
      final finalCal = nutrisiCal + calValue;
      final finalFat = nutrisiFat + fatValue;
      final finalCarb = nutrisiCarb + carbValue;
      viewListSaved
          .sendListBreakfast(
        title,
        imgUrl,
        calValue,
        fatValue,
        carbValue,
        userId,
        idToken,
      )
          .then((_) {
        viewPolaMakan.sendNutrisiPolaMakan(
          finalCal,
          finalFat,
          finalCarb,
          userId,
          idToken,
        );
        messageDialog.showDialogSuccessAuth(
          context,
          idToken,
          userId,
          "Selamat, data makanan telah tersimpan",
        );
      });
    }
  }

  void sendLunch(
    String title,
    String imgUrl,
    int calValue,
    int fatValue,
    int carbValue,
    int lunchValue,
    int fatMax,
    int carbMax,
    int nutrisiCal,
    int nutrisiFat,
    int nutrisiCarb,
    String userId,
    String idToken,
    BuildContext context,
  ) {
    if (calValue > lunchValue || fatValue > fatMax || carbValue > carbMax) {
      messageDialog.showDialogSuccessLogin(
        context,
        "Kandugan telah melebihi batas harian",
      );
    } else {
      final finalCal = nutrisiCal + calValue;
      final finalFat = nutrisiFat + fatValue;
      final finalCarb = nutrisiCarb + carbValue;
      viewListSaved
          .sendListLunch(
        title,
        imgUrl,
        calValue,
        fatValue,
        carbValue,
        userId,
        idToken,
      )
          .then((_) {
        viewPolaMakan.sendNutrisiPolaMakan(
          finalCal,
          finalFat,
          finalCarb,
          userId,
          idToken,
        );
        messageDialog.showDialogSuccessAuth(
          context,
          idToken,
          userId,
          "Selamat, data makanan telah tersimpan",
        );
      });
    }
  }
}
