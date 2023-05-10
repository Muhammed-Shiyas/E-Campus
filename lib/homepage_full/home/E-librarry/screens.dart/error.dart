// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class error extends StatefulWidget {
  const error({Key? key}) : super(key: key);

  @override
  State<error> createState() => _errorState();
}

class _errorState extends State<error> {
  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        body: Center(
          child: Text("Error"),
        ),
      )
    );
  }
}