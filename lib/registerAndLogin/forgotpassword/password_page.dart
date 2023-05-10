import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roule_based_auth/registerAndLogin/login.dart';
import 'package:roule_based_auth/registerAndLogin/registerpages/set_new_password.dart';

import 'ForgotPasswordPage.dart';

class PasswordPage extends StatefulWidget {
  final String id;
  final String password;

  const PasswordPage({required this.id, required this.password});

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  @override
  void initState() {
    super.initState();
    _getPassword();
  }

  Future<void> _getPassword() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      if (snapshot.exists) {
        setState(() {
          password = snapshot.data()!['password'];
        });
      }
    } catch (e) {
      print('Error retrieving password: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Page'),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Password for user ${id}: $password',
              style: TextStyle(fontSize: 24),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Container(
              color: Colors.blue,
              height: 40,
              width: 60,
            ),
          )
        ],
      ),
    );
  }
}
