import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roule_based_auth/dashbordtrue)/techers_access/timetable.dart';

class StudentDetailsPage extends StatefulWidget {
  @override
  _StudentDetailsPageState createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _departmentController = TextEditingController();
  final _yearController = TextEditingController();
  final _divisionController = TextEditingController();
  final _semesterController = TextEditingController();
  final timetable_depaertment = TextEditingController();

  void _saveDetails() async {
    if (_formKey.currentState!.validate()) {
      // Save details to Firebase Firestore
      await FirebaseFirestore.instance
          .collection('students')
          .doc('TIMETABLEADD')
          .set({
        'Department': _departmentController.text,
        'year': _yearController.text,
        'division': _divisionController.text,
        'sem': _semesterController.text,
        'timetable_depaertment': timetable_depaertment.text,
      });

      // Navigate to next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TimeTablePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(labelText: 'Department'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter department';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: timetable_depaertment,
                decoration: InputDecoration(labelText: 'timetable_depaertment'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter department';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter year';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _divisionController,
                decoration: InputDecoration(labelText: 'Division'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter division';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _semesterController,
                decoration: InputDecoration(labelText: 'Semester'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter semester';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveDetails,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
