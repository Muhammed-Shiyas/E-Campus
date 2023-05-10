import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadedAssignmentsPage extends StatefulWidget {
  UploadedAssignmentsPage({super.key});

  @override
  _UploadedAssignmentsPageState createState() =>
      _UploadedAssignmentsPageState();
}

class _UploadedAssignmentsPageState extends State<UploadedAssignmentsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _fileNameController = TextEditingController();

  late String _fileName;
  late String _fileUrl;

  Future<void> _uploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        String fileName = file.name;
        String? filePath = file.path;
        _fileNameController.text = fileName;

        final User? user = _auth.currentUser;
        final String? uid = user?.uid;

        Reference ref = _storage.ref().child('assignments/$uid/$fileName');
        UploadTask uploadTask = ref.putFile(File(filePath!));

        uploadTask.whenComplete(() async {
          String fileUrl = await ref.getDownloadURL();

          await _firestore
              .collection('assignments')
              .doc(uid)
              .collection('uploads')
              .add({
            'fileName': fileName,
            'fileUrl': fileUrl,
            'timestamp': FieldValue.serverTimestamp(),
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File uploaded successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading file')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uploaded Assignments'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _uploadFile,
            child: Text('Upload File'),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('assignments')
                  .doc(_auth.currentUser!.uid)
                  .collection('uploads')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<AssignmentFile> assignments = [];
                snapshot.data!.docs.forEach((doc) {
                  assignments.add(AssignmentFile.fromSnapshot(doc));
                });

                if (assignments.isEmpty) {
                  return Center(
                    child: Text('No uploaded assignments yet'),
                  );
                }

                return ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    AssignmentFile assignment = assignments[index];
                    return ListTile(
                      title: Text(assignment.fileName),
                      subtitle: Text(
                        assignment.timestamp.toDate().toString(),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () async {
                          await launch(assignment.fileUrl);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AssignmentFile {
  final String fileName;
  final String fileUrl;
  final Timestamp timestamp;

  AssignmentFile(
      {required this.fileName, required this.fileUrl, required this.timestamp});

  factory AssignmentFile.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return AssignmentFile(
      fileName: data['fileName'],
      fileUrl: data['fileUrl'],
      timestamp: data['timestamp'],
    );
  }
}
