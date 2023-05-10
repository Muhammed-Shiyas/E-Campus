import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentDetailsPage extends StatefulWidget {
  @override
  _AssignmentDetailsPageState createState() => _AssignmentDetailsPageState();
}

class _AssignmentDetailsPageState extends State<AssignmentDetailsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _submitAssignment() async {
    final User? user = _auth.currentUser;
    final String uid = user!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('assignments')
        .add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'deadline': _deadlineController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Assignment uploaded successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            TextFormField(
              controller: _deadlineController,
              decoration: InputDecoration(
                labelText: 'Deadline',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitAssignment,
              child: Text('Submit Assignment'),
            ),
          ],
        ),
      ),
    );
  }
}
