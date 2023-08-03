import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/row_custom.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

enum Snack { tidakNgemil, ngemil }

class HabitProfileScreen extends StatefulWidget {
  final double sarapan, makanSiang, makanMalam, ngemil;
  final String userId, idToken;
  const HabitProfileScreen({
    required this.sarapan,
    required this.makanSiang,
    required this.makanMalam,
    required this.ngemil,
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<HabitProfileScreen> createState() => _HabitProfileScreenState();
}

class _HabitProfileScreenState extends State<HabitProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StringCustom stringCustom = StringCustom();
  FunctionIMT function = FunctionIMT();
  MessageDialog messageDialog = MessageDialog();
  var textSarapan = TextEditingController();
  var textMakanSiang = TextEditingController();
  var textMakanMalam = TextEditingController();
  String selectedSnack = "Tidak Ngemil";

  @override
  void initState() {
    var sarapanValue = function.persenToText(widget.sarapan);
    var makanSiangValue = function.persenToText(widget.makanSiang);
    var makanMalamValue = function.persenToText(widget.makanMalam);
    var ngemilValue = function.convertNgemilToText(widget.ngemil);
    textSarapan.text = sarapanValue;
    textMakanSiang.text = makanSiangValue;
    textMakanMalam.text = makanMalamValue;
    selectedSnack = ngemilValue;
    super.initState();
  }

  void _handleSnackChange(String? value) {
    setState(() {
      selectedSnack = value!;
    });
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void polaMakan() {
    var sarapan = function.hitungPersen(textSarapan);
    var makanSiang = function.hitungPersen(textMakanSiang);
    var makanMalam = function.hitungPersen(textMakanMalam);
    var ngemil = function.convertNgemil(selectedSnack);
    var total = sarapan + makanSiang + makanMalam + ngemil;

    if (sarapan > 0.4) {
      return messageDialog.showErrorPolaMakan(
        context,
        "Sarapan Tidak Boleh > 40 %",
        textSarapan,
      );
    } else if (makanSiang > 0.5) {
      return messageDialog.showErrorPolaMakan(
        context,
        "Makan Siang Tidak Boleh > 50 %",
        textMakanSiang,
      );
    } else if (makanMalam > 0.4) {
      return messageDialog.showErrorPolaMakan(
        context,
        "Makan Malam Tidak Boleh > 40 %",
        textMakanMalam,
      );
    } else if (total > 1.01) {
      return messageDialog.showErrorPolaMakanTotal(
        context,
        "Total Tidak Boleh > 100 %",
        textSarapan,
        textMakanSiang,
        textMakanMalam,
      );
    } else if (total < 0.99) {
      return messageDialog.showErrorPolaMakanTotal(
        context,
        "Total Tidak Boleh < 100 %",
        textSarapan,
        textMakanSiang,
        textMakanMalam,
      );
    }
    ViewPolaMakan viewPolaMakan = ViewPolaMakan();
    viewPolaMakan.sendPolaMakan(
      sarapan,
      makanSiang,
      makanMalam,
      ngemil,
      widget.userId,
      widget.idToken,
    );
    messageDialog.showDialogSuccessProfile(
      context,
      widget.userId,
      widget.idToken,
      "Selamat Data yang Anda Masukkan Sudah Tersimpan",
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.background(),
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const RowCustomToolbar(toolbar: "Pola Makan Diet Sehat"),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FontPop14w400Black(text: stringCustom.polaMakan),
                        const SizedBox(height: 16),
                        const FontPop16w600Black(text: "Kebutuhan Pokok"),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: FontPop14w600Black(text: "Sarapan"),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: FontPop12w400Semi(
                              text: stringCustom.rekomendasiSarapan),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RowCustomTextField60(
                            judul: "Persentase Sarapan",
                            hint: "0",
                            textHeight: textSarapan,
                            satuan: "%",
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: FontPop14w600Black(text: "Makan Siang"),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: FontPop12w400Semi(
                              text: stringCustom.rekomendasiMakanSiang),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RowCustomTextField60(
                            judul: "Persentase Makan Siang",
                            hint: "0",
                            textHeight: textMakanSiang,
                            satuan: "%",
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: FontPop14w600Black(text: "Makan Malam"),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: FontPop12w400Semi(
                              text: stringCustom.rekomendasiMakanMalam),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RowCustomTextField60(
                            judul: "Persentase Makan Malam",
                            hint: "0",
                            textHeight: textMakanMalam,
                            satuan: "%",
                          ),
                        ),
                        const SizedBox(height: 16),
                        const FontPop16w600Black(text: "Kebutuhan Tambahan"),
                        const SizedBox(height: 8),
                        FontPop12w400Semi(text: stringCustom.desCamilan),
                        ListTile(
                          title: const FontPop14w400Black(text: "Tidak Ngemil"),
                          leading: Radio(
                            value: "Tidak Ngemil",
                            groupValue: selectedSnack,
                            onChanged: _handleSnackChange,
                          ),
                        ),
                        ListTile(
                          title: const FontPop14w400Black(text: "Ngemil"),
                          leading: Radio(
                            value: "Ngemil",
                            groupValue: selectedSnack,
                            onChanged: _handleSnackChange,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: size.width,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.red(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (validateAndSave()) {
                                polaMakan();
                              }
                            },
                            child: const FontPop14w400White(
                              text: "Simpan",
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
