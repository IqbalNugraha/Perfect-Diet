import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/auth/view_model/view_login.dart';
import 'package:skiripsi_app/screen/auth/login_screen.dart';
import 'package:skiripsi_app/screen/bottom_navigation/bottom_navigation.dart';
import 'package:skiripsi_app/utility/warna.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isInit = true;
  String idToken = "";
  String userId = "";

  @override
  void didChangeDependencies() {    
    if (isInit) {
      Provider.of<ViewLogin>(context, listen: false)
          .getStringToken()
          .then((token) {
        idToken = token;
      });
      Provider.of<ViewLogin>(context, listen: false)
          .getStringUser()
          .then((user) {
        userId = user;
      });
      Provider.of<ViewLogin>(context, listen: false)
          .tryAutoLogin()
          .then((response) {
        Timer(
          const Duration(seconds: 3),
          () => response
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigation(
                      initialSelectedTab: "Beranda",
                      initialIndex: 0,
                      idToken: idToken,
                      userId: userId,
                    ),
                  ),
                )
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                ),
        );
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.brokenWhite(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: Image.asset(
            "assets/png/logo.png",
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
