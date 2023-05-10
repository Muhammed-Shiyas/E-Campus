import 'package:flutter/material.dart';
import 'package:roule_based_auth/intro_screen/onbording_screen.dart';
import 'package:roule_based_auth/splashScreen/splash_screen.dart';
import 'package:roule_based_auth/usermangment/usermanagment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:roule_based_auth/registerAndLogin/registerpages/student_id_verification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registerAndLogin/registerpages/otp_verification.dart';
import 'registerAndLogin/registerpages/set_new_password.dart';
import 'registerAndLogin/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool('ON_BORDING') ?? true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash_Screen(),
    );
  }
}
