import 'package:flutter/material.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/input_custom.dart';
import 'package:skiripsi_app/widget/row_custom.dart';
import 'package:skiripsi_app/widget/logic/logic_profile.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

class DialogProfile extends StatefulWidget {
  final String userId, idToken;
  final int day, cal, age;
  final double bmrCal, result;
  const DialogProfile({
    required this.userId,
    required this.idToken,
    required this.cal,
    required this.bmrCal,
    required this.day,
    required this.result,
    required this.age,
    super.key,
  });

  @override
  State<DialogProfile> createState() => _DialogProfileState();
}

class _DialogProfileState extends State<DialogProfile> {
  final FocusNode _focusNode = FocusNode();
  InputCustom inputCustom = InputCustom();
  LogicProfile logicProfile = LogicProfile();
  StringCustom stringCustom = StringCustom();
  var txtCal = TextEditingController();
  double? target;
  double height = 550;
  String dropdownValue = "7 Hari";
  String holder = "";

  @override
  void initState() {
    txtCal.text = widget.cal.toString();
    dropdownValue = logicProfile.targetHari(widget.day);
    target = widget.result;
    super.initState();
  }

  void _onEditingComplete() {
    setState(() {
      height = 350;
      Future.delayed(const Duration(seconds: 1), () {
        logicProfile
            .hitungTargetPengguna(
          txtCal,
          widget.bmrCal,
          dropdownValue,
          context,
        )
            .then((value) {
          setState(() {
            target = value;
          });
        });
      });
    });
    _focusNode.unfocus();
  }

  void _onTap() {
    setState(() {
      height = 550;
    });
  }

  void getDropdownValue() {
    setState(() {
      holder = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      width: size.width,
      height: height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              FontPoppins(
                text: "Ubah Pengurangan Kalori",
                color: MyColors.blackFont(),
                size: 16,
                fontWeight: FontWeight.w600,
                alignment: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RowCustomTarget(
                judul: "Pengurangan Kalori",
                widget: TextFormField(
                  controller: txtCal,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  onEditingComplete: _onEditingComplete,
                  onTap: _onTap,
                  focusNode: _focusNode,
                  autofocus: true,
                  decoration: inputCustom.inputProfile("0"),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    items: stringCustom.targetHari
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? data) {
                      setState(() {
                        dropdownValue = data!;
                        Future.delayed(const Duration(seconds: 1), () {
                          logicProfile
                              .hitungTargetPengguna(
                            txtCal,
                            widget.bmrCal,
                            dropdownValue,
                            context,
                          )
                              .then((value) {
                            setState(() {
                              target = value;
                            });
                          });
                        });
                      });
                    },
                  ),
                ],
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                            text: "${target?.toStringAsFixed(2) ?? 0} Kg",
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
              Container(
                width: size.width,
                height: 50,
                margin: const EdgeInsets.symmetric(
                  horizontal: 48,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    logicProfile.updateTarget(
                      double.parse(txtCal.text),
                      widget.bmrCal,
                      target?.toStringAsFixed(2) ?? "0",
                      logicProfile.parseTargetHari(dropdownValue),
                      widget.age,
                      widget.userId,
                      widget.idToken,
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.red(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }
}
