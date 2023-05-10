// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:roule_based_auth/homepage_full/home/E-librarry/screens.dart/bookloading.dart';
import 'package:roule_based_auth/homepage_full/home/E-librarry/screens.dart/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class searchfilter extends StatefulWidget {
  var d;
  searchfilter({@required this.d});

  @override
  State<searchfilter> createState() => _searchfilterState();
}

class _searchfilterState extends State<searchfilter> {
  var isbn;

  getisbn(int index) {
    try {
      setState(() {
        isbn = widget.d["items"][index + 1]["volumeInfo"]["industryIdentifiers"]
            [0]["identifier"];
      });
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return error();
      }));
    }
  }

  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 20) {
        break;
      }
      count++;
      ans = ans + s[i];
    }
    return ans + "...";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color: Colors.black,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "RESULT",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "..",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.d["items"].length - 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: (Container(
                        padding: EdgeInsets.all(10),
                        height: 270,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 25, 224, 194),
                            image: DecorationImage(
                                opacity: 0.4,
                                image: AssetImage("assets/overlay.png"),
                                fit: BoxFit.cover)),
                        child: Row(
                          children: [
                            Container(
                              height: 210,
                              width: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.d["items"]
                                              [index + 1]["volumeInfo"]
                                          ["imageLinks"]["thumbnail"]),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Flexible(
                                  child: Text(
                                    // you can change it accordingly

                                    (widget.d["items"][index + 1]["volumeInfo"]
                                                    ["title"])
                                                .length >
                                            20
                                        ? st(widget.d["items"][index + 1]
                                            ["volumeInfo"]["title"])
                                        : widget.d["items"][index + 1]
                                            ["volumeInfo"]["title"],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    (widget.d["items"][index + 1]["volumeInfo"]
                                                    ["authors"][0])
                                                .length >
                                            20
                                        ? "by " +
                                            st(widget.d["items"][index + 1]
                                                ["volumeInfo"]["authors"][0])
                                        : "by " +
                                            widget.d["items"][index + 1]
                                                ["volumeInfo"]["authors"][0],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Page Count:- " +
                                      (widget.d["items"][index + 1]
                                              ["volumeInfo"]["pageCount"]
                                          .toString()),
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  (widget.d["items"][index + 1]["volumeInfo"]
                                              ["averageRating"]) ==
                                          null
                                      ? "⭐ " + "Not rating available"
                                      : "⭐ " +
                                          (widget.d["items"][index + 1]
                                                  ["volumeInfo"]
                                                  ["averageRating"]
                                              .toString()),
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    getisbn(index);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return bookloading(c: isbn);
                                    }));
                                  },
                                  child: Text(
                                    "DETAILS",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
