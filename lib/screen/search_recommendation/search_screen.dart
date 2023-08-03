import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_rekomendasi.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/rekomendasi_item.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/string_custom.dart';
import 'package:skiripsi_app/widget/user_toolbar.dart';

class SearchScreen extends StatefulWidget {
  final String name, userId, idToken;
  const SearchScreen({
    required this.name,
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final txtSearch = TextEditingController();
  FunctionIMT functionIMT = FunctionIMT();
  DateTime currentBackPressTime = DateTime.now();
  StringCustom stringCustom = StringCustom();
  bool isValid = false;
  int? maxFat, maxCarb, maxCalories;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ViewTargetProfile>(context, listen: false).fetchTarget(
        widget.userId,
        widget.idToken,
      );
      Provider.of<ViewPolaMakan>(context, listen: false).fetchPolaMakan(
        widget.userId,
        widget.idToken,
      );
      Future.delayed(const Duration(microseconds: 500000), () {
        Provider.of<ViewRekomendasi>(context, listen: false).fetchMainCourse(
          maxCarb ?? 0,
          maxFat ?? 0,
          maxCalories ?? 0,
        );
      });
    });
    isValid = true;
    super.initState();
  }

  void _search(String query, int maxCarb, int maxFat, int maxCalories) {
    setState(() {
      Provider.of<ViewRekomendasi>(context, listen: false)
          .fetchSearch(maxCarb, maxFat, maxCalories, query)
          .then((response) {
        if (response.result!.isNotEmpty) {
          setState(() {
            isValid = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final dataTargetProfile = Provider.of<ViewTargetProfile>(context);
    final dataPolaMakan = Provider.of<ViewPolaMakan>(context);
    final dataRekomendasi = Provider.of<ViewRekomendasi>(context);
    final rekomendasi = dataRekomendasi.responseData.result;
    final targetProfile = dataTargetProfile.targetProfile;
    var isLoadingList = dataRekomendasi.isLoading;
    final polaMakan = dataPolaMakan.polaMakan;

    maxFat = targetProfile.fat;

    maxCarb = int.parse(functionIMT.formatDouble(targetProfile.carb ?? 0, 0));

    maxCalories = int.parse(
      functionIMT.hitungPolaMakan(
        polaMakan.makanSiang ?? 0,
        targetProfile.caloriesDiet ?? 0,
      ),
    );

    return Scaffold(
      backgroundColor: MyColors.background(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  padding: const EdgeInsets.only(top: 52, left: 23),
                  child: UserToolbar(name: widget.name),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: size.width,
                height: 50,
                child: TextFormField(
                  controller: txtSearch,
                  onChanged: (String text) {
                    Future.delayed(const Duration(seconds: 3), () {
                      _search(
                          text, maxCarb ?? 0, maxFat ?? 0, maxCalories ?? 0);
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyColors.red(),
                    ),
                    hintText: "Cari makanan?",
                    contentPadding: const EdgeInsets.all(0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: MyColors.red(),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: MyColors.red(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Consumer3<ViewTargetProfile, ViewPolaMakan, ViewRekomendasi>(
              builder: (context, viewTarget, viewPola, viewRekomendasi, _) {
                if (viewTarget.state == ClassViewTarget.loading ||
                    viewPola.state == ClassViewPola.loading ||
                    viewRekomendasi.state == ClassViewRekomendasi.loading) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyColors.red(),
                      ),
                    ),
                  );
                } else if (viewTarget.state == ClassViewTarget.error &&
                    viewPola.state == ClassViewPola.error &&
                    viewRekomendasi.state == ClassViewRekomendasi.error) {
                  return const Expanded(
                    child: Center(
                      child: FontPop16w400Black(
                        text: "Maaf, data error",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (viewTarget.state == ClassViewTarget.empty ||
                    viewPola.state == ClassViewPola.empty ||
                    viewRekomendasi.state == ClassViewRekomendasi.empty) {
                  return const Expanded(
                    child: Center(
                      child: FontPop16w400Black(
                        text: "Maaf, data kosong",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  return isValid
                      ? isLoadingList
                          ? Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.red(),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: rekomendasi?.length ?? 0,
                                  itemBuilder: (ctx, i) {
                                    return RekomendasiItem(
                                      id: rekomendasi?[i].id ?? 0,
                                      name: rekomendasi?[i].title ?? "",
                                      img: rekomendasi?[i].image ?? "",
                                      fat: rekomendasi![i]
                                          .nutrition!
                                          .nutrients![1]
                                          .amount!,
                                      calories: rekomendasi[i]
                                          .nutrition!
                                          .nutrients![0]
                                          .amount!,
                                      carb: rekomendasi[i]
                                          .nutrition!
                                          .nutrients![2]
                                          .amount!,
                                    );
                                  },
                                ),
                              ),
                            )
                      : isLoadingList
                          ? Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.red(),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: rekomendasi?.length ?? 0,
                                  itemBuilder: (ctx, i) {
                                    
                                    return RekomendasiItem(
                                      id: rekomendasi?[i].id ?? 0,
                                      name: rekomendasi?[i].title ?? "",
                                      img: rekomendasi?[i].image ?? "",
                                      fat: rekomendasi![i]
                                          .nutrition!
                                          .nutrients![1]
                                          .amount ?? 0,
                                      calories: rekomendasi[i]
                                          .nutrition!
                                          .nutrients![0]
                                          .amount ?? 0,
                                      carb: rekomendasi[i]
                                          .nutrition!
                                          .nutrients![2]
                                          .amount ?? 0,
                                    );
                                  },
                                ),
                              ),
                            );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
