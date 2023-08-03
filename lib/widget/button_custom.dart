import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_list_saved.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';

class ButtonCamera extends StatefulWidget {
  final String userId, idToken, title, imgUrl;
  final int sarapanValue,
      makanSiangValue,
      makanMalamValue,
      camilanValue,
      fatMax,
      carbMax,
      calValue,
      fatValue,
      carbValue,
      nutrisiCal,
      nutrisiFat,
      nutrisiCarb;
  final double ngemil;
  const ButtonCamera({
    required this.title,
    required this.imgUrl,
    required this.calValue,
    required this.fatValue,
    required this.carbValue,
    required this.sarapanValue,
    required this.makanSiangValue,
    required this.makanMalamValue,
    required this.camilanValue,
    required this.fatMax,
    required this.carbMax,
    required this.ngemil,
    required this.nutrisiCal,
    required this.nutrisiFat,
    required this.nutrisiCarb,
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<ButtonCamera> createState() => _ButtonCameraState();
}

class _ButtonCameraState extends State<ButtonCamera> {
  ViewListSaved viewListSaved = ViewListSaved();
  MessageDialog messageDialog = MessageDialog();
  ViewPolaMakan viewPolaMakan = ViewPolaMakan();
  String? selected;
  List<String> selectedItems = [];
  bool isChecked = false;

  void _showModalBottom(Widget widget) async {
    return await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      backgroundColor: MyColors.white(),
      isScrollControlled: true,
      builder: (context) {
        return widget;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showModalBottom(
          DialogPolaMakan(
            title: widget.title,
            imgUrl: widget.imgUrl,
            calValue: widget.calValue,
            carbValue: widget.carbValue,
            fatValue: widget.fatValue,
            userId: widget.userId,
            idToken: widget.idToken,
            breakfastValue: widget.sarapanValue,
            lunchValue: widget.makanSiangValue,
            dinnerValue: widget.makanMalamValue,
            fatMax: widget.fatMax,
            carbMax: widget.carbMax,
            nutrisiCal: widget.nutrisiCal,
            nutrisiCarb: widget.nutrisiCarb,
            nutrisiFat: widget.nutrisiFat,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: MyColors.red(),
      ),
      child: FontPoppins(
        text: "Simpan",
        color: MyColors.white(),
        size: 14,
        fontWeight: FontWeight.w400,
        alignment: TextAlign.center,
      ),
    );
  }
}
