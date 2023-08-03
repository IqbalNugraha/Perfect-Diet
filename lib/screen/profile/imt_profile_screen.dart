import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_imt_profile.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/row_custom.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

class IMTProfileScreen extends StatefulWidget {
  final int height, weight, age;
  final String activity, userId, idToken;
  final double bmr, imtLemak, imt;
  const IMTProfileScreen({
    required this.userId,
    required this.idToken,
    required this.activity,
    required this.age,
    required this.height,
    required this.weight,
    required this.bmr,
    required this.imtLemak,
    required this.imt,
    super.key,
  });

  @override
  State<IMTProfileScreen> createState() => _IMTProfileScreenState();
}

class _IMTProfileScreenState extends State<IMTProfileScreen> {
  FunctionIMT functionIMT = FunctionIMT();
  StringCustom stringCustom = StringCustom();
  bool isInit = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      isLoading = true;
      Future.delayed(const Duration(seconds: 2), () {
        var hasilIMT = functionIMT.hitungIMT(widget.weight, widget.height);
        var hasilIMTLemak = functionIMT.hitungIMTLemak(hasilIMT, widget.age);
        var bmrTemp = functionIMT.hitungKalori(
            widget.weight, widget.height, widget.age, widget.activity);
        var validasiIMT = functionIMT.validasiIMT(hasilIMT);
        Provider.of<ViewImtProfile>(context, listen: false).sendIMT(
          bmrTemp,
          hasilIMTLemak,
          hasilIMT,
          widget.userId,
          widget.idToken,
          validasiIMT,
        );
        isLoading = false;
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var dataImtProfile = Provider.of<ViewImtProfile>(context);
    var imtProfile = dataImtProfile.imtProfile;
    var nilaiImt = functionIMT.formatDouble(imtProfile.imt ?? 0, 2);
    var nilaiImtLemak = functionIMT.formatDouble(imtProfile.imtLemak ?? 0, 2);
    var nilaiBMR = functionIMT.formatDouble(imtProfile.bmrKalori ?? 0, 0);
    var hasilIMT = functionIMT.hitungIMT(widget.weight, widget.height);
    var validasiIMT = functionIMT.validasiIMT(hasilIMT);

    return Scaffold(
      backgroundColor: MyColors.background(),
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width,
                  height: 80,
                  child: const RowCustomToolbar(toolbar: "Hitung IMT"),
                ),
                isLoading
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: MyColors.red(),
                          ),
                        ),
                      )
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: _refreshPage,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FontPop18w400Black(
                                    text: "Perhitungan IMT"),
                                const SizedBox(height: 5),
                                Container(
                                  width: size.width,
                                  height: 1,
                                  color: MyColors.grey(),
                                ),
                                const SizedBox(height: 16),
                                FontPop12w400Red(
                                    text: stringCustom.pengertianIMT),
                                const SizedBox(height: 8),
                                RowCustom1(
                                  judul: "Nilai Tinggi Badan",
                                  output: widget.height.toString(),
                                ),
                                const SizedBox(height: 8),
                                RowCustom1(
                                  judul: "Nilai Berat Badan",
                                  output: widget.weight.toString(),
                                ),
                                const SizedBox(height: 8),
                                const FontPop14w400Black(
                                    text: "Nilai IMT yang didapatkan"),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColors.grey(),
                                      ),
                                    ),
                                    child: ColumnCustom(
                                      hasilIMT: nilaiImt,
                                      nilaiIMT: validasiIMT,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const FontPop18w400Black(
                                    text: "Perhitungan IMT Lemak"),
                                const SizedBox(height: 5),
                                Container(
                                  width: size.width,
                                  height: 1,
                                  color: MyColors.grey(),
                                ),
                                const SizedBox(height: 16),
                                FontPop12w400Red(text: stringCustom.imtLemak),
                                const SizedBox(height: 8),
                                RowCustom1(
                                  judul: "Nilai IMT",
                                  output: nilaiImt,
                                ),
                                const SizedBox(height: 8),
                                RowCustom1(
                                  judul: "Usia Pengguna",
                                  output: widget.age.toString(),
                                ),
                                const SizedBox(height: 8),
                                const FontPop14w400Black(
                                    text: "Nilai IMT Lemak yang didapatkan"),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Container(
                                    width: size.width,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColors.grey(),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: FontPop18w600Black(
                                        text: nilaiImtLemak,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const FontPop18w400Black(
                                    text: "Perhitungan BMR Kalori"),
                                const SizedBox(height: 5),
                                Container(
                                  width: size.width,
                                  height: 1,
                                  color: MyColors.grey(),
                                ),
                                const SizedBox(height: 16),
                                FontPop12w400Red(text: stringCustom.bmrKalori),
                                const SizedBox(height: 8),
                                RowCustom1(
                                  judul: "Aktivitas Pengguna",
                                  output: widget.activity,
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Container(
                                    width: size.width,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColors.grey(),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: FontPop18w600Black(
                                        text: nilaiBMR,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )),
    );
  }

  Future<void> _refreshPage() async {
    setState(() {
      Provider.of<ViewImtProfile>(context, listen: false).fetchIMT(
        widget.userId,
        widget.idToken,
      );
    });
  }
}
