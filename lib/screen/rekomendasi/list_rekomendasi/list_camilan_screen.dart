import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_rekomendasi.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/rekomendasi_item.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/rekomendasi.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';

class ListCamilan extends StatefulWidget {
  final String userId, idToken;
  final int maxCarb, maxFat, maxCalories;
  const ListCamilan({
    required this.maxCalories,
    required this.maxCarb,
    required this.maxFat,
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<ListCamilan> createState() => _ListCamilanState();
}

class _ListCamilanState extends State<ListCamilan> {
  List<RekomendasiBreakfast>? result;
  String? message;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ViewRekomendasi>(context, listen: false)
          .fetchSnack(
        widget.maxCarb,
        widget.maxFat,
        widget.maxCalories,
      )
          .then((value) {
        setState(() {
          result = value.result;
          message = value.message;
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
                  const FontPop14w400Black(
                    text: "Mohon Tunggu, Sedang Memuat Makanan",
                  ),
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
            return const Center(
              child: FontPop16w400Black(
                text: "Daftar Rekomendasi Tidak Tersedia",
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return RefreshIndicator(
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
                        text: "Daftar Rekomendasi Camilan",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: result!.length,
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
      Provider.of<ViewRekomendasi>(context, listen: false).fetchSnack(
        widget.maxCarb,
        widget.maxFat,
        widget.maxCalories,
      );
    });
  }
}
