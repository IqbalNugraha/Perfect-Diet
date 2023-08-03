import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/profile/model/pola_makan.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/logic/logic_method.dart';
import 'package:skiripsi_app/widget/row_custom.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

class PolaProfileScreen extends StatefulWidget {
  final double ngemil, calories;
  final int carb, fat;
  final String userId, idToken, hasilIMT, username;
  const PolaProfileScreen({
    required this.calories,
    required this.ngemil,
    required this.carb,
    required this.fat,
    required this.userId,
    required this.idToken,
    required this.hasilIMT,
    required this.username,
    super.key,
  });

  @override
  State<PolaProfileScreen> createState() => _PolaProfileScreenState();
}

class _PolaProfileScreenState extends State<PolaProfileScreen> {
  StringCustom stringCustom = StringCustom();
  MessageDialog messageDialog = MessageDialog();
  LogicMethod logicMethod = LogicMethod();
  FunctionIMT function = FunctionIMT();
  int? sarapanValue, makanSiangValue, makanMalamValue, ngemilValue;
  List<ListTablePola>? list;
  String selectedSnack = "Tidak Ngemil";
  bool isValid = false;

  void _handleSnackChange(String? value) {
    setState(() {
      isValid = false;
      selectedSnack = value!;
      var ngemil = function.convertNgemil(selectedSnack);
      logicMethod
          .sendTablePolaMakan(widget.calories, ngemil, widget.fat, widget.carb,
              widget.hasilIMT, widget.userId, widget.idToken, context)
          .then((_) {
        Provider.of<ViewPolaMakan>(context, listen: false)
            .fetchTablePolaMakan(widget.userId, widget.idToken)
            .then((value) {
          setState(() {
            sarapanValue = value.sarapan;
            makanSiangValue = value.makanSiang;
            makanMalamValue = value.makanMalam;
            ngemilValue = value.ngemil;
          });
        });
      });
    });
  }

  @override
  void initState() {
    isValid = true;
    var ngemil = function.convertNgemilToText(widget.ngemil);
    selectedSnack = ngemil;
    if (widget.username != "") {
      logicMethod
          .sendTablePolaMakan(
              widget.calories,
              widget.ngemil,
              widget.fat,
              widget.carb,
              widget.hasilIMT,
              widget.userId,
              widget.idToken,
              context)
          .then((_) {
        Provider.of<ViewPolaMakan>(context, listen: false)
            .fetchTablePolaMakan(widget.userId, widget.idToken)
            .then((value) {
          setState(() {
            sarapanValue = value.sarapan;
            makanSiangValue = value.makanSiang;
            makanMalamValue = value.makanMalam;
            ngemilValue = value.ngemil;
          });
        });
      });
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<ViewPolaMakan>(context, listen: false)
            .fetchListPola()
            .then((value) {
          setState(() {
            list = value;
          });
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: FontPoppins(
          text: "Pola Makan",
          color: MyColors.white(),
          size: 16,
          fontWeight: FontWeight.w600,
          alignment: TextAlign.start,
        ),
        backgroundColor: MyColors.red(),
      ),
      backgroundColor: MyColors.background(),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: MyColors.white(),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FontPoppins(
                    text: "Kebutuhan Tambahan",
                    color: MyColors.blackFont(),
                    size: 16,
                    fontWeight: FontWeight.w600,
                    alignment: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 1,
              width: size.width,
              color: MyColors.grey(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FontPoppins(
                      text: "Data Pola Makan Pengguna",
                      color: MyColors.blackFont(),
                      size: 16,
                      fontWeight: FontWeight.w600,
                      alignment: TextAlign.start,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: size.width,
                      child: FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 2)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: MyColors.red(),
                              ),
                            );
                          } else {
                            return SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 16,
                                border: TableBorder.all(
                                  width: 1,
                                  color: MyColors.blackFont(),
                                ),
                                columns: const [
                                  DataColumn(
                                      label: TextColumn(
                                    label: "Nama",
                                    textAlign: TextAlign.center,
                                  )),
                                  DataColumn(
                                      label: TextColumn(
                                    label: "Sarapan",
                                    textAlign: TextAlign.center,
                                  )),
                                  DataColumn(
                                      label: TextColumn(
                                    label: "Makan Siang",
                                    textAlign: TextAlign.center,
                                  )),
                                  DataColumn(
                                      label: TextColumn(
                                    label: "Makan Malam",
                                    textAlign: TextAlign.center,
                                  )),
                                  DataColumn(
                                      label: TextColumn(
                                    label: "Camilan",
                                    textAlign: TextAlign.center,
                                  )),
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell(SizedBox(
                                      width: 70,
                                      child: TextColumn(
                                        label: widget.username,
                                        textAlign: TextAlign.start,
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextColumn(
                                        label:
                                            "${isValid ? sarapanValue : sarapanValue} Kkal",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextColumn(
                                        label:
                                            "${isValid ? makanSiangValue : makanSiangValue} Kkal",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextColumn(
                                        label:
                                            "${isValid ? makanMalamValue : makanMalamValue} Kkal",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextColumn(
                                        label:
                                            "${isValid ? ngemilValue : ngemilValue} Kkal",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                  ]),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    FontPoppins(
                      text: "Daftar Tabel Pola Makan",
                      color: MyColors.blackFont(),
                      size: 16,
                      fontWeight: FontWeight.w600,
                      alignment: TextAlign.start,
                    ),
                    const SizedBox(height: 16),
                    Consumer<ViewPolaMakan>(
                      builder: (context, viewPolaMakan, _) {
                        if (viewPolaMakan.state == ClassViewPola.loading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: MyColors.red(),
                            ),
                          );
                        } else if (viewPolaMakan.state == ClassViewPola.error) {
                          return Center(
                            child: FontPoppins(
                              text: "Terjadi Kesalahan",
                              color: MyColors.blackFont(),
                              size: 16,
                              fontWeight: FontWeight.w400,
                              alignment: TextAlign.center,
                            ),
                          );
                        } else {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 16,
                              border: TableBorder.all(
                                width: 1,
                                color: MyColors.blackFont(),
                              ),
                              columns: const [
                                DataColumn(
                                    label: TextColumn(
                                  label: "Hasil IMT",
                                  textAlign: TextAlign.center,
                                )),
                                DataColumn(
                                    label: TextColumn(
                                  label: "Sarapan",
                                  textAlign: TextAlign.center,
                                )),
                                DataColumn(
                                    label: TextColumn(
                                  label: "Makan Siang",
                                  textAlign: TextAlign.center,
                                )),
                                DataColumn(
                                    label: TextColumn(
                                  label: "Makan Malam",
                                  textAlign: TextAlign.center,
                                )),
                                DataColumn(
                                    label: TextColumn(
                                  label: "Camilan",
                                  textAlign: TextAlign.center,
                                )),
                              ],
                              rows: List.generate(list?.length ?? 0, (i) {
                                final imtValue = list?[i].imtValue ?? "";
                                final sarapanValue = list?[i].sarapan ?? 0;
                                final makanSiangValue =
                                    list?[i].makanSiang ?? 0;
                                final makanMalamValue =
                                    list?[i].makanMalam ?? 0;
                                final ngemilValue = list?[i].ngemil ?? 0;
                                return DataRow(
                                  cells: [
                                    DataCell(SizedBox(
                                      width: 120,
                                      child: TextColumn(
                                        label: imtValue,
                                        textAlign: TextAlign.start,
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextColumn(
                                        label: "$sarapanValue Kkal",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextColumn(
                                        label: "$makanSiangValue Kkal",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextColumn(
                                        label: "$makanMalamValue Kkal",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextColumn(
                                        label: "$ngemilValue Kkal",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                  ],
                                );
                              }),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
