import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadeventsPage extends StatefulWidget {
  @override
  _UploadeventsPageState createState() => _UploadeventsPageState();
}

class _UploadeventsPageState extends State<UploadeventsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Future<void> _uploadNews() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User not found!"),
        ),
      );
      return;
    }

    final CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('Event');

    final DateTime now = DateTime.now();
    final String date = "${now.year}-${now.month}-${now.day}";
    final Timestamp timestamp =
        Timestamp.fromDate(now); // add timestamp to news data

    final QuerySnapshot newsSnapshot =
        await eventCollection.where('date', isEqualTo: date).get();
    if (newsSnapshot.docs.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Maximum 5 news can be uploaded per day!"),
        ),
      );
      return;
    }

    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Title and description cannot be empty!"),
        ),
      );
      return;
    }

    final String newsId = "${now.microsecondsSinceEpoch}-${user.uid}";
    String imageUrl = "";
    if (_image != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child("event_images").child(newsId);
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    }

    final Map<String, dynamic> eventData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'imageUrl': imageUrl,
      'date': date,
      'timestamp': timestamp, // add timestamp field
      'uid': user.uid,
      'eventId': newsId,
    };
    eventCollection.doc(newsId).set(eventData).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Event uploaded successfully!"),
        ),
      );
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _image = null;
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to upload event: $error"),
        ),
      );
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload Event"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Event Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: "Event Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                      child: _image == null
                          ? Center(child: Text("Tap to select image"))
                          : Image.file(_image!, fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _uploadNews,
                  child: Text("Upload Event"),
                ),
              ],
            ),
          ),
        ));
  }
}
