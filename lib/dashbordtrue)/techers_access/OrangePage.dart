import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrangePage extends StatefulWidget {
  const OrangePage({super.key});

  @override
  State<OrangePage> createState() => _OrangePageState();
}

class _OrangePageState extends State<OrangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text('Orange Page'),
      ),
      body: Center(
        child: Text('This is the orange Page'),
      ),
    );
  }
}
