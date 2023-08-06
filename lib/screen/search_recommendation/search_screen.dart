import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/rekomendasi.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_rekomendasi.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/rekomendasi_item.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/string_custom.dart';
import 'package:skiripsi_app/widget/user_toolbar.dart';

class SearchScreen extends StatefulWidget {
  final String name, userId, idToken;
  const SearchScreen({
    required this.name,
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final txtSearch = TextEditingController();
  FunctionIMT functionIMT = FunctionIMT();
  DateTime currentBackPressTime = DateTime.now();
  StringCustom stringCustom = StringCustom();
  List<RekomendasiBreakfast>? result;
  bool isValid = false;
  bool isLoading = false;
  String? message;
  int? nutrisiCal,
      nutrisiCarb,
      nutrisiFat,
      sarapanValue,
      makanSiangValue,
      makanMalamValue,
      camilanValue,
      carbMax,
      fatMax;

  @override
  void initState() {
    isValid = true;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ViewPolaMakan>(context, listen: false)
          .fetchTablePolaMakan(
        widget.userId,
        widget.idToken,
      )
          .then((value) {
        setState(() {
          sarapanValue = value.sarapan;
          makanSiangValue = value.makanSiang;
          makanMalamValue = value.makanMalam;
          camilanValue = value.ngemil;
          sarapanValue = value.sarapan;
          carbMax = value.carb;
          fatMax = value.fat;
          Provider.of<ViewPolaMakan>(context, listen: false)
              .fetchNutrisiPolaMakan(
            widget.userId,
            widget.idToken,
          )
              .then((value) {
            setState(() {
              nutrisiCal = value.cal;
              nutrisiFat = value.fat;
              nutrisiCarb = value.carb;
              var recentCal = (((sarapanValue ?? 0) +
                      (makanSiangValue ?? 0) +
                      (makanMalamValue ?? 0)) -
                  (nutrisiCal ?? 0));
              var recentFat = (fatMax ?? 0) - (nutrisiFat ?? 0);
              var recentCarb = (carbMax ?? 0) - (nutrisiCarb ?? 0);
              Provider.of<ViewRekomendasi>(context, listen: false)
                  .fetchMainCourse(
                recentCarb,
                recentFat,
                recentCal,
              )
                  .then((value) {
                setState(() {
                  result = value.result;
                  message = value.message;
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      isLoading = false;
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
    super.initState();
  }

  void _search(String query, int maxCarb, int maxFat, int maxCalories) {
    setState(() {
      isLoading = true;
      Provider.of<ViewRekomendasi>(context, listen: false)
          .fetchSearch(maxCarb, maxFat, maxCalories, query)
          .then((response) {
        if (response.result!.isNotEmpty) {
          setState(() {
            isValid = false;
            result = response.result;
            message = response.message;
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                isLoading = false;
              });
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.background(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: 130,
                  decoration: BoxDecoration(
                    color: MyColors.red(),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 52, left: 23),
                  child: UserToolbar(name: widget.name),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: size.width,
                height: 50,
                child: TextFormField(
                  controller: txtSearch,
                  onChanged: (String text) {
                    Future.delayed(const Duration(seconds: 3), () {
                      _search(text, nutrisiCarb ?? 0, nutrisiFat ?? 0,
                          nutrisiCal ?? 0);
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyColors.red(),
                    ),
                    hintText: "Cari makanan?",
                    contentPadding: const EdgeInsets.all(0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: MyColors.red(),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: MyColors.red(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<ViewRekomendasi>(
              builder: (context, viewRekomendasi, _) {
                if (viewRekomendasi.state == ClassViewRekomendasi.loading) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyColors.red(),
                      ),
                    ),
                  );
                } else if (viewRekomendasi.state ==
                    ClassViewRekomendasi.error) {
                  return const Expanded(
                    child: Center(
                      child: FontPop16w400Black(
                        text: "Maaf, data error",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (viewRekomendasi.state ==
                    ClassViewRekomendasi.empty) {
                  return const Expanded(
                    child: Center(
                      child: FontPop16w400Black(
                        text: "Maaf, data kosong",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  return isValid
                      ? isLoading
                          ? Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.red(),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: result?.length,
                                  itemBuilder: (ctx, i) {
                                    return RekomendasiItem(
                                      id: result?[i].id ?? 0,
                                      name: result?[i].title ?? "",
                                      img: result?[i].image ?? "",
                                      fat: result?[i]
                                              .nutrition
                                              ?.nutrients?[1]
                                              .amount ??
                                          0,
                                      calories: result?[i]
                                              .nutrition
                                              ?.nutrients?[0]
                                              .amount ??
                                          0,
                                      carb: result?[i]
                                              .nutrition
                                              ?.nutrients?[2]
                                              .amount ??
                                          0,
                                      breakfastValue: sarapanValue ?? 0,
                                      lunchValue: makanSiangValue ?? 0,
                                      dinnerValue: makanMalamValue ?? 0,
                                      snackValue: camilanValue ?? 0,
                                      carbMax: carbMax ?? 0,
                                      fatMax: fatMax ?? 0,
                                      nutrisiCal: nutrisiCal ?? 0,
                                      nutrisiFat: nutrisiFat ?? 0,
                                      nutrisiCarb: nutrisiCarb ?? 0,
                                      idToken: widget.idToken,
                                      userId: widget.userId,
                                    );
                                  },
                                ),
                              ),
                            )
                      : isLoading
                          ? Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.red(),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: result?.length,
                                  itemBuilder: (ctx, i) {
                                    return RekomendasiItem(
                                      id: result?[i].id ?? 0,
                                      name: result?[i].title ?? "",
                                      img: result?[i].image ?? "",
                                      fat: result?[i]
                                              .nutrition
                                              ?.nutrients?[1]
                                              .amount ??
                                          0,
                                      calories: result?[i]
                                              .nutrition
                                              ?.nutrients?[0]
                                              .amount ??
                                          0,
                                      carb: result?[i]
                                              .nutrition
                                              ?.nutrients?[2]
                                              .amount ??
                                          0,
                                      breakfastValue: sarapanValue ?? 0,
                                      lunchValue: makanSiangValue ?? 0,
                                      dinnerValue: makanMalamValue ?? 0,
                                      snackValue: camilanValue ?? 0,
                                      carbMax: carbMax ?? 0,
                                      fatMax: fatMax ?? 0,
                                      nutrisiCal: nutrisiCal ?? 0,
                                      nutrisiFat: nutrisiFat ?? 0,
                                      nutrisiCarb: nutrisiCarb ?? 0,
                                      idToken: widget.idToken,
                                      userId: widget.userId,
                                    );
                                  },
                                ),
                              ),
                            );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
