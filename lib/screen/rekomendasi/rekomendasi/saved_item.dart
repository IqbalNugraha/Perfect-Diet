import 'package:flutter/material.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/convert_image.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/row_custom.dart';

class SavedItem extends StatefulWidget {
  final Map savedList;
  const SavedItem({
    required this.savedList,
    super.key,
  });

  @override
  State<SavedItem> createState() => _SavedItemState();
}

class _SavedItemState extends State<SavedItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: MyColors.white()),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: ConvertImage(
                    base64Image: widget.savedList['img_url'],
                  )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 11, right: 16),
                    child: FontPoppins(
                      text: widget.savedList['nama_makanan'],
                      color: MyColors.blackFont(),
                      size: 16,
                      fontWeight: FontWeight.w400,
                      alignment: TextAlign.start,
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
                    judul: "Kadar Kalori",
                    output: "${widget.savedList['cal']} Kkal",
                  ),
                  RowCustom1(
                    judul: "Kadar Lemak",
                    output: "${widget.savedList['fat']} g",
                  ),
                  RowCustom1(
                    judul: "Kadar Karbohidrat",
                    output: "${widget.savedList['carb']} g",
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
