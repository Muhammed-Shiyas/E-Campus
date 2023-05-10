import 'package:flutter/material.dart';

import 'package:roule_based_auth/homepage_full/home/E-librarry/E_library.dart';
import 'package:roule_based_auth/homepage_full/home/bus_track/showMap.dart';
import 'package:roule_based_auth/homepage_full/home/events.dart';
import 'package:roule_based_auth/homepage_full/home/bus_track/trackBus.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

import '../../dashbordtrue)/admin/order_tracking_page.dart';
import 'notification.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<String> names = [
    'Notification',
    'Events ',
    'Track Bus',
    'E-library',
  ];

  List<Widget> routes = [
    MessageListPage(),
    UserNews(),
    App(),
    E_library(),
  ];

  final List<String> _listItem = [
    'assets/1234567.png',
    'assets/123.png',
    'assets/1234.png',
    'assets/12345.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.grey,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 290,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 0, 20),
                        child: Text(
                          "HELLO                                       ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 378.5,
                        height: 181,
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
                              alignment: AlignmentDirectional(-0.05, -0.93),
                              child: Image.asset(
                                'assets/download.png',
                                width: 150.2,
                                height: 110.6,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.07, 0.76),
                              child: Text(
                                'AJK College of Arts and Science',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional(-0.85, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Text(
                      'Features ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(4, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => routes[index],
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: GridAnimatorWidget(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image:
                                                  AssetImage(_listItem[index]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      names[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
