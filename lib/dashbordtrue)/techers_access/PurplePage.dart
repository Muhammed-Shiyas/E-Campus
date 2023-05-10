import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PurplePage extends StatefulWidget {
  const PurplePage({super.key});

  @override
  State<PurplePage> createState() => _PurplePageState();
}

class _PurplePageState extends State<PurplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Purple Page'),
      ),
      body: Center(
        child: Text('This is the Purple Page'),
      ),
    );
  }
}
