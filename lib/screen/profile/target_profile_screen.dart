import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/input_custom.dart';
import 'package:skiripsi_app/widget/row_custom.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

class TargetProfileScreen extends StatefulWidget {
  final int dayTarget, usia;
  final double caloriesTarget, bmrKalori;
  final String idToken, localId, weightTarget;
  const TargetProfileScreen({
    required this.dayTarget,
    required this.weightTarget,
    required this.caloriesTarget,
    required this.bmrKalori,
    required this.localId,
    required this.idToken,
    required this.usia,
    super.key,
  });

  @override
  State<TargetProfileScreen> createState() => _TargetProfileScreenState();
}

class _TargetProfileScreenState extends State<TargetProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MessageDialog messageDialog = MessageDialog();
  StringCustom stringCustom = StringCustom();
  InputCustom inputCustom = InputCustom();
  FunctionIMT imt = FunctionIMT();
  var textDay = TextEditingController();
  var textCalories = TextEditingController();
  Color btnSave = MyColors.red();
  Color btnEdit = MyColors.blue();
  late var hari = widget.dayTarget.toString();
  late var kalori = widget.caloriesTarget.toString();
  double? target;

  @override
  void initState() {
    textCalories.text = kalori;
    textDay.text = hari;
    String cleanedString = widget.weightTarget.replaceAll(',', '.');
    target = double.tryParse(cleanedString);
    super.initState();
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var bmrTemp = widget.bmrKalori;
    return Scaffold(
      backgroundColor: MyColors.background(),
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: const RowCustomToolbar(toolbar: "Target Pengguna"),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.topCenter,
                    child: FontPop18w400Black(
                      text: stringCustom.targetProfile,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.grey(),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ColumnCustomTarget(
                        nilaiBerat: widget.weightTarget.toString(),
                        nilaiHari: widget.dayTarget.toString(),
                        nilaiKalori: widget.caloriesTarget.toString(),
                        satuan1: "Kg",
                        satuan2: "Hari",
                        satuan3: "Kkal",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: size.width,
                    height: 1,
                    color: MyColors.grey(),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: FontPoppins(
                      text: "Rekomendasi Target Pengguna",
                      color: MyColors.blackFont(),
                      size: 16,
                      fontWeight: FontWeight.w400,
                      alignment: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RowCustomTarget(
                    judul: "Pengurangan Kalori",
                    widget: FontPoppins(
                      text: textCalories.text,
                      color: MyColors.blackFont(),
                      size: 16,
                      fontWeight: FontWeight.w400,
                      alignment: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RowCustomTarget(
                    judul: "Target Hari",
                    widget: FontPoppins(
                      text: "14 Hari",
                      color: MyColors.blackFont(),
                      size: 16,
                      fontWeight: FontWeight.w400,
                      alignment: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: FontPoppins(
                          text: "Target Pengguna",
                          color: MyColors.blackFont(),
                          size: 12,
                          fontWeight: FontWeight.w400,
                          alignment: TextAlign.start,
                        ),
                      ),
                      const SizedBox(width: 10),
                      FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 2)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                color: MyColors.red(),
                              ),
                            );
                          } else {
                            return Align(
                              alignment: Alignment.center,
                              child: FontPoppins(
                                text: "${target ?? 0} Kg",
                                color: MyColors.blackFont(),
                                size: 16,
                                fontWeight: FontWeight.w400,
                                alignment: TextAlign.start,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 56),
                    child: SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          var kaloriDiet = imt.hitungDietKalori(
                            bmrTemp,
                            double.parse(
                              textCalories.text,
                            ),
                          );
                          var lemak = imt.hitungLemakHarian(widget.usia);
                          var karbo = imt.hitungKarbo(kaloriDiet);
                          if (validateAndSave()) {
                            ViewTargetProfile viewTargetProfile =
                                ViewTargetProfile();
                            viewTargetProfile
                                .sendTarget(
                              double.parse(textCalories.text),
                              kaloriDiet,
                              karbo,
                              lemak,
                              target.toString(),
                              14,
                              widget.localId,
                              widget.idToken,
                            )
                                .then((_) {
                              messageDialog.showDialogSuccessProfile(
                                context,
                                widget.localId,
                                widget.idToken,
                                "Tambah Target Pengguna Berhasil, Target turun $target Kg",
                              );
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: btnSave,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        child: const FontPop12w400White(text: "Simpan"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FontPoppins(
                    text:
                        "Tidak sesuai dengan keiginan? ubah pengurangan kalori",
                    color: MyColors.blackFont(),
                    size: 14,
                    fontWeight: FontWeight.w400,
                    alignment: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 56),
                    child: SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            backgroundColor: MyColors.white(),
                            isScrollControlled: true,
                            builder: (context) => Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: MyColors.white(),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  FontPoppins(
                                    text: "Ubah Pengurangan Kalori",
                                    color: MyColors.blackFont(),
                                    size: 16,
                                    fontWeight: FontWeight.w400,
                                    alignment: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  RowCustomTarget(
                                    judul: "Pengurangan Kalori",
                                    widget: TextFormField(
                                      controller: textCalories,
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      // onEditingComplete: () {
                                      // imt
                                      //     .hitungTargetPengguna(
                                      //   textCalories,
                                      //   bmrTemp,
                                      //   context,
                                      // )
                                      //     .then((value) {
                                      //   setState(() {
                                      //     target = value;
                                      //   });
                                      // });
                                      // },
                                      decoration: inputCustom.inputProfile("0"),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    width: size.width,
                                    height: 50,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 48,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        imt
                                            .hitungTargetPengguna(
                                          textCalories,
                                          bmrTemp,
                                          context,
                                        )
                                            .then((value) {
                                          setState(() {
                                            target = value;
                                          });
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColors.red(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: FontPoppins(
                                        text: "Simpan",
                                        color: MyColors.white(),
                                        size: 14,
                                        fontWeight: FontWeight.w400,
                                        alignment: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: btnEdit,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        child: FontPoppins(
                          text: "Ubah Pengurangan Kalori",
                          color: MyColors.white(),
                          size: 12,
                          fontWeight: FontWeight.w400,
                          alignment: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const FontPop14w400BlackItalic(text: "Catatan :"),
                  FontPop12w400Red(text: stringCustom.targetKalori),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
