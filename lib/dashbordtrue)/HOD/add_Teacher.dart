import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class add_Teacher extends StatefulWidget {
  const add_Teacher({super.key});

  @override
  State<add_Teacher> createState() => _add_TeacherState();
}

class _add_TeacherState extends State<add_Teacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text('add teacher'),
      ),
    );
  }
}
