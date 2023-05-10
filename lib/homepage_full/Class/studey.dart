import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StudyMaterialsPage extends StatefulWidget {
  @override
  _StudyMaterialsPageState createState() => _StudyMaterialsPageState();
}

class _StudyMaterialsPageState extends State<StudyMaterialsPage> {
  final List<String> _pdfPaths = [
    'assets/COMPUTERNETWORKS.pdf',
    'assets/GRAPHICSANDMULTIMEDIA.pdf',
    'assets/IoT.pdf',
  ];

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Materials'),
      ),
      body: ListView.builder(
        itemCount: _pdfPaths.length,
        itemBuilder: (context, index) {
          final fileName = _pdfPaths[index].split('/').last;
          return ListTile(
            title: Text(fileName),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SfPdfViewer.file(
                    File(_pdfPaths[index]),
                    canShowPaginationDialog: true,
                  ),
                ),
              ).then((value) {
                setState(() {
                  _selectedIndex = -1;
                });
              });
            },
            tileColor: _selectedIndex == index ? Colors.grey[300] : null,
          );
        },
      ),
    );
  }
}
