import 'package:cloud_firestore/cloud_firestore.dart';
import 'intro_page1.dart';
import 'intro_page2.dart';
import 'intro_page3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:roule_based_auth/usermangment/usermanagment.dart';

import 'intro_page4.dart';
import 'intro_page_5.dart';

bool show = true;

class onbording_screen extends StatefulWidget {
  const onbording_screen({super.key});

  @override
  State<onbording_screen> createState() => _onbording_screenState();
}

class _onbording_screenState extends State<onbording_screen> {
  //controller for dot indicator
  final PageController _controller = PageController();
  //keep track the last page
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (Index) {
              setState(() {
                onLastPage = (Index == 4);
              });
            },
            children: [
              intro_page1(),
              intro_page2(),
              intro_page3(),
              intro_page4(),
              intro_page5()
            ],
          ),
          //dot indicator
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(4);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //dot indicator
                SmoothPageIndicator(controller: _controller, count: 5),
                //next or done
                onLastPage
                    ? GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('ON_BORDING', false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return usermanagment();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(microseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
