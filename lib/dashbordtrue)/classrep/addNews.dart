import 'dart:ffi';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadNewsPage extends StatefulWidget {
  @override
  _UploadNewsPageState createState() => _UploadNewsPageState();
}

class _UploadNewsPageState extends State<UploadNewsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  String _department = "";
  File? _image;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Future<void> _getUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.length > 0) {
          final DocumentSnapshot userSnapshot = querySnapshot.docs[0];
          setState(() {
            _department = userSnapshot.get('Department');
          });
          print('User details: $_department');
        }
      });
    }
  }

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

    final CollectionReference newsCollection =
        _firestore.collection('students').doc(_department).collection('news');
    final DateTime now = DateTime.now();
    final String date = "${now.year}-${now.month}-${now.day}";
    final Timestamp timestamp =
        Timestamp.fromDate(now); // add timestamp to news data
    final QuerySnapshot newsSnapshot =
        await newsCollection.where('date', isEqualTo: date).get();
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
          FirebaseStorage.instance.ref().child("news_images").child(newsId);
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    }
    final Map<String, dynamic> newsData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'imageUrl': imageUrl,
      'date': date,
      'timestamp': timestamp, // add timestamp field
      'uid': user.uid,
      'department': _department,
      'newsId': newsId,
    };
    newsCollection.doc(newsId).set(newsData).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("News uploaded successfully!"),
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
          content: Text("Failed to upload news: $error"),
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
  void initState() {
    super.initState();
    _getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload News"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Enter news title",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Enter news description",
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Choose Image"),
              ),
              SizedBox(height: 16.0),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 200,
                    )
                  : SizedBox(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _uploadNews,
                child: Text("Upload News"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
