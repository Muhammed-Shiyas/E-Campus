// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:roule_based_auth/homepage_full/home/E-librarry/screens.dart/bookdisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class bookloading extends StatefulWidget {
  var c;
  bookloading({@required this.c});

  @override
  State<bookloading> createState() => _bookloadingState();
}

class _bookloadingState extends State<bookloading> {
  var c2;

  @override
  void initState() {
    print(widget.c);
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    try {
      Response r = await get(Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=isbn:${widget.c}&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
      c2 = jsonDecode(r.body);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return bookdisplay(d: c2);
      }));
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
