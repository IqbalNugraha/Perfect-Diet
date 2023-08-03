import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/auth/view_model/view_validate.dart';
import 'package:skiripsi_app/screen/auth/register_screen.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

class ValidateScreen extends StatefulWidget {
  const ValidateScreen({super.key});

  @override
  State<ValidateScreen> createState() => _ValidateScreenState();
}

class _ValidateScreenState extends State<ValidateScreen> {
  MessageDialog messageDialog = MessageDialog();
  StringCustom stringCustom = StringCustom();
  File? imagePicker;
  String? name, base64Image;
  double? value;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    openCamera().then((_) {
      Provider.of<ViewValidate>(context, listen: false)
          .sendValidate(base64Image ?? "")
          .then((response) {
        setState(() {
          print(response.outputs![0].data!.concepts![0].name);
          if (response.outputs![0].data!.concepts![0].name == "Feminine") {
            name = "Wanita";
            value = (response.outputs![0].data!.concepts![0].value ?? 0) * 100;
          } else {
            name = "Laki - Laki";
            value = (response.outputs![0].data!.concepts![0].value ?? 0) * 100;
          }
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              isLoading = false;
            });
          });
        });
      });
    });
    super.initState();
  }

  //method buka kamera
  Future<void> openCamera() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
      preferredCameraDevice: CameraDevice.front,
      maxHeight: 300,
      maxWidth: 200,
    );

    if (file != null) {
      List<int> imageBytes = await File(file.path).readAsBytes();
      setState(() {
        base64Image = base64Encode(imageBytes);
        imagePicker = File(file.path);
      });
    }
  }

  void navigateToRegister() {
    if (name == "Wanita") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ),
      );
    } else {
      messageDialog.showDialogValidateGender(
        context,
        stringCustom.validateGender,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.background(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.red(),
              ),
            )
          : ProgressHUD(
              child: Builder(
                builder: (context) => SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FontPoppins(
                        text: "Validasi Jenis Kelamin",
                        color: MyColors.blackFont(),
                        size: 16,
                        fontWeight: FontWeight.w600,
                        alignment: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      imagePicker != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                imagePicker!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 24),
                      FontPoppins(
                        text: "Hasil Pendeteksian jenis kelamin",
                        color: MyColors.blackFont(),
                        size: 14,
                        fontWeight: FontWeight.w400,
                        alignment: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      FontPoppins(
                        text: name ?? "",
                        color: MyColors.blackFont(),
                        size: 16,
                        fontWeight: FontWeight.w400,
                        alignment: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      FontPoppins(
                        text: "$value %",
                        color: MyColors.blackFont(),
                        size: 16,
                        fontWeight: FontWeight.w400,
                        alignment: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              final progress = ProgressHUD.of(context);
                              progress!.showWithText("Loading...");
                              navigateToRegister();
                              Future.delayed(const Duration(seconds: 2), () {
                                progress.dismiss();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.red(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: FontPoppins(
                              text: "Validasi",
                              color: MyColors.white(),
                              size: 14,
                              fontWeight: FontWeight.w400,
                              alignment: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
