import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class YellowPage extends StatefulWidget {
  const YellowPage({super.key});

  @override
  State<YellowPage> createState() => _YellowPageState();
}

class _YellowPageState extends State<YellowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('test page'),
      ),
      body: Center(
        child: Text('This is the test  Page'),
      ),
    );
  }
}
