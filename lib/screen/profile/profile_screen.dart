import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/auth/view_model/view_login.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_imt_profile.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_profile.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/screen/auth/login_screen.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/screen/profile/daftar_kandungan_screen.dart';
import 'package:skiripsi_app/screen/profile/detail_profile_screen.dart';
import 'package:skiripsi_app/screen/profile/imt_profile_screen.dart';
import 'package:skiripsi_app/screen/profile/pola_profile_screen.dart';
import 'package:skiripsi_app/screen/profile/target_profile_screen.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/row_custom.dart';
import 'package:skiripsi_app/widget/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  final String idToken, userId;
  const ProfileScreen({
    required this.userId,
    required this.idToken,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  MessageDialog messageDialog = MessageDialog();
  DateTime currentBackPressTime = DateTime.now();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ViewProfile>(context, listen: false).fetchProfile(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewTargetProfile>(context, listen: false).fetchTarget(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewPolaMakan>(context, listen: false).fetchPolaMakan(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewPolaMakan>(context, listen: false).fetchTablePolaMakan(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewImtProfile>(context, listen: false).fetchIMT(
        widget.userId,
        widget.idToken,
      );
    });
    super.initState();
  }

  void _logout() {
    ViewLogin viewLogin = ViewLogin();
    viewLogin.logout().then((_) {
      const snackBar = SnackBar(content: Text('Logout Success'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const LoginScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profile = Provider.of<ViewProfile>(context).profile;
    final targetProfile = Provider.of<ViewTargetProfile>(context).targetProfile;
    final imtProfile = Provider.of<ViewImtProfile>(context).imtProfile;
    final tablePolaMakan = Provider.of<ViewPolaMakan>(context).tablePolaMakan;

    return Scaffold(
      backgroundColor: MyColors.background(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: WillPopScope(
          onWillPop: onWillPop,
          child: Consumer4<ViewProfile, ViewTargetProfile, ViewImtProfile,
              ViewPolaMakan>(
            builder:
                (context, viewProfile, viewTarget, viewIMT, viewPolaMakan, _) {
              if (viewProfile.state == ClassViewProfile.loading ||
                  viewTarget.state == ClassViewTarget.loading ||
                  viewIMT.state == ClassViewIMT.loading ||
                  viewPolaMakan.state == ClassViewPola.loading) {
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
              } else if (viewProfile.state == ClassViewProfile.error &&
                  viewTarget.state == ClassViewTarget.error &&
                  viewIMT.state == ClassViewIMT.error &&
                  viewPolaMakan.state == ClassViewPola.error) {
                return const Center(
                  child: FontPop16w400Black(
                    text:
                        "Tidak Tampil Data, Silahkan Isi Data Terlebih Dahulu",
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return RefreshIndicator(
                  color: MyColors.red(),
                  onRefresh: _pullRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: size.width,
                              height: 100,
                              decoration: BoxDecoration(
                                color: MyColors.red(),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 50, left: 16),
                              child:
                                  FontPop24w700White(text: "Profil Pengguna"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailProfileScreen(
                                    activity: profile.aktivitas ??
                                        "Pilih Aktivitas Harian",
                                    weight: profile.berat ?? 0,
                                    height: profile.tinggi ?? 0,
                                    name: profile.nama ?? "",
                                    age: profile.umur ?? 0,
                                    idToken: widget.userId,
                                    userId: widget.userId,
                                  ),
                                ),
                              );
                            },
                            child: UserProfile(
                              username: profile.nama ?? "",
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: size.width,
                          height: 1,
                          color: MyColors.grey(),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: FontPop18w600Black(text: "Perhitungan IMT"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32, right: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => IMTProfileScreen(
                                    idToken: widget.idToken,
                                    userId: widget.userId,
                                    activity: profile.aktivitas ??
                                        "Pilih Aktivitas Harian",
                                    weight: profile.berat ?? 0,
                                    height: profile.tinggi ?? 0,
                                    age: profile.umur ?? 0,
                                    imt: imtProfile.imt ?? 0,
                                    imtLemak: imtProfile.imtLemak ?? 0,
                                    bmr: imtProfile.bmrKalori ?? 0,
                                  ),
                                ),
                              );
                            },
                            child: const RowCustomIcon(judul: "Hitung IMT"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: size.width,
                          height: 1,
                          color: MyColors.grey(),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: FontPop18w600Black(text: "Perencanaan Diet"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32, right: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TargetProfileScreen(
                                    usia: profile.umur ?? 0,
                                    weightTarget: targetProfile.weight ?? "",
                                    dayTarget: targetProfile.day ?? 0,
                                    caloriesTarget: targetProfile.calories ?? 0,
                                    bmrKalori: imtProfile.bmrKalori ?? 0,
                                    idToken: widget.idToken,
                                    localId: widget.userId,
                                  ),
                                ),
                              );
                            },
                            child: const RowCustomIcon(
                                judul: "Target Berat & Tinggi Badan"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: size.width,
                          height: 1,
                          color: MyColors.grey(),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child:
                              FontPop18w600Black(text: "Pola Makan & Jadwal"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32, right: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PolaProfileScreen(
                                    calories: targetProfile.caloriesDiet ?? 0,
                                    ngemil: tablePolaMakan.ngemilValue ?? 0.0,
                                    carb: targetProfile.carb?.toInt() ?? 0,
                                    fat: targetProfile.fat ?? 0,
                                    userId: widget.userId,
                                    idToken: widget.idToken,
                                    hasilIMT: imtProfile.hasilIMT ?? "",
                                    username: profile.nama ?? "",
                                  ),
                                ),
                              );
                            },
                            child: const RowCustomIcon(judul: "Pola Makan"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32, right: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DaftarKandunganScreen(
                                    userId: widget.userId,
                                  ),
                                ),
                              );
                            },
                            child: const RowCustomIcon(
                              judul: "History Makanan",
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: size.width,
                          height: 1,
                          color: MyColors.grey(),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: FontPop18w600Black(text: "Akun"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32, right: 16),
                          child: GestureDetector(
                            onTap: () {
                              _logout();
                            },
                            child: const RowCustomIcon(judul: "Keluar"),
                          ),
                        ),
                      ],
                    ),
                  ),
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
      Provider.of<ViewPolaMakan>(context, listen: false).fetchPolaMakan(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewImtProfile>(context, listen: false).fetchIMT(
        widget.userId,
        widget.idToken,
      );
    });
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
