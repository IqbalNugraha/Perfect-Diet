import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_profile.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/input_custom.dart';
import 'package:skiripsi_app/widget/row_custom.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

class DetailProfileScreen extends StatefulWidget {
  final String userId, name, idToken, activity;
  final int weight, height, age;
  const DetailProfileScreen({
    required this.idToken,
    required this.userId,
    required this.name,
    required this.height,
    required this.weight,
    required this.age,
    required this.activity,
    super.key,
  });

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MessageDialog messageDialog = MessageDialog();
  StringCustom stringCustom = StringCustom();
  InputCustom inputCustom = InputCustom();
  var textHeight = TextEditingController();
  var textWeight = TextEditingController();
  var textName = TextEditingController();
  var textAge = TextEditingController();
  String dropdownValue = "Pilih Aktivitas Harian";
  String holder = "";
  DateTime? _dateTime;
  int? _age;
  Color btnAktif = MyColors.red();
  Color btnNonAktif = MyColors.grey();

  void getDropdownValue() {
    setState(() {
      holder = dropdownValue;
    });
  }

  void _calculateAge() {
    final now = DateTime.now();
    final difference = now.difference(_dateTime!);
    _age = (difference.inDays / 365).floor();
  }

  @override
  void initState() {
    dropdownValue = widget.activity;
    textName.text = widget.name;
    textWeight.text = widget.weight.toString();
    textHeight.text = widget.height.toString();
    _age = widget.age;
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

  void _update(
    String userId,
    String idToken,
    String nama,
    String dropdown,
    int umur,
    int berat,
    int tinggi,
  ) {
    ViewProfile viewProfile = ViewProfile();
    viewProfile.sendProfile(
      userId,
      idToken,
      nama,
      umur,
      berat,
      tinggi,
      dropdown,
    );
    messageDialog.showDialogSuccessProfile(
      context,
      widget.userId,
      widget.idToken,
      "Ubah Data Berhasil",
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.background(),
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: SizedBox(
              width: size.width,
              height: size.height,
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
                        child: const RowCustomToolbar(toolbar: "Profile Kamu"),
                      ),
                      FontPop14w400BlackItalic(
                        text: stringCustom.detailProfileBanner,
                      ),
                      const SizedBox(height: 16),
                      RowCustomTextFieldFull(
                        textEditing: textName,
                        hint: "Nama Lengkap",
                        judul: "Nama Pengguna",
                      ),
                      const SizedBox(height: 16),
                      RowCustomTextField60(
                        textHeight: textHeight,
                        hint: "0",
                        judul: "Tinggi Badan",
                        satuan: "cm",
                      ),
                      const SizedBox(height: 16),
                      RowCustomTextField60(
                        textHeight: textWeight,
                        hint: "0",
                        judul: "Berat Badan",
                        satuan: "Kg",
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: FontPop12w400Semi(text: "Umur"),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                ).then((date) {
                                  setState(() {
                                    _dateTime = date;
                                    _calculateAge();
                                  });
                                });
                              },
                              child: FontPoppins(
                                text: _age != null
                                    ? "$_age Tahun"
                                    : "Pilih Tanggal Lahir",
                                color: MyColors.blackFont(),
                                size: 16,
                                fontWeight: FontWeight.w400,
                                alignment: TextAlign.start,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: SizedBox(
                              width: 100,
                              child:
                                  FontPop12w400Semi(text: "Aktivitas Harian"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            underline: Container(
                              height: 2,
                              color: MyColors.grey(),
                            ),
                            items: stringCustom.activityName
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? data) {
                              setState(() {
                                dropdownValue = data!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: SizedBox(
                          width: size.width,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              if (validateAndSave()) {
                                final progress = ProgressHUD.of(context);
                                progress!.showWithText("Loading...");
                                _update(
                                  widget.userId,
                                  widget.idToken,
                                  textName.text,
                                  dropdownValue,
                                  _age ?? 0,
                                  int.parse(textWeight.text),
                                  int.parse(textHeight.text),
                                );
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    progress.dismiss();
                                  },
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: btnAktif,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const FontPop12w400White(text: "Simpan"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
