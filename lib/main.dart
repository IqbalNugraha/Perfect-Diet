import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:skiripsi_app/firebase_options.dart';
import 'package:skiripsi_app/provider/auth/view_model/view_login.dart';
import 'package:skiripsi_app/provider/auth/view_model/view_validate.dart';
import 'package:skiripsi_app/provider/daftar_makanan/view_model/view_daftar_makanan.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_imt_profile.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_profile.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_target_profile.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_pola_makan.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_camera_recommendation.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_detail_summary.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_list_saved.dart';
import 'package:skiripsi_app/provider/rekomendasi/view_model/view_rekomendasi.dart';
import 'package:skiripsi_app/provider/scanner/view_model/view_history.dart';
import 'package:skiripsi_app/screen/auth/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skiripsi_app/screen/splash_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ViewListFood(),
        ),
        ChangeNotifierProvider.value(
          value: ViewProfile(),
        ),
        ChangeNotifierProvider.value(
          value: ViewTargetProfile(),
        ),
        ChangeNotifierProvider.value(
          value: ViewImtProfile(),
        ),
        ChangeNotifierProvider.value(
          value: ViewPolaMakan(),
        ),
        ChangeNotifierProvider.value(
          value: ViewRekomendasi(),
        ),
        ChangeNotifierProvider.value(
          value: ViewDetailSummary(),
        ),
        ChangeNotifierProvider.value(
          value: ViewLogin(),
        ),
        ChangeNotifierProvider.value(
          value: ViewValidate(),
        ),
        ChangeNotifierProvider.value(
          value: ViewCamera(),
        ),
        ChangeNotifierProvider.value(
          value: ViewHistory(),
        ),
        ChangeNotifierProvider.value(
          value: ViewListSaved(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          RegisterScreen.routeName: (ctx) => const RegisterScreen(),
        },
      ),
    );
  }
}
