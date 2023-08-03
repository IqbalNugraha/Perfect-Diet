import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/auth/view_model/view_login.dart';
import 'package:skiripsi_app/screen/auth/validate_screen.dart';
import 'package:skiripsi_app/screen/bottom_navigation/bottom_navigation.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/text_field_custom.dart';
import 'package:skiripsi_app/widget/validatitor.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Validator validator = Validator();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MessageDialog messageDialog = MessageDialog();
  var textEmail = TextEditingController();
  var textPassword = TextEditingController();
  bool isValid = false;
  Color buttonOff = MyColors.lightGrey();
  Color buttonOn = MyColors.red();
  bool hidePassword = true;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    textEmail.addListener(() {
      if (textEmail.text.isEmpty) {
        setState(() {
          isValid = false;
        });
      } else {
        setState(() {
          isValid = true;
        });
      }
    });
    super.initState();
  }

  void _login(String email, String password) {
    ViewLogin viewLogin = ViewLogin();
    viewLogin.login(email, password).then(
      (response) {
        var error = response.error;
        if (error != null) {
          messageDialog.showErrorDialog(
            context,
            response.error?.message ?? "",
            textEmail,
            textPassword,
          );
        } else {
          var idToken = response.idToken!;
          var localId = response.localId!;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BottomNavigation(
                initialSelectedTab: "Beranda",
                initialIndex: 0,
                idToken: idToken,
                userId: localId,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.background(),
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/png/bg_auth.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 70),
                            child: Image(
                              image: AssetImage('assets/png/logo.png'),
                              width: 180,
                              height: 180,
                            ),
                          ),
                          TextFieldEmail(
                            textEmail: textEmail,
                          ),
                          const SizedBox(height: 12),
                          TextFieldPassword(
                            textPassword: textPassword,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: FontPop12w400White(text: "Lupa Password?"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isValid ? buttonOn : buttonOff,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                if (validateAndSave()) {
                                  final progress = ProgressHUD.of(context);
                                  progress!.showWithText("Loading...");
                                  _login(textEmail.text, textPassword.text);
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      progress.dismiss();
                                    },
                                  );
                                }
                              },
                              child: const FontPop12w400White(text: "Masuk"),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context)
                              //     .pushNamed(RegisterScreen.routeName);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ValidateScreen(),
                                ),
                              );
                            },
                            child:
                                const FontPop14w600White(text: "Daftar Akun?"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
