import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:roule_based_auth/dashbordtrue)/HOD/Department_message.dart';
import 'package:roule_based_auth/dashbordtrue)/HOD/add_Teacher.dart';
import 'package:roule_based_auth/dashbordtrue)/HOD/chnge.dart';
import 'package:roule_based_auth/dashbordtrue)/HOD/od_approve.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

class HOD extends StatefulWidget {
  HOD({super.key});

  @override
  State<HOD> createState() => _HODState();
}

class _HODState extends State<HOD> {
  List<String> names = [
    'add teacher',
    'od approve  ',
    'department messages',
    'Yellow Tile',
  ];

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  List<Widget> routes = [
    add_Teacher(),
    od_approve(),
    Department_message(),
    chnge()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              color: Colors.grey,
              child: Center(
                child: Text(
                  'Header',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          color: colors[index],
                          child: Center(
                            child: Text(
                              names[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
