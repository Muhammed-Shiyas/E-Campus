import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:roule_based_auth/homepage_full/Class/class.dart';
import 'package:roule_based_auth/homepage_full/news.dart';
import 'package:roule_based_auth/homepage_full/settings.dart';
import '../dashbordtrue)/techers_access/teacher.dart';
import '../usermangment/usermanagment.dart';
import 'home/home.dart';

class FullHomePage extends StatefulWidget {
  const FullHomePage({Key? key});

  @override
  _FullHomePageState createState() => _FullHomePageState();
}

class _FullHomePageState extends State<FullHomePage> {
  int _currentIndex = 0;
  bool access = false;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    // check if the user has access
    checkAccess();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> checkAccess() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _subscription = FirebaseFirestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .snapshots()
          .listen((snapshot) {
        if (mounted && snapshot.docs.isNotEmpty) {
          if (snapshot.docs.first.data()['access'] == 'true') {
            setState(() {
              access = true;
            });
          } else {
            print('Not authorized');
          }
        }
      });
    }
  }

  void _onBottomNavigationBarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePageWidget(),
    userclass(),
    const UserNews(),
    const UserSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.blue.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: GNav(
            selectedIndex: _currentIndex,
            onTabChange: _onBottomNavigationBarItemTapped,
            gap: 3,
            backgroundColor: Colors.blue.shade200,
            activeColor: Color.fromARGB(255, 71, 55, 67),
            tabBackgroundColor: Colors.grey.shade100,
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.school,
                text: "Class",
              ),
              GButton(
                icon: Icons.newspaper,
                text: "News",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
            ],
          ),
        ),
      ),
      drawer: access
          ? Drawer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 114, 119, 114),
                      Color.fromARGB(255, 110, 102, 102),
                    ],
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(""),
                      accountEmail: Text(""),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 173, 232, 208),
                        child: Icon(Icons.person),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 62, 206, 180),
                            Color.fromARGB(255, 124, 255, 227),
                          ],
                        ),
                      ),
                    ),
                    // Card(
                    //   margin:
                    //       EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    //   child: ListTile(
                    //     leading: Icon(Icons.person),
                    //     title: Text('HOD'),
                    //     onTap: () {
                    //       usermanagment().authorizeAccess(context, 'HOD');
                    //     },
                    //   ),
                    // ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('teacher'),
                        onTap: () {
                          usermanagment().authorizeAccess(context, 'teacher');
                        },
                      ),
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Classrep'),
                        onTap: () {
                          usermanagment().authorizeAccess(context, 'Classrep');
                        },
                      ),
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: ListTile(
                        leading: Icon(Icons.admin_panel_settings),
                        title: Text('Admin'),
                        onTap: () {
                          usermanagment().authorizeAccess(context, 'Admin');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
