import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roule_based_auth/homepage_full/HomePage.dart';
import 'student_id_verification.dart';

String password = "";

class LoginScreen extends StatefulWidget {
  final String id;

  const LoginScreen({Key? key, required this.id}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _register() async {
    try {
      setState(() {
        _isLoading = true;
      });

      String email = id + "@gmail.com";
      String password = _passwordController.text.trim();
      String rollNo = id;

      // create user in Firebase Auth
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // add password to Firestore

      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'password': password,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'rollNo': rollNo,
      });

      // get user's details
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      final departments = ['BCA', 'DCFS', 'CS', 'AIML'];
      final years = ['1', '2', '3'];
      final divisions = ['A', 'B', 'C'];
      final semesters = ['1', '2', '3', '4', '5', '6'];
      final roles = [
        'teacher',
        'HOD',
      ];

      // ignore: non_constant_identifier_names
      for (final Department in departments) {
        if (userDoc.get('Department') == Department) {
          for (final year in years) {
            if (userDoc.get('year') == year) {
              for (final division in divisions) {
                if (userDoc.get('division') == division) {
                  for (final sem in semesters) {
                    if (userDoc.get('sem') == sem) {
                      // add user's details to students collection
                      await FirebaseFirestore.instance
                          .collection('students')
                          .doc(Department)
                          .collection('YEAR')
                          .doc('$year YEAR')
                          .collection('division')
                          .doc(division)
                          .collection('SEM')
                          .doc('$sem SEM')
                          .collection('USERdetails')
                          .doc(userDoc.id)
                          .set(userDoc.data() as Map<String, dynamic>);
                    }
                  }
                }
              }
            }
          }
        }
        if (userDoc.get('Department') == Department) {
          for (final role in roles) {
            if (userDoc.get('role') == role) {
              if (role == 'teacher') {
                // add user's details to teacher_classrep collection
                await FirebaseFirestore.instance
                    .collection('students')
                    .doc(Department)
                    .collection('teacher')
                    .doc(userDoc.id)
                    .set(userDoc.data() as Map<String, dynamic>);
              }
              if (role == 'HOD') {
                // add user's details to HOD_admin collection
                await FirebaseFirestore.instance
                    .collection('students')
                    .doc(Department)
                    .collection('HOD')
                    .doc(userDoc.id)
                    .set(userDoc.data() as Map<String, dynamic>);
              }
            }
          }
        }
      }

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullHomePage(),
          ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          duration: Duration(seconds: 5),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value.trim() != _passwordController.text.trim()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        child: Text('Register'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _register();
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
