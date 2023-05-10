import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roule_based_auth/registerAndLogin/registerpages/set_new_password.dart';

class OtpVerificationPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  String id = '';

  OtpVerificationPage({
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late String _errorMessage = '';
  TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;

  Future<void> _verifyOtp(String verificationId, String otp) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      _isLoading = true;
    });

    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await auth.signInWithCredential(credential);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(
          id: 'id',
        ),
      ));
    } catch (e) {
      setState(() {
        _errorMessage = "Invalid OTP. Please try again.";
      });

      Fluttertoast.showToast(
          msg: "Invalid OTP. Please try again.",
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
        title: Text('OTP Verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter the OTP sent to ${widget.phoneNumber}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'OTP',
                  errorText: _errorMessage,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () => _verifyOtp(
                          widget.verificationId,
                          _otpController.text.trim(),
                        ),
                child:
                    _isLoading ? CircularProgressIndicator() : Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
