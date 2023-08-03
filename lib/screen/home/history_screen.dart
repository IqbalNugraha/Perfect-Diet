// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:skiripsi_app/provider/daftar_makanan/model/model_daftar_makanan.dart';
// import 'package:skiripsi_app/provider/daftar_makanan/view_model/view_daftar_makanan.dart';
// import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/rekomendasi_item.dart';
// import 'package:skiripsi_app/screen/home/riwayat/riwayat_item.dart';
// import 'package:skiripsi_app/utility/warna.dart';
// import 'package:skiripsi_app/widget/font_custom.dart';
// import 'package:skiripsi_app/widget/hitung_imt.dart';
// import 'package:skiripsi_app/widget/row_custom.dart';
// import 'package:skiripsi_app/widget/user_toolbar.dart';

// class HistoryScreen extends StatefulWidget {
//   final String name;
//   final int usia;
//   final String userId;
//   final String idToken;
//   const HistoryScreen({
//     required this.usia,
//     required this.name,
//     required this.userId,
//     required this.idToken,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }

// class _HistoryScreenState extends State<HistoryScreen> {
//   var _isInit = true;
//   var _isLoading = false;
//   late Future<List<ModelListFood>> futureListFood;
//   ViewListFood viewListFood = ViewListFood();
//   FunctionIMT imt = FunctionIMT();

//   @override
//   void initState() {
//     super.initState();
//     futureListFood = viewListFood.fetchListFood();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final dataFood = Provider.of<ViewListFood>(context);
//     var lemakMaks = imt.hitungLemakHarian(widget.usia);

//     return Scaffold(
//       backgroundColor: MyColors.background(),
//       body: SizedBox(
//         width: size.width,
//         height: size.height,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   width: size.width,
//                   height: 170,
//                   decoration: BoxDecoration(
//                     color: MyColors.red(),
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(20),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 52, left: 23),
//                   child: UserToolbar(name: widget.name),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 125, left: 27, right: 27),
//                   child: Container(
//                     width: size.width,
//                     height: 110,
//                     decoration: BoxDecoration(
//                       color: MyColors.white(),
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.black38,
//                             spreadRadius: 0,
//                             blurRadius: 10),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const SizedBox(height: 5),
//                           Text(
//                             "Recap Per Hari Ini",
//                             style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 22,
//                               color: MyColors.blackFont(),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 6),
//                             child: Container(
//                               width: size.width,
//                               height: 1,
//                               decoration: BoxDecoration(
//                                 color: MyColors.semiBlack(),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           RowCustom2(
//                             judul: "Kadar Lemak Maksimal",
//                             output: "${lemakMaks.toString()} gr",
//                           ),
//                           const SizedBox(height: 10),
//                           const RowCustom2(
//                               judul: "Kadar Lemak yang Masuk",
//                               output: "100 gr"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: FontPop16w600Black(
//                         text: "Riwayat Makanan yang Masuk",
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 21),
//                       child: Align(
//                         alignment: AlignmentDirectional.centerEnd,
//                         child: SizedBox(
//                           width: 100,
//                           height: 30,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: MyColors.red(),
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                               ),
//                             ),
//                             child: const FontPop10w400White(
//                               text: "Lihat Semua",
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: SizedBox(
//                         height: 242,
//                         child: ListView.builder(
//                           itemCount: 3,
//                           itemBuilder: (ctx, i) {
//                             return const RiwayatItem();
//                           },
//                           scrollDirection: Axis.horizontal,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: FontPop16w600Black(
//                         text: "Rekomendasi Makanan",
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 21),
//                       child: Align(
//                         alignment: AlignmentDirectional.centerEnd,
//                         child: SizedBox(
//                           width: 100,
//                           height: 30,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: MyColors.red(),
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                               ),
//                             ),
//                             child: const FontPop10w400White(
//                               text: "Lihat Semua",
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: SizedBox(
//                         width: size.width,
//                         height: 700,
//                         child: FutureBuilder<List<ModelListFood>>(
//                             future: futureListFood,
//                             builder: (ctx, snapshot) {
//                               if (snapshot.hasData) {
//                                 return ListView.builder(
//                                   padding: EdgeInsets.zero,
//                                   itemCount: 4,
//                                   itemBuilder: (ctx, i) {
//                                     return RekomendasiItem(
//                                       id: snapshot.data![i].id!,
//                                       name: snapshot.data![i].title!,
//                                       img: snapshot.data![i].img!,
//                                       fat: snapshot.data![i].fat!,
//                                       calories: snapshot.data![i].calories!,
//                                       carb: snapshot.data![i].carbs!,
//                                     );
//                                   },
//                                 );
//                               } else {
//                                 return Center(
//                                   child: CircularProgressIndicator(
//                                     color: MyColors.red(),
//                                   ),
//                                 );
//                               }
//                             }),
//                       ),
//                     ),
//                     const SizedBox(height: 50),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
