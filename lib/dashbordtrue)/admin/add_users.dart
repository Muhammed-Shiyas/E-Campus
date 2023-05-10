import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _accessController = TextEditingController();
  final TextEditingController _devitionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _semController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  void _addUser() {
    final String rollNumber = _rollNumberController.text;
    final String department = _departmentController.text;
    final String access = _accessController.text;
    final String devition = _devitionController.text;
    final String phone = _phoneController.text;
    final String role = _roleController.text;
    final String sem = _semController.text;
    final String year = _yearController.text;
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String fullName = _fullNameController.text;

    _firestore.collection('users').doc(rollNumber).set({
      'Department': department,
      'access': access,
      'division': devition,
      'phone': phone,
      'role': role,
      'sem': sem,
      'year': year,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User added successfully!"),
        ),
      );
      _rollNumberController.clear();
      _departmentController.clear();
      _accessController.clear();
      _devitionController.clear();
      _phoneController.clear();
      _roleController.clear();
      _semController.clear();
      _yearController.clear();
      _lastNameController.clear();
      _firstNameController.clear();
      _fullNameController.clear();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add user: $error"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _rollNumberController,
                decoration: InputDecoration(
                  labelText: "Roll Number",
                  hintText: "Enter user's roll number",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: " first name",
                  hintText: "Enter user's  first name",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: " last name",
                  hintText: "Enter user's  last name",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: " full name",
                  hintText: "Enter user's  full name",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(
                  labelText: "Department",
                  hintText: "Enter user's department",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _accessController,
                decoration: InputDecoration(
                  labelText: "Access",
                  hintText: "Enter user's access status",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _devitionController,
                decoration: InputDecoration(
                  labelText: "Devition",
                  hintText: "Enter user's devition",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "Phone",
                  hintText: "Enter user's phone number",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _roleController,
                decoration: InputDecoration(
                  labelText: "Role",
                  hintText: "Enter user's role",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _semController,
                decoration: InputDecoration(
                  labelText: "Semester",
                  hintText: "Enter user's semester",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: "Year",
                  hintText: "Enter user's year",
                ),
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: _addUser,
                  child: Text("Add User"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
