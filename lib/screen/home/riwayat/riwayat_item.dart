import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skiripsi_app/utility/warna.dart';

class RiwayatItem extends StatefulWidget {
  const RiwayatItem({Key? key}) : super(key: key);

  @override
  State<RiwayatItem> createState() => _RiwayatItemState();
}

class _RiwayatItemState extends State<RiwayatItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: MyColors.white(),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 2),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              child: Image.asset(
                "assets/jpg/ayam_goreng.jpeg",
                width: 120,
                height: 188,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 7),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Ayam Goreng",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: MyColors.semiBlack(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Kadar Lemak",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: MyColors.semiBlack(),
                  ),
                ),
                const Text(":"),
                Text(
                  "15 gr",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: MyColors.semiBlack(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
