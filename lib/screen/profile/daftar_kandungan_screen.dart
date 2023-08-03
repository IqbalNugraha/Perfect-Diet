import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/saved_item.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class DaftarKandunganScreen extends StatefulWidget {
  final String userId;
  const DaftarKandunganScreen({
    required this.userId,
    super.key,
  });

  @override
  State<DaftarKandunganScreen> createState() => _DaftarKandunganScreenState();
}

class _DaftarKandunganScreenState extends State<DaftarKandunganScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Query dbListHistory =
        FirebaseDatabase.instance.ref().child('history').child(widget.userId);

    return Scaffold(
      appBar: AppBar(
        title: FontPoppins(
          text: "History Makanan",
          color: MyColors.white(),
          size: 16,
          fontWeight: FontWeight.w600,
          alignment: TextAlign.start,
        ),
        backgroundColor: MyColors.red(),
      ),
      backgroundColor: MyColors.background(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: MyColors.red(),
                ),
              );
            } else {
              return FirebaseAnimatedList(
                query: dbListHistory,
                itemBuilder: (context, snapshot, animation, i) {
                  Map listSaved = snapshot.value as Map;
                  listSaved['key'] = snapshot.key;                  
                  return SavedItem(savedList: listSaved);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
