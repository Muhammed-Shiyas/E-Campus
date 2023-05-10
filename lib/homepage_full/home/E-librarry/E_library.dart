// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:roule_based_auth/homepage_full/home/E-librarry/screens.dart/splashscreen.dart';

class E_library extends StatelessWidget {
  const E_library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bookfores",
      home: splashscreen(),
    ));
  }
}
