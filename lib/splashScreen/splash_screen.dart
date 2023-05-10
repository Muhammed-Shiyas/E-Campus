import 'package:roule_based_auth/usermangment/usermanagment.dart';
import 'package:roule_based_auth/intro_screen/onbording_screen.dart';
import 'package:roule_based_auth/intro_screen/onbording_screen.dart';
import 'package:roule_based_auth/registerAndLogin/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:roule_based_auth/usermangment/usermanagment.dart';

import '../main.dart';

class splash_Screen extends StatefulWidget {
  const splash_Screen({super.key});

  @override
  State<splash_Screen> createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => show ? onbording_screen() : usermanagment(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              height: 200,
              width: 200,
              image: AssetImage("assets/download.png"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'AJK ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 150,
              width: 500,
            ),
            SpinKitFadingCircle(
              color: Colors.orange,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
