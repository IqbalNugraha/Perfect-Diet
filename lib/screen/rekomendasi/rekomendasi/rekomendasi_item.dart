import 'package:flutter/material.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/detail_rekomendasi_screen.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/row_custom.dart';

class RekomendasiItem extends StatefulWidget {
  final int id,
      breakfastValue,
      lunchValue,
      dinnerValue,
      snackValue,
      fatMax,
      carbMax,
      nutrisiCal,
      nutrisiFat,
      nutrisiCarb;
  final String name, img, userId, idToken;
  final double calories, fat, carb;

  const RekomendasiItem({
    required this.id,
    required this.name,
    required this.img,
    required this.fat,
    required this.calories,
    required this.carb,
    required this.breakfastValue,
    required this.lunchValue,
    required this.dinnerValue,
    required this.snackValue,
    required this.fatMax,
    required this.carbMax,
    required this.nutrisiCal,
    required this.nutrisiFat,
    required this.nutrisiCarb,
    required this.userId,
    required this.idToken,    
    Key? key,
  }) : super(key: key);

  @override
  State<RekomendasiItem> createState() => _RekomendasiItemState();
}

class _RekomendasiItemState extends State<RekomendasiItem> {
  FunctionIMT functionIMT = FunctionIMT();
  MessageDialog messageDialog = MessageDialog();

  @override
  void initState() {
    super.initState();
  }

  void _showModalBottom(
    String title,
    String imgUrl,
    String userId,
    String idToken,
    int calValue,
    int fatValue,
    int carbValue,
    int breakfastValue,
    int lunchValue,
    int dinnerValue,
    int snackValue,
    int fatMax,
    int carbMax,
    int nutrisiCal,
    int nutrisiFat,
    int nutrisiCarb,
  ) async {
    return await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      backgroundColor: MyColors.white(),
      isScrollControlled: true,
      builder: (context) {
        return DialogPolaMakan(
          title: title,
          imgUrl: imgUrl,
          calValue: calValue,
          carbValue: carbValue,
          fatValue: fatValue,
          userId: userId,
          idToken: idToken,
          breakfastValue: breakfastValue,
          lunchValue: lunchValue,
          dinnerValue: dinnerValue,
          fatMax: fatMax,
          carbMax: carbMax,
          nutrisiCal: nutrisiCal,
          nutrisiCarb: nutrisiCarb,
          nutrisiFat: nutrisiFat,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailRekomendasi(
                id: widget.id,
                title: widget.name,
                image: widget.img,
              ),
            ),
          );
        },
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.white(),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  widget.img,
                  height: 133,
                  width: 81,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/png/error_image.png",
                      height: 133,
                      width: 81,
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 11, right: 16),
                      child: FontPop14w600Black(
                        text: widget.name,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        height: 1,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: MyColors.blackFont(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    RowCustom1(
                      judul: "Kadar Lemak",
                      output: "${functionIMT.formatDouble(widget.fat, 0)} g",
                    ),
                    RowCustom1(
                      judul: "Kadar Kalori",
                      output: "${functionIMT.formatDouble(
                        widget.calories,
                        0,
                      )} Kkal",
                    ),
                    RowCustom1(
                      judul: "Kadar Karbohidrat",
                      output: "${functionIMT.formatDouble(widget.carb, 0)} g",
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SizedBox(
                          width: 60,
                          height: 25,
                          child: ElevatedButton(
                            onPressed: () {
                              _showModalBottom(
                                widget.name,
                                widget.img,
                                widget.userId,
                                widget.idToken,
                                widget.calories.toInt(),
                                widget.fat.toInt(),
                                widget.carb.toInt(),
                                widget.breakfastValue,
                                widget.lunchValue,
                                widget.dinnerValue,
                                widget.snackValue,
                                widget.fatMax,
                                widget.carbMax,
                                widget.nutrisiCal,
                                widget.nutrisiFat,
                                widget.nutrisiCarb,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.red(),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            child: const FontPop10w400White(
                              text: "Pilih",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
