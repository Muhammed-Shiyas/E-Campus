import 'package:flutter/material.dart';

import 'package:roule_based_auth/dashbordtrue)/classrep/addNews.dart';
import 'package:roule_based_auth/dashbordtrue)/classrep/removeNews.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

class Classrep extends StatefulWidget {
  Classrep({super.key});

  @override
  State<Classrep> createState() => _ClassrepState();
}

class _ClassrepState extends State<Classrep> {
  List<String> names = [
    'Add news',
    'remove news ',
  ];
  List<IconData> icons = [
    Icons.newspaper_rounded,
    Icons.remove_circle_outline,
  ];

  List<Color> colors = [
    Colors.red,
    Colors.blue,
  ];

  List<Widget> routes = [UploadNewsPage(), removeNews()];

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
                    'Class Rep',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/7606000.jpg',
                    height: 240,
                    width: 380,
                  ),
                ],
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(2, (index) {
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
