import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_profile.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/input_custom.dart';
import 'package:skiripsi_app/widget/row_custom.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

class NewProfileScren extends StatefulWidget {
  final String localId, idToken;
  const NewProfileScren({
    required this.idToken,
    required this.localId,
    super.key,
  });

  @override
  State<NewProfileScren> createState() => _NewProfileScrenState();
}

class _NewProfileScrenState extends State<NewProfileScren> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MessageDialog messageDialog = MessageDialog();
  StringCustom stringCustom = StringCustom();
  InputCustom inputCustom = InputCustom();
  FunctionIMT imt = FunctionIMT();
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

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.background(),
      body: Form(
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
                  const SizedBox(height: 70),
                  const FontPop20w600Black(text: "Profile Kamu"),
                  const SizedBox(height: 8),
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
                              lastDate: DateTime(2099),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: SizedBox(
                          width: 100,
                          child: FontPop12w400Semi(text: "Aktivitas Harian"),
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
                          ViewProfile viewProfile = ViewProfile();
                          viewProfile.sendProfile(
                            widget.localId,
                            widget.idToken,
                            textName.text,
                            _age ?? 0,
                            int.parse(textWeight.text),
                            int.parse(textHeight.text),
                            dropdownValue,
                          );
                          messageDialog.showDialogSuccessAuth(
                            context,
                            widget.idToken,
                            widget.localId,
                            "Data Anda Telah Tersimpan",
                          );
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
    );
  }
}
