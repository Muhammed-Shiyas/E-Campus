import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roule_based_auth/dashbordtrue)/HOD/HOD.dart';
import 'package:roule_based_auth/dashbordtrue)/admin/Admin.dart';
import 'package:roule_based_auth/dashbordtrue)/ClassRep/Classrep.dart';
import 'package:roule_based_auth/dashbordtrue)/techers_access/teacher.dart';
import 'package:roule_based_auth/homepage_full/HomePage.dart';
import 'package:roule_based_auth/registerAndLogin/login.dart';

class AuthHandler extends StatelessWidget {
  AuthHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return FullHomePage();
        }
        return LoginPage();
      },
    );
  }
}

// ignore: camel_case_types
class usermanagment extends StatelessWidget {
  usermanagment({Key? key}) : super(key: key);

  void authorizeAccess(BuildContext context, String role) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((docs) {
        if (docs.docs.isNotEmpty) {
          print(
              'User data found in Firestore: ${docs.docs.first.data()['role']}');
          String userRole = docs.docs.first.data()['role'];
          if (userRole == role) {
            switch (userRole) {
              case 'Classrep':
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => Classrep()),
                );
                break;

              case 'Admin':
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => Adminonly()),
                );
                break;

              case 'teacher':
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => TeacherPage()),
                );
                break;

              case 'HOD':
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => HOD()),
                );
                break;

              default:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Invalid role.')),
                );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('You are not authorized to access this page.')),
            );
          }
        }
      });
    }
  }

  void signout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AuthHandler();
  }
}
