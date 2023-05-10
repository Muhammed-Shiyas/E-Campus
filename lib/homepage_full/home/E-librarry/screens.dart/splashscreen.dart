// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loadingscreen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 224, 194),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(),
                            color: Color.fromARGB(255, 25, 224, 194),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                opacity: (0.3),
                                image: AssetImage("assets/overlay.png"),
                                fit: BoxFit.cover)),
                      ),
                      Center(
                        child:
                            Container(child: Image.asset("assets/books.png")),
                      ),
                    ],
                  )),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                          "Discover",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                          "new worlds !",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                          "Dive into new worlds with our application,",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(color: Colors.grey[600])),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                          "explore, study, follow the arrival of books,",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(color: Colors.grey[600])),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                          "get into good habbit of reading.",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(color: Colors.grey[600])),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                var l = [
                                  "mystery",
                                  "fantasy",
                                  "horror",
                                  "romance"
                                ];
                                return loadingscreen(l: l);
                              }),
                            );
                          }),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "EXPLORE",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900)),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
