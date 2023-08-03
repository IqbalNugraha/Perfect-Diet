import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/model_list_saved.dart';
import 'package:skiripsi_app/screen/auth/login_screen.dart';
import 'package:skiripsi_app/screen/bottom_navigation/bottom_navigation.dart';
import 'package:skiripsi_app/screen/profile/new_profile_screen.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/logic/logic_rekomendasi.dart';

class MessageDialog {
  void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 200,
        height: 250,
        child: Column(
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Loading...")
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showErrorDialog(BuildContext context, String error,
      TextEditingController txtEmail, TextEditingController txtPassword) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                txtEmail.clear();
                txtPassword.clear();
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showErrorTarget(
    BuildContext context,
    String error,
    TextEditingController txtHari,
    TextEditingController txtKalori,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                txtHari.clear();
                txtKalori.clear();
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showErrorCalory(
    BuildContext context,
    String error,
    TextEditingController txtKalori,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                txtKalori.clear();
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showErrorPolaMakan(
    BuildContext context,
    String error,
    TextEditingController txtEditing,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 120,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                txtEditing.clear();
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showErrorPolaMakanTotal(
    BuildContext context,
    String error,
    TextEditingController txtEditing1,
    TextEditingController txtEditing2,
    TextEditingController txtEditing3,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                txtEditing1.clear();
                txtEditing2.clear();
                txtEditing3.clear();
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDialogSuccessRegister(BuildContext ctx) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Selamat, anda telah berhasil mendaftarkan akun"),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDialogSuccessLogin(BuildContext ctx, String message) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDialogSuccessProfile(
    BuildContext ctx,
    String localId,
    String idToken,
    String message,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BottomNavigation(
                      initialSelectedTab: "Profil",
                      initialIndex: 4,
                      idToken: idToken,
                      userId: localId,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDialogSuccessAuth(
    BuildContext ctx,
    String idToken,
    String localId,
    String message,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BottomNavigation(
                      initialSelectedTab: "Beranda",
                      initialIndex: 0,
                      idToken: idToken,
                      userId: localId,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDialogProfileEmpty(
    BuildContext ctx,
    String idToken,
    String localId,
    String message,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => NewProfileScren(
                      idToken: idToken,
                      localId: localId,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //negative case

  void showDialogEmpty(
    BuildContext ctx,
    String message,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDialogValidateGender(
    BuildContext ctx,
    String message,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDialogPolaMakan(bool valueSarapan, bool valueMakanSiang,
      bool valueMakanMalam, BuildContext context, void function) {
    showDialog(
      context: context,
      builder: (
        context,
      ) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CheckboxListTile(
                      title: const FontPop14w400Black(text: "Sarapan"),
                      value: valueSarapan,
                      onChanged: (value) {
                        setState(() {
                          valueSarapan = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const FontPop14w400Black(text: "Makan Siang"),
                      value: valueMakanSiang,
                      onChanged: (value) {
                        setState(() {
                          valueMakanSiang = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const FontPop14w400Black(text: "Makan Malam"),
                      value: valueMakanMalam,
                      onChanged: (value) {
                        setState(() {
                          valueMakanMalam = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        function;
                      },
                      child: const FontPop14w400White(
                        text: "Simpan",
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ShowDialogEmptyProfile extends StatefulWidget {
  final String message;
  final String userId;
  final String idToken;
  const ShowDialogEmptyProfile({
    required this.message,
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<ShowDialogEmptyProfile> createState() => _ShowDialogEmptyProfileState();
}

class _ShowDialogEmptyProfileState extends State<ShowDialogEmptyProfile> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.message),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => NewProfileScren(
                      idToken: widget.idToken,
                      localId: widget.userId,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShowDialogPolaMakan extends StatefulWidget {
  final List<String> items;
  const ShowDialogPolaMakan({super.key, required this.items});

  @override
  State<ShowDialogPolaMakan> createState() => _ShowDialogPolaMakanState();
}

class _ShowDialogPolaMakanState extends State<ShowDialogPolaMakan> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: FontPoppins(
        text: "Pilih Menu Makan",
        color: MyColors.blackFont(),
        size: 16,
        fontWeight: FontWeight.w400,
        alignment: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class DialogPolaMakan extends StatefulWidget {
  final int breakfastValue,
      lunchValue,
      dinnerValue,
      fatMax,
      carbMax,
      calValue,
      carbValue,
      fatValue, nutrisiCal, nutrisiFat, nutrisiCarb;
  final String userId, idToken, title, imgUrl;
  const DialogPolaMakan({
    required this.calValue,
    required this.carbValue,
    required this.fatValue,
    required this.title,
    required this.imgUrl,
    required this.breakfastValue,
    required this.lunchValue,
    required this.dinnerValue,
    required this.fatMax,
    required this.carbMax,
    required this.nutrisiCal,
    required this.nutrisiFat,
    required this.nutrisiCarb,
    required this.userId,
    required this.idToken,
    super.key,
  });

  @override
  State<DialogPolaMakan> createState() => _DialogPolaMakanState();
}

class _DialogPolaMakanState extends State<DialogPolaMakan> {
  LogicRekomendasi logicRekomendasi = LogicRekomendasi();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 370,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FontPoppins(
            text: "Pilih menu makanan yang ingin kamu pilih",
            color: MyColors.blackFont(),
            size: 16,
            fontWeight: FontWeight.w400,
            alignment: TextAlign.center,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              logicRekomendasi.sendBreakfast(
                widget.title,
                widget.imgUrl,
                widget.calValue,
                widget.fatValue,
                widget.carbValue,
                widget.breakfastValue,
                widget.fatMax,
                widget.carbMax,
                widget.nutrisiCal,
                widget.nutrisiFat,
                widget.nutrisiCarb,
                widget.userId,
                widget.idToken,
                context,
              );
            },
            child: Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.red(),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 48),
              child: Center(
                child: FontPoppins(
                  text: "Sarapan",
                  color: MyColors.white(),
                  size: 14,
                  fontWeight: FontWeight.w400,
                  alignment: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.red(),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 48),
              child: Center(
                child: FontPoppins(
                  text: "Makan Siang",
                  color: MyColors.white(),
                  size: 14,
                  fontWeight: FontWeight.w400,
                  alignment: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.red(),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 48),
              child: Center(
                child: FontPoppins(
                  text: "Makan Malam",
                  color: MyColors.white(),
                  size: 14,
                  fontWeight: FontWeight.w400,
                  alignment: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.red(),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 48),
              child: Center(
                child: FontPoppins(
                  text: "Camilan",
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
    );
  }
}
