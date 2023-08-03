import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_profile.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_list_saved.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/screen/home/progress_indicator.dart';
import 'package:skiripsi_app/screen/rekomendasi/item/list_saved_screen.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/user_toolbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  final String userId, idToken;
  const HomeScreen({
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FunctionIMT functionIMT = FunctionIMT();
  MessageDialog messageDialog = MessageDialog();
  DateTime currentBackPressTime = DateTime.now();
  int? calMax,
      sarapan,
      makanSiang,
      makanMalam,
      ngemil,
      lemak,
      karbo,
      calBreakfast,
      fatBreakfast,
      carbBreakfast,
      calLunch,
      fatLunch,
      carbLunch,
      calDinner,
      fatDinner,
      carbDinner,
      indicatorLunch,
      indicatorBreakfast,
      indicatorDinner,
      indicatorSnack,
      indicatorFat,
      indicatorCarb,
      indicatorCal,
      fatValue,
      carbValue,
      calValue;
  double? percentCal,
      percentLunch,
      percentBreakfast,
      percentDinner,
      percentSnack,
      percentCarb,
      percentFat;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ViewProfile>(context, listen: false).fetchProfile(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewTargetProfile>(context, listen: false)
          .fetchTarget(
        widget.userId,
        widget.idToken,
      )
          .then((value) {
        setState(() {
          calMax = value.caloriesDiet?.toInt();
        });
      });
      Provider.of<ViewPolaMakan>(context, listen: false)
          .fetchTablePolaMakan(
        widget.userId,
        widget.idToken,
      )
          .then((value) {
        setState(() {
          sarapan = value.sarapan;
          makanSiang = value.makanSiang;
          makanMalam = value.makanMalam;
          ngemil = value.ngemil;
          lemak = value.fat;
          karbo = value.carb;
          print("sarapan : $sarapan");
          Provider.of<ViewListSaved>(context, listen: false)
              .fetchListSarapan(
            widget.userId,
            widget.idToken,
          )
              .then((value) {
            setState(() {
              calBreakfast = value.kalori;
              if (calBreakfast == 0) {
                percentBreakfast = 0;
                indicatorBreakfast = 0;
              } else {
                percentBreakfast = (1 -
                    ((sarapan ?? 0) - (calBreakfast ?? 0)) / (sarapan ?? 0));
                indicatorBreakfast = ((percentBreakfast ?? 0) * 100).toInt();
              }
            });
          });
          Provider.of<ViewListSaved>(context, listen: false)
              .fetchListMakanSiang(
            widget.userId,
            widget.idToken,
          )
              .then((value) {
            setState(() {
              calLunch = value.kalori;
              if (calLunch == 0) {
                percentLunch = 0;
                indicatorLunch = 0;
              } else {
                percentLunch = (1 -
                    ((makanSiang ?? 0) - (calLunch ?? 0)) / (makanSiang ?? 0));
                indicatorLunch = ((percentLunch ?? 0) * 100).toInt();
              }
            });
          });
          Provider.of<ViewListSaved>(context, listen: false)
              .fetchListMakanMalam(
            widget.userId,
            widget.idToken,
          )
              .then((value) {
            setState(() {
              calDinner = value.kalori;
              if (calDinner == 0) {
                percentDinner = 0;
                indicatorDinner = 0;
              } else {
                percentDinner = (1 -
                    ((makanMalam ?? 0) - (calDinner ?? 0)) / (makanMalam ?? 0));

                indicatorDinner = ((percentDinner ?? 0) * 100).toInt();
              }
            });
          });
          Provider.of<ViewPolaMakan>(context, listen: false)
              .fetchNutrisiPolaMakan(
            widget.userId,
            widget.idToken,
          )
              .then((value) {
            setState(() {
              isLoading = false;
              fatValue = value.fat;
              carbValue = value.carb;
              calValue = value.cal;
              if (fatValue == 0 && carbValue == 0 && calValue == 0) {
                percentCal = 0;
                percentFat = 0;
                percentCarb = 0;
                indicatorCal = 0;
                indicatorFat = 0;
                indicatorCarb = 0;
              } else {
                percentCal =
                    (1 - (((calMax ?? 0) - (calValue ?? 0)) / (calMax ?? 0)));
                percentFat =
                    (1 - (((lemak ?? 0) - (fatValue ?? 0)) / (lemak ?? 0)));
                percentCarb =
                    (1 - (((karbo ?? 0) - (carbValue ?? 0)) / (karbo ?? 0)));
                indicatorCal = ((percentCal ?? 0) * 100).toInt();
                indicatorFat = ((percentFat ?? 0) * 100).toInt();
                indicatorCarb = ((percentCarb ?? 0) * 100).toInt();
              }
            });
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ViewProfile>(context).profile;
    final targetProfile = Provider.of<ViewTargetProfile>(context).targetProfile;
    bool isValid = Provider.of<ViewPolaMakan>(context).isValid;
    bool isCamilan = Provider.of<ViewPolaMakan>(context).isCamilan;
    var kalori = functionIMT.formatDouble(targetProfile.caloriesDiet ?? 0, 0);
    var karbo = functionIMT.formatDouble(targetProfile.carb ?? 0, 0);
    var lemak = targetProfile.fat ?? 0;
    final size = MediaQuery.of(context).size;
    Query dbListSarapan = FirebaseDatabase.instance
        .ref()
        .child('list_sarapan')
        .child(widget.userId);
    Query dbListMakanSiang = FirebaseDatabase.instance
        .ref()
        .child('list_makan_siang')
        .child(widget.userId);

    return Scaffold(
      backgroundColor: MyColors.background(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: MyColors.red(),
                    ),
                    const SizedBox(height: 8),
                    const FontPop14w400Black(text: "Mohon Tunggu"),
                  ],
                ),
              )
            : WillPopScope(
                onWillPop: onWillPop,
                child: Consumer4<ViewProfile, ViewTargetProfile, ViewPolaMakan,
                    ViewListSaved>(
                  builder: (context, viewProfile, viewTarget, viewPolaMakan,
                      viewListSaved, _) {
                    if (viewProfile.state == ClassViewProfile.loading ||
                        viewTarget.state == ClassViewProfile.loading ||
                        viewPolaMakan.state == ClassViewPola.loading ||
                        viewListSaved.state == ClassViewPola.loading) {
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
                            const FontPop14w400Black(text: "Mohon Tunggu"),
                          ],
                        ),
                      );
                    } else if (viewProfile.state == ClassViewProfile.error ||
                        viewTarget.state == ClassViewTarget.error ||
                        viewPolaMakan.state == ClassViewPola.error ||
                        viewListSaved.state == ClassViewListSaved.error) {
                      return ShowDialogEmptyProfile(
                        message:
                            "Data profil anda kosong, silahkan masukkan data terlebih dahulu",
                        idToken: widget.idToken,
                        userId: widget.userId,
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: MyColors.red(),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 0,
                                    blurRadius: 10),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 45),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: UserToolbar(name: profile.nama ?? ""),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: CircularIndicator(
                                    percent: percentCal ?? 0,
                                    progress: "$indicatorCal %",
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const FontPop14w400White(text: "Total"),
                                FontPop24w700White(text: "$kalori Kalori"),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              color: MyColors.red(),
                              onRefresh: _pullRefresh,
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 16),
                                      Container(
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: MyColors.white(),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: LinearProgress(
                                          karbo:
                                              "${carbValue ?? 0} / ${karbo.toString()} gr",
                                          lemak:
                                              " ${fatValue ?? 0} / ${lemak.toString()} gr",
                                          percentCarb: percentCarb ?? 0,
                                          percentFat: percentFat ?? 0,
                                          indicatorKarbo: "$indicatorCarb %",
                                          indicatorLemak: "$indicatorFat %",
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      isValid
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ListSavedScreen(
                                                      judul: "List Sarapan",
                                                      userId: widget.userId,
                                                      dbRef: dbListSarapan,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ContainerIndicator(
                                                judul: "Sarapan",
                                                rekomendasi:
                                                    "Rekomendasi $sarapan Kalori",
                                                progres:
                                                    "$indicatorBreakfast %",
                                                percent: percentBreakfast ?? 0,
                                              ),
                                            )
                                          : const FontPop16w400Black(
                                              text:
                                                  "Persentase Pola Makan Belum Terisi",
                                              textAlign: TextAlign.center,
                                            ),
                                      const SizedBox(height: 16),
                                      isValid
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ListSavedScreen(
                                                      judul: "List Makan Siang",
                                                      userId: widget.userId,
                                                      dbRef: dbListMakanSiang,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ContainerIndicator(
                                                judul: "Makan Siang",
                                                rekomendasi:
                                                    "Rekomendasi $makanSiang Kalori",
                                                progres: "$indicatorLunch %",
                                                percent: percentLunch ?? 0,
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(height: 16),
                                      isValid
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ListSavedScreen(
                                                      judul: "List Makan Siang",
                                                      userId: widget.userId,
                                                      dbRef: dbListMakanSiang,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ContainerIndicator(
                                                judul: "Makan Malam",
                                                rekomendasi:
                                                    "Rekomendasi $makanMalam Kalori",
                                                progres: "$indicatorDinner %",
                                                percent: percentDinner ?? 0,
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(height: 16),
                                      isCamilan
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ListSavedScreen(
                                                      judul: "List Makan Siang",
                                                      userId: widget.userId,
                                                      dbRef: dbListMakanSiang,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ContainerIndicator(
                                                judul: "Camilan",
                                                rekomendasi:
                                                    "Rekomendasi $ngemil Kalori",
                                                progres: "$indicatorSnack %",
                                                percent: percentSnack ?? 0,
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(height: 32),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      Provider.of<ViewProfile>(context, listen: false).fetchProfile(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewTargetProfile>(context, listen: false).fetchTarget(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewPolaMakan>(context, listen: false).fetchTablePolaMakan(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewListSaved>(context, listen: false).fetchListSarapan(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewListSaved>(context, listen: false).fetchListMakanSiang(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewListSaved>(context, listen: false).fetchListMakanMalam(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewPolaMakan>(context, listen: false).fetchNutrisiPolaMakan(
        widget.userId,
        widget.idToken,
      );
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) >= const Duration(seconds: 1)) {
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
