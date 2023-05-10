import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roule_based_auth/registerAndLogin/registerpages/otp_verification.dart';

import 'forgot_pageotp2.dart';

String id = '';

class forgot_page1 extends StatefulWidget {
  const forgot_page1({super.key});

  @override
  State<forgot_page1> createState() => _forgot_page1State();
}

class _forgot_page1State extends State<forgot_page1> {
  TextEditingController _idController = TextEditingController();
  late String _phoneNumber;
  bool _isLoading = false;

  Future<void> _sendOtp(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Fluttertoast.showToast(
              msg: "The provided phone number is not valid.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong. Please try again later.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => forgot_pageotp2(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
          ),
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> _submitId() async {
    setState(() {
      _isLoading = true;
    });
    id = _idController.text.trim();
    final userRef = FirebaseFirestore.instance.collection('users').doc(id);
    final userData = await userRef.get();

    if (userData.exists) {
      _phoneNumber = userData.data()!['phone'].toString();

      try {
        await _sendOtp(_phoneNumber);
      } catch (error) {
        Fluttertoast.showToast(
            msg: "Something went wrong. Please try again later.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Invalid student ID. Please try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student ID Verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'Student ID',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitId,
                child:
                    _isLoading ? CircularProgressIndicator() : Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
