import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_list_saved.dart';

class LogicAuth {
  ViewPolaMakan viewPolaMakan = ViewPolaMakan();
  ViewListSaved viewListSaved = ViewListSaved();
  ViewTargetProfile viewTargetProfile = ViewTargetProfile();
  void updatePolaMakan(String userId, String idToken) {
    viewPolaMakan
        .sendTablePolaMakan(
      0,
      0,
      0,
      0,
      0,
      0,
      userId,
      idToken,
      0,
    )
        .then((_) {
      viewPolaMakan.sendNutrisiPolaMakan(0, 0, 0, userId, idToken);
      viewListSaved.sendListBreakfast(
        "",
        "",
        0,
        0,
        0,
        userId,
        idToken,
      );
      viewListSaved.sendListLunch(
        "",
        "",
        0,
        0,
        0,
        userId,
        idToken,
      );
      viewListSaved.sendListDinner(
        "",
        "",
        0,
        0,
        0,
        userId,
        idToken,
      );
      viewListSaved.sendListSnack(
        "",
        "",
        0,
        0,
        0,
        userId,
        idToken,
      );
      viewTargetProfile.sendTarget(0, 0, 0, 0, "0", 0, userId, idToken);
    });
  }
}
