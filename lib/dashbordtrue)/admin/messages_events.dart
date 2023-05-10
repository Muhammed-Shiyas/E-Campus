import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadMessagePage extends StatefulWidget {
  @override
  _UploadMessagePageState createState() => _UploadMessagePageState();
}

class _UploadMessagePageState extends State<UploadMessagePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _uploadMessage() {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({
        'title': title,
        'description': description,
        'timestamp': DateTime.now(),
      }).then((value) {
        _titleController.clear();
        _descriptionController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Message uploaded successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading message: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Message')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadMessage,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
