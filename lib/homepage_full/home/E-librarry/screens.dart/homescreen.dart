// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:roule_based_auth/homepage_full/home/E-librarry/category/fantasy.dart';
import 'package:roule_based_auth/homepage_full/home/E-librarry/category/horror.dart';
import 'package:roule_based_auth/homepage_full/home/E-librarry/category/health.dart';
import 'package:roule_based_auth/homepage_full/home/E-librarry/category/adventure.dart';
import 'package:roule_based_auth/homepage_full/home/E-librarry/screens.dart/bookloading.dart';
import 'package:roule_based_auth/homepage_full/home/E-librarry/screens.dart/search_loadind.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class homescreen extends StatefulWidget {
  var c1;
  var c2;
  var c3;
  var c4;

  homescreen(
      {@required this.c1,
      @required this.c2,
      @required this.c3,
      @required this.c4});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  TextEditingController t = TextEditingController();

  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 3) {
        break;
      }
      if (s[i] == ' ') {
        count++;
      }
      ans = ans + s[i];
    }
    return ans + "...";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.c1);
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff012AC0),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.4,
                    image: AssetImage("assets/overlay.png"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: (() {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      }),
                      child:
                          Icon(Icons.arrow_back, size: 30, color: Colors.white))
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/back.png",
                      ),
                      fit: BoxFit.cover)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: Container(
                        height: 40,
                        child: TextField(
                          controller: t,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Search Book...",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return searchloading(text: t.text);
                        }));
                      },
                      splashColor: Color(0xfff012AC0),
                      child: Container(
                        color: Colors.white,
                        child: Text(
                          "SEARCH",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Explore the book forest!",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Find the light you are chasing for.",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                            child: ListView(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "Adventure",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        adventure(c4: widget.c1),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "Fantasy",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        fantasy(c2: widget.c2),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "Horror",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        horror(c3: widget.c3),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "Health",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        romance(c4: widget.c4),
                      ],
                    )))
                  ],
                ),
              ))
        ],
      )),
    ));
  }
}
