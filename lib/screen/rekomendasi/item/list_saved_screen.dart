import 'package:flutter/material.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/saved_item.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class ListSavedScreen extends StatefulWidget {
  final Query dbRef;
  final String judul, userId;
  const ListSavedScreen({
    required this.judul,
    required this.userId,
    required this.dbRef,
    super.key,
  });

  @override
  State<ListSavedScreen> createState() => _ListSavedScreenState();
}

class _ListSavedScreenState extends State<ListSavedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: FontPoppins(
          text: widget.judul,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            FontPoppins(
              text: widget.judul,
              color: MyColors.blackFont(),
              size: 16,
              fontWeight: FontWeight.w400,
              alignment: TextAlign.start,
            ),
            const SizedBox(height: 16),
            Expanded(
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
                  } else if (snap.hasError) {
                    return Align(
                      alignment: Alignment.center,
                      child: FontPoppins(
                        text: "Data Kosong",
                        color: MyColors.blackFont(),
                        size: 16,
                        fontWeight: FontWeight.w400,
                        alignment: TextAlign.center,
                      ),
                    );
                  } else {
                    return FirebaseAnimatedList(
                      query: widget.dbRef,
                      itemBuilder: (context, snapshot, animation, i) {
                        Map listSaved = snapshot.value as Map;
                        listSaved['key'] = snapshot.key;                        
                        return listSaved.isNotEmpty
                            ? SavedItem(savedList: listSaved)
                            : Align(
                                alignment: Alignment.center,
                                child: FontPoppins(
                                  text: "Maaf data kosong",
                                  color: MyColors.blackFont(),
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  alignment: TextAlign.center,
                                ),
                              );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
