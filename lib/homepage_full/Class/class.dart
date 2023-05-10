import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roule_based_auth/homepage_full/Class/video_lectures.dart';
import 'Assignment.dart';
import 'package:roule_based_auth/homepage_full/Class/attendence.dart';
import 'package:roule_based_auth/homepage_full/Class/studey.dart';
import 'package:roule_based_auth/homepage_full/Class/timetable.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

import 'chat_with_teacher/main.dart';

class userclass extends StatefulWidget {
  userclass({Key? key}) : super(key: key);

  @override
  _userclassState createState() => _userclassState();
}

class _userclassState extends State<userclass> {
  String _lastName = "";
  String _fullName = "";
  String _department = "";
  String _division = '';
  String _year = '';
  String _sem = '';
  String _rollNo = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  Future<void> _getUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          final DocumentSnapshot userSnapshot = querySnapshot.docs[0];
          final lastName = userSnapshot.get('lastName') ?? '';
          final fullName = userSnapshot.get('fullName') ?? '';
          final department = userSnapshot.get('Department') ?? '';
          final division = userSnapshot.get('division') ?? '';
          final year = userSnapshot.get('year') ?? '';
          final sem = userSnapshot.get('sem') ?? '';
          final rollNo = userSnapshot.get('rollNo') ?? '';

          setState(() {
            _lastName = lastName;
            _fullName = fullName;
            _department = department;
            _division = division;
            _year = year;
            _rollNo = rollNo;
            _sem = sem;
          });
        } else {
          setState(() {
            _lastName = '';
            _fullName = '';
            _department = '';
            _division = '';
            _year = "";
            _sem = "";
            _rollNo = "";
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  List<String> names = [
    'Timetable',
    'Attendance ',
    'Assignment',
    'chat with teacher',
    'study material',
    'video lectures',
  ];
  final List<String> _listItem = [
    'assets/timetable.png',
    'assets/attendence1.png',
    'assets/assignment.png',
    'assets/chatWithTeacher.png',
    'assets/studyMaterial.png',
    'assets/videoLectures.png',
  ];
  List<Widget> routes = [
    TimeTablePage(),
    AttendancePage(
      overallAttendance: 63.5,
      subjectAttendance: {
        'IOT': 60.0,
        'graphics and multimedia': 60.0,
        'Computer Network': 75.0,
      },
    ),
    UploadedAssignmentsPage(),
    MyApp(),
    StudyMaterialsPage(),
    VideoListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[600],
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 20),
                child: Text(
                  'Hello $_lastName                                              ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Container(
                  width: 380,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFEFE),
                    borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Color.fromARGB(255, 112, 225, 167),
                      width: 5,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, -0.95),
                        child: Container(
                          width: 120,
                          height: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/profile.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.02, 0.06),
                        child: Text(
                          _fullName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.91, 0.36),
                        child: Text(
                          'Department :  $_department',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.61, 0.37),
                        child: Text(
                          'Year :$_year',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.91, 0.63),
                        child: Text(
                          'Division          :$_division',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.57, 0.63),
                        child: Text(
                          'Semester :$_sem',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.92, 0.89),
                        child: Text(
                          'Reg Number :$_rollNo',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(6, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => routes[index]),
                          );
                        },
                        child: GridAnimatorWidget(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: AssetImage(_listItem[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  names[index % names.length],
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
