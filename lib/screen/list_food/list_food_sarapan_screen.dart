// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:skiripsi_app/provider/rekomendasi/model/model_list_saved.dart';
// import 'package:skiripsi_app/provider/rekomendasi/view_model/view_list_saved.dart';
// import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/rekomendasi_item.dart';
// import 'package:skiripsi_app/utility/warna.dart';
// import 'package:skiripsi_app/widget/font_custom.dart';

// class ListSavedBreakfast extends StatefulWidget {
//   final String userId, idToken;
//   const ListSavedBreakfast({
//     required this.userId,
//     required this.idToken,
//     super.key,
//   });

//   @override
//   State<ListSavedBreakfast> createState() => _ListSavedBreakfastState();
// }

// class _ListSavedBreakfastState extends State<ListSavedBreakfast> {
//   late Future<List<ListSaved>> futureListBreakfast;
//   ViewListSaved viewListSaved = ViewListSaved();

//   @override
//   void initState() {
//     futureListBreakfast = viewListSaved.fetchListFood(
//       widget.userId,
//       widget.idToken,
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: MyColors.background(),
//       body: SizedBox(
//         width: size.width,
//         height: size.height,
//         child: FutureBuilder<List<ListSaved>>(
//           future: futureListBreakfast,
//           builder: ((context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 padding: const EdgeInsets.only(top: 16),
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (ctx, i) {
//                   return RekomendasiItem(
//                     id: snapshot.data?[i].id ?? 0,
//                     name: snapshot.data?[i].title ?? "",
//                     img: snapshot.data?[i].imgUrl ?? "",
//                     fat: snapshot.data?[i].lemak ?? 0,
//                     calories: snapshot.data?[i].kalori ?? 0,
//                     carb: snapshot.data?[i].karbo ?? 0,
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: FontPoppins(
//                   text: snapshot.error.toString(),
//                   color: MyColors.blackFont(),
//                   size: 16,
//                   fontWeight: FontWeight.w400,
//                   alignment: TextAlign.center,
//                 ),
//               );
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: MyColors.red(),
//                 ),
//               );
//             }
//           }),
//         ),
//       ),
//     );
//   }
// }
