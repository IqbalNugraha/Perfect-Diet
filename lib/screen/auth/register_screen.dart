import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/auth/view_model/view_register.dart';
import 'package:skiripsi_app/screen/dialog/message_dialog.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/text_field_custom.dart';
import 'package:skiripsi_app/widget/logic/logic_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MessageDialog messageDialog = MessageDialog();
  LogicAuth logicAuth = LogicAuth();
  var textEmail = TextEditingController();
  var textPassword = TextEditingController();
  bool hidePassword = true;
  String? idToken, localId;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
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
              height: size.height,
              width: size.width,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/png/bg_auth.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 98, left: 90, right: 90),
                        child: Image(
                          image: AssetImage('assets/png/logo.png'),
                          width: 180,
                          height: 180,
                        ),
                      ),
                      TextFieldEmail(
                        textEmail: textEmail,
                      ),
                      const SizedBox(height: 20),
                      TextFieldPassword(
                        textPassword: textPassword,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 108),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.red(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (validateAndSave()) {
                              ViewAuth viewAuth = ViewAuth();
                              viewAuth
                                  .register(textEmail.text, textPassword.text)
                                  .then(
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
                                    idToken = response.idToken;
                                    localId = response.localId;
                                    logicAuth.updatePolaMakan(
                                      localId ?? "",
                                      idToken ?? "",
                                    );
                                    messageDialog
                                        .showDialogSuccessRegister(context);
                                  }
                                },
                              );
                            }
                          },
                          child: const FontPop12w400White(text: "Daftar"),
                        ),
                      ),
                    ],
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
