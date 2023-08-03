import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/rekomendasi.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_camera_recommendation.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_rekomendasi.dart';
import 'package:skiripsi_app/provider/scanner/view_model/view_history.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi/rekomendasi_item.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/string_custom.dart';
import 'package:skiripsi_app/widget/user_toolbar.dart';
import 'package:skiripsi_app/widget/row_custom.dart';

class CameraScreen extends StatefulWidget {
  final String userId, idToken, username;
  const CameraScreen({
    required this.userId,
    required this.idToken,
    required this.username,
    super.key,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  ViewCamera viewCamera = ViewCamera();
  FunctionIMT functionIMT = FunctionIMT();
  StringCustom stringCustom = StringCustom();
  File? imagePicker;
  String? base64Image, name;
  int? kalori,
      lemak,
      karbo,
      maxCal,
      maxFat,
      maxCarb,
      id,
      calValue,
      fatValue,
      carbValue,
      sarapanValue,
      makanSiangValue,
      makanMalamValue,
      camilanValue;
  double? polaMakan, ngemil;
  int? kaloriSarapan,
      kaloriMakanSiang,
      kaloriMakanMalam,
      karboSarapan,
      karboMakanSiang,
      karboMakanMalam,
      lemakSarapan,
      lemakMakanSiang,
      lemakMakanMalamm,
      nutrisiCal,
      nutrisiCarb,
      nutrisiFat,
      accuracy;
  List<String>? dishType;
  List<RekomendasiBreakfast>? result;
  bool isCamera = false;
  bool isLoading = false;
  bool isNutrisi = false;
  @override
  void initState() {
    isCamera = true;
    isLoading = true;
    isNutrisi = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ViewPolaMakan>(context, listen: false)
          .fetchNutrisiPolaMakan(
        widget.userId,
        widget.idToken,
      )
          .then((value) {
        setState(() {
          nutrisiCal = value.cal;
          nutrisiFat = value.fat;
          nutrisiCarb = value.carb;
        });
        Provider.of<ViewTargetProfile>(context, listen: false)
            .fetchTarget(widget.userId, widget.idToken)
            .then((value) {
          maxCal = ((value.caloriesDiet ?? 0).toInt()) - (nutrisiCal ?? 0);
          maxFat = ((value.fat ?? 0).toInt()) - (nutrisiFat ?? 0);
          maxCarb = ((value.carb ?? 0).toInt()) - (nutrisiCarb ?? 0);
          openCamera().then((value) {
            setState(() {
              isLoading = false;
            });
            Provider.of<ViewCamera>(context, listen: false)
                .recogImage(base64Image ?? "")
                .then((value) {
              setState(() {
                name = value.outputs?[0].data?.concepts?[0].name;
                accuracy =
                    (((value.outputs?[0].data?.concepts?[0].value ?? 0)) * 100)
                        .toInt();
                Provider.of<ViewCamera>(context, listen: false)
                    .getDataFood(
                  name ?? '',
                  maxCal ?? 0,
                  maxFat ?? 0,
                  maxCarb ?? 0,
                )
                    .then((value) {
                  setState(() {
                    calValue = value.result?[0].nutrition?.nutrients?[0].amount
                        ?.toInt();
                    fatValue = value.result?[0].nutrition?.nutrients?[1].amount
                        ?.toInt();
                    carbValue = value.result?[0].nutrition?.nutrients?[2].amount
                        ?.toInt();
                    Future.delayed(const Duration(seconds: 2), () {
                      Provider.of<ViewHistory>(context, listen: false)
                          .sendHistory(
                        name ?? "",
                        calValue ?? 0,
                        fatValue ?? 0,
                        carbValue ?? 0,
                        base64Image ?? "",
                        widget.userId,
                        widget.idToken,
                      );
                    });
                  });
                  Provider.of<ViewRekomendasi>(context, listen: false)
                      .fetchSearch(
                    maxCarb ?? 0,
                    maxFat ?? 0,
                    maxCal ?? 0,
                    name ?? "",
                  )
                      .then((value) {
                    setState(() {
                      result = value.result;
                    });
                  });
                  Provider.of<ViewPolaMakan>(context, listen: false)
                      .fetchTablePolaMakan(widget.userId, widget.idToken)
                      .then((value) {
                    setState(() {
                      sarapanValue = value.sarapan;
                      makanSiangValue = value.makanSiang;
                      makanMalamValue = value.makanMalam;
                      camilanValue = value.ngemil;
                      isNutrisi = false;
                    });
                  });
                });
              });
            });
          });
        });
      });
    });

    super.initState();
  }

  //method buka kamera
  Future<void> openCamera() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.rear,
      maxHeight: 300,
      maxWidth: 200,
    );

    if (file != null) {
      List<int> imageBytes = await File(file.path).readAsBytes();

      setState(() {
        base64Image = base64Encode(imageBytes);
        imagePicker = File(file.path);
        isCamera = false;
        print("isCamera : $isCamera");
      });
    } else {
      setState(() {
        isCamera = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.background(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
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
                  child: UserToolbar(name: widget.username),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: MyColors.red(),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        isCamera
                            ? const SizedBox()
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(imagePicker?.path ?? ""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                        const SizedBox(height: 24),
                        isNutrisi
                            ? Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  color: MyColors.red(),
                                ),
                              )
                            : Expanded(
                                child: Consumer4<ViewCamera, ViewPolaMakan,
                                    ViewTargetProfile, ViewRekomendasi>(
                                  builder: (context, viewCamera, viewPolaMakan,
                                      viewTargetProfile, viewRekomendasi, _) {
                                    if (viewCamera.state ==
                                            ClassViewCamera.loading &&
                                        viewPolaMakan.state ==
                                            ClassViewPola.loading &&
                                        viewTargetProfile.state ==
                                            ClassViewTarget.loading &&
                                        viewRekomendasi.state ==
                                            ClassViewCamera.loading) {
                                      return Align(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(
                                          color: MyColors.red(),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          children: [
                                            ColumnCamera(
                                              title: name ?? "",
                                              accuracy: accuracy ?? 0,
                                              imgUrl: base64Image ?? "",
                                              calValue: calValue ?? 0,
                                              carbValue: carbValue ?? 0,
                                              fatValue: fatValue ?? 0,
                                              sarapanValue: sarapanValue ?? 0,
                                              makanSiangValue:
                                                  makanSiangValue ?? 0,
                                              makanMalamValue:
                                                  makanMalamValue ?? 0,
                                              camilanValue: camilanValue ?? 0,
                                              fatMax: maxFat ?? 0,
                                              carbMax: maxCarb ?? 0,
                                              ngemil: ngemil ?? 0,
                                              nutrisiCal: nutrisiCal ?? 0,
                                              nutrisiFat: nutrisiFat ?? 0,
                                              nutrisiCarb: nutrisiCarb ?? 0,
                                              userId: widget.userId,
                                              idToken: widget.idToken,
                                            ),
                                            FontPoppins(
                                              text:
                                                  "Rekomendasi Makan yang Serupa",
                                              color: MyColors.blackFont(),
                                              size: 16,
                                              fontWeight: FontWeight.w400,
                                              alignment: TextAlign.start,
                                            ),
                                            const SizedBox(height: 16),
                                            SizedBox(
                                              height: 230,
                                              width: size.width,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: result?.length ?? 0,
                                                itemBuilder: (context, i) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 8,
                                                    ),
                                                    child: RekomendasiItem(
                                                      id: result![i].id!,
                                                      name: result![i].title!,
                                                      img: result![i].image!,
                                                      fat: result![i]
                                                          .nutrition!
                                                          .nutrients![1]
                                                          .amount!,
                                                      calories: result![i]
                                                          .nutrition!
                                                          .nutrients![0]
                                                          .amount!,
                                                      carb: result![i]
                                                          .nutrition!
                                                          .nutrients![2]
                                                          .amount!,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 16)
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// else if (viewCamera.state ==
//                                   ClassViewCamera.empty) {
//                                 return Align(
//                                   alignment: Alignment.center,
//                                   child: FontPoppins(
//                                     text: stringCustom.emptyClarifai,
//                                     color: MyColors.blackFont(),
//                                     size: 16,
//                                     fontWeight: FontWeight.w400,
//                                     alignment: TextAlign.center,
//                                   ),
//                                 );
//                               } else if (viewCamera.state ==
//                                   ClassViewCamera.error) {
//                                 return Align(
//                                   alignment: Alignment.center,
//                                   child: FontPoppins(
//                                     text: stringCustom.errorClarifai,
//                                     color: MyColors.blackFont(),
//                                     size: 16,
//                                     fontWeight: FontWeight.w400,
//                                     alignment: TextAlign.center,
//                                   ),
//                                 );
//                               } 
