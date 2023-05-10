// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:roule_based_auth/homepage_full/home/E-librarry/screens.dart/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class loadingscreen extends StatefulWidget {
  var l;
  loadingscreen({@required this.l});

  @override
  State<loadingscreen> createState() => _loadingscreenState();
}

class _loadingscreenState extends State<loadingscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController c;
  var c1;
  var c2;
  var c3;
  var c4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcategorydata();
  }

  void getcategorydata() async {
    Response r1 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:thriller&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
    Response r2 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:fantasy&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
    Response r3 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:horror&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
    Response r4 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:health&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
    c1 = jsonDecode(r1.body);
    c2 = jsonDecode(r2.body);
    c3 = jsonDecode(r3.body);
    c4 = jsonDecode(r4.body);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return homescreen(c1: c1, c2: c2, c3: c3, c4: c4);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: CircularProgressIndicator(
              color: Colors.black,
            ))
          ],
        ),
      ),
    ));
  }
}
