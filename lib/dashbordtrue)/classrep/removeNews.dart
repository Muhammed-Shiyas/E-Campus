import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class removeNews extends StatefulWidget {
  const removeNews({super.key});

  @override
  State<removeNews> createState() => _removeNewsState();
}

class _removeNewsState extends State<removeNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("remove news")),
    );
  }
}
