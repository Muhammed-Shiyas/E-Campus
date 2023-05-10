import 'package:flutter/material.dart';
import 'package:roule_based_auth/dashbordtrue)/techers_access/timetable_details.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';
import 'package:shaky_animated_listview/scroll_animator.dart';

import 'TakeAttendance.dart';
import 'GreenPage.dart';
import 'OrangePage.dart';
import 'PurplePage.dart';

import 'YellowPage.dart';

class TeacherPage extends StatefulWidget {
  TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List<String> names = [
    'Add Timetable',
    'Take attendence ',
    'Add assenment',
    'test tile',
  ];

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];
  List<IconData> icons = [
    Icons.timelapse_outlined,
    Icons.event,
    Icons.assignment,
    Icons.library_books
  ];
  List<Widget> routes = [
    StudentDetailsPage(),
    attendenceDetails(),
    AssignmentDetailsPage(),
    const YellowPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Teacher',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/illustration.png',
                    height: 250,
                    width: 380,
                  ),
                ],
              ),
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => routes[index]),
                    );
                  },
                  child: GridAnimatorWidget(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: Container(
                                color: colors[index],
                                child: Center(
                                  child: Icon(
                                    icons[index],
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            names[index],
                            style: TextStyle(
                              color: Colors.black,
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
          ],
        ),
      ),
    );
  }
}
