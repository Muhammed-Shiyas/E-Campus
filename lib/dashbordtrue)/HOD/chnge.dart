import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class chnge extends StatefulWidget {
  const chnge({super.key});

  @override
  State<chnge> createState() => _chngeState();
}

class _chngeState extends State<chnge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text('chnge'),
      ),
    );
  }
}
