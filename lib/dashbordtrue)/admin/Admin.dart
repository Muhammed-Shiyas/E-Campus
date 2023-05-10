import 'package:flutter/material.dart';
import 'package:roule_based_auth/dashbordtrue)/admin/add_users.dart';
import 'package:roule_based_auth/dashbordtrue)/admin/Events.dart';
import 'package:roule_based_auth/dashbordtrue)/admin/bus_tracking.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

import 'order_tracking_page.dart';
import 'messages_events.dart';

class Adminonly extends StatefulWidget {
  Adminonly({super.key});

  @override
  State<Adminonly> createState() => _AdminonlyState();
}

class _AdminonlyState extends State<Adminonly> {
  List<String> names = [
    'add users',
    'Events ',
    ' Messages',
    ' Add Bus location',
  ];
  List<IconData> icons = [
    Icons.add_home_outlined,
    Icons.event,
    Icons.message,
    Icons.bus_alert
  ];
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];
  List<Widget> routes = [
    AddUserPage(),
    UploadeventsPage(),
    UploadMessagePage(),
    App()
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
                    'Admin',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/11879298_202011_04.jpg',
                    height: 250,
                    width: 380,
                  ),
                ],
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
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
