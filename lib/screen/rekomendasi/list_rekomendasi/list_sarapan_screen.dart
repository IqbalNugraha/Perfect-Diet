import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/rekomendasi.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_rekomendasi.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/rekomendasi_item.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';

class ListSarapan extends StatefulWidget {
  final String userId, idToken;
  const ListSarapan({
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<ListSarapan> createState() => _ListSarapanState();
}

class _ListSarapanState extends State<ListSarapan> {
  List<RekomendasiBreakfast>? result;
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
                  .fetchBreakfast(
                recentCarb,
                recentFat,
                recentCal,
              )
                  .then((value) {
                setState(() {
                  result = value.result;
                  message = value.message;
                });
              });
            });
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.background(),
      body: Consumer<ViewRekomendasi>(
        builder: (context, viewRekomendasi, _) {
          if (viewRekomendasi.state == ClassViewRekomendasi.loading) {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: MyColors.red(),
                  ),
                  const SizedBox(height: 8),
                  const FontPop14w400Black(text: "Loading")
                ],
              ),
            );
          } else if (viewRekomendasi.state == ClassViewRekomendasi.empty) {
            return const Center(
              child: FontPop16w400Black(
                text: "Data Kosong",
                textAlign: TextAlign.center,
              ),
            );
          } else if (viewRekomendasi.state == ClassViewRekomendasi.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FontPop16w400Black(
                  text: message ?? "",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              color: MyColors.red(),
              onRefresh: _pullRefresh,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.center,
                      child: FontPop16w400Black(
                        text: "Daftar Rekomendasi Makanan",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: result?.length,
                        itemBuilder: (context, i) {
                          return RekomendasiItem(
                            id: result?[i].id ?? 0,
                            name: result?[i].title ?? "",
                            img: result?[i].image ?? "",
                            fat:
                                result?[i].nutrition?.nutrients?[1].amount ?? 0,
                            calories:
                                result?[i].nutrition?.nutrients?[0].amount ?? 0,
                            carb:
                                result?[i].nutrition?.nutrients?[2].amount ?? 0,
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
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      Provider.of<ViewRekomendasi>(context, listen: false).fetchBreakfast(
        nutrisiCarb ?? 0,
        nutrisiFat ?? 0,
        nutrisiCal ?? 0,
      );
    });
  }
}
