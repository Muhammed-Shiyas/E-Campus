import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class od_approve extends StatefulWidget {
  const od_approve({super.key});

  @override
  State<od_approve> createState() => _od_approveState();
}

class _od_approveState extends State<od_approve> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text('od approve'),
      ),
    );
  }
}
