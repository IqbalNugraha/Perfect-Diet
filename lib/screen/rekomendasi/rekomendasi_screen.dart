import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/screen/rekomendasi/list_rekomendasi/list_camilan_screen.dart';
import 'package:skiripsi_app/screen/rekomendasi/list_rekomendasi/list_makan_malam_screen.dart';
import 'package:skiripsi_app/screen/rekomendasi/list_rekomendasi/list_makan_siang_screen.dart';
import 'package:skiripsi_app/screen/rekomendasi/list_rekomendasi/list_sarapan_screen.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/string_custom.dart';
import 'package:skiripsi_app/widget/user_toolbar.dart';
import 'package:google_fonts/google_fonts.dart';

class RekomendasiScreen extends StatefulWidget {
  final String name, userId, idToken;
  const RekomendasiScreen({
    required this.name,
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<RekomendasiScreen> createState() => _RekomendasiScreenState();
}

class _RekomendasiScreenState extends State<RekomendasiScreen> {
  FunctionIMT functionIMT = FunctionIMT();
  DateTime currentBackPressTime = DateTime.now();
  StringCustom stringCustom = StringCustom();
  int? breakfast, lunch, dinner, snack, fat, carb;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ViewPolaMakan>(context, listen: false)
          .fetchTablePolaMakan(
        widget.userId,
        widget.idToken,
      )
          .then((value) {
        setState(() {
          isLoading = false;
          breakfast = value.sarapan;
          lunch = value.makanSiang;
          dinner = value.makanMalam;
          snack = value.ngemil;
          fat = value.fat;
          carb = value.carb;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: MyColors.background(),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: WillPopScope(
            onWillPop: onWillPop,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: MyColors.red(),
                    ),
                  )
                : Consumer<ViewPolaMakan>(
                    builder: (context, viewPola, _) {
                      if (viewPola.state == ClassViewPola.loading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MyColors.red(),
                          ),
                        );
                      } else if (viewPola.state == ClassViewPola.error) {
                        return Center(
                          child: FontPop16w400Black(
                            text: stringCustom.errorRecommendation,
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  padding:
                                      const EdgeInsets.only(top: 52, left: 23),
                                  child: UserToolbar(name: widget.name),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: TabBar(
                                labelStyle: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.red(),
                                ),
                                indicatorColor: MyColors.red(),
                                labelColor: MyColors.red(),
                                unselectedLabelColor: MyColors.lightGrey(),
                                tabs: const [
                                  Tab(
                                    text: 'Sarapan',
                                  ),
                                  Tab(
                                    text: 'Makan Siang',
                                  ),
                                  Tab(
                                    text: 'Makan Malam',
                                  ),
                                  Tab(
                                    text: 'Camilan',
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  ListSarapan(
                                    maxCalories: breakfast ?? 0,
                                    maxFat: fat ?? 0,
                                    maxCarb: carb ?? 0,
                                    idToken: widget.idToken,
                                    userId: widget.userId,
                                  ),
                                  ListMakanSiang(
                                    maxCalories: lunch ?? 0,
                                    maxFat: fat ?? 0,
                                    maxCarb: carb ?? 0,
                                    idToken: widget.idToken,
                                    userId: widget.userId,
                                  ),
                                  ListMakanMalam(
                                    maxCalories: dinner ?? 0,
                                    maxFat: fat ?? 0,
                                    maxCarb: carb ?? 0,
                                    idToken: widget.idToken,
                                    userId: widget.userId,
                                  ),
                                  ListCamilan(
                                    maxCalories: snack ?? 0,
                                    maxFat: fat ?? 0,
                                    maxCarb: carb ?? 0,
                                    idToken: widget.idToken,
                                    userId: widget.userId,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) >= const Duration(seconds: 2)) {
      currentBackPressTime = now;
      var message = "Press again to exit";
      Fluttertoast.showToast(
          msg: message,
          fontSize: 14,
          backgroundColor: MyColors.white(),
          textColor: MyColors.blackFont());
      return Future.value(false);
    }
    return Future.value(true);
  }
}
