// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, deprecated_member_use, use_full_hex_values_for_flutter_colors

import 'dart:io' as i;
import 'package:roule_based_auth/homepage_full/home/E-librarry/screens.dart/homescreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class bookdisplay extends StatefulWidget {
  var d;
  bookdisplay({@required this.d});

  @override
  State<bookdisplay> createState() => _bookdisplayState();
}

class _bookdisplayState extends State<bookdisplay> {
  var pagecount = "Not available";
  var desc = "Not available";
  var pubdate = "Not available";
  var lang = "Not available";
  var rating = "Not available";
  var url =
      "https://www.bing.com/images/search?view=detailV2&ccid=vx9%2fIUj5&id=3B7650A146D55682645F765E60E786419299154C&thid=OIP.vx9_IUj50utS7cbaiRtoZAHaE8&mediaurl=https%3a%2f%2fst3.depositphotos.com%2f1186248%2f14351%2fi%2f950%2fdepositphotos_143511907-stock-photo-not-available-rubber-stamp.jpg&exph=682&expw=1023&q=not+available&simid=608054098357136066&FORM=IRPRST&ck=BADF0353AC59677CCFAA67227357E3CB&selectedIndex=1&ajaxhist=0&ajaxserp=0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpagecount();
    getdesc();
    getpubdate();
    geturl();
  }

  geturl() {
    try {
      url = widget.d["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"];
    } catch (e) {
      url = widget.d["items"][1]["volumeInfo"]["imageLinks"]["thumbnail"];
      ;
    }
  }

  getlang() {
    try {
      setState(() {
        lang = widget.d["items"][0]["volumeInfo"]["language"]
            .toString()
            .toUpperCase();
      });
    } catch (e) {
      setState(() {
        lang = "Not available";
      });
    }
  }

  void getpubdate() {
    try {
      setState(() {
        pubdate =
            widget.d["items"][0]["volumeInfo"]["publishedDate"].toString();
      });
    } catch (e) {
      setState(() {
        pubdate = "Not available";
      });
    }
  }

  void getdesc() {
    try {
      setState(() {
        desc = widget.d["items"][0]["volumeInfo"]["description"];
      });
    } catch (e) {
      setState(() {
        desc = "Not available";
      });
    }
  }

  void getpagecount() {
    try {
      setState(() {
        pagecount = widget.d["items"][0]["volumeInfo"]["pageCount"].toString();
      });
    } catch (e) {
      setState(() {
        pagecount = "Not available";
      });
    }
  }

  void getrating() {
    try {
      setState(() {
        rating = widget.d["items"][0]["volumeInfo"]["averageRating"].toString();
      });
    } catch (e) {
      setState(() {
        rating = "Not available";
      });
    }
  }

  Future openfile(var url, var title) async {
    final file = await downloadfile(url, title!);
    if (file == null) {
      print("null");
      return;
    }
    print(file.path);
    OpenFile.open(file.path);
  }

  Future<i.File?> downloadfile(var url, var filename) async {
    try {
      var appstorage = await getApplicationDocumentsDirectory();
      // ignore: unused_local_variable
      final file = i.File('${appstorage.path}/filename');
      final Response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));
      final raf = file.openSync(mode: i.FileMode.write);
      raf.writeFromSync(Response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 224, 194),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: ElevatedButton(
          onPressed: () async {
            await launchUrl(
                Uri.parse(widget.d["items"][0]["accessInfo"]["webReaderLink"]));
          },
          style: ElevatedButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            backgroundColor: Colors.black,
          ),
          child: Text(
            "READ BOOK",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.4,
                        image: AssetImage("assets/overlay.png"),
                        fit: BoxFit.cover)),
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
                        size: 30,
                      ),
                    ),
                    Text(
                      "DETAILS",
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          var url = widget.d["items"][0]["accessInfo"]["epub"]
                              ["isAvailable"];
                          if (url == true) {
                            url = widget.d["items"][0]["accessInfo"]["epub"]
                                ["acsTokenLink"];
                            await launchUrl(Uri.parse(url));
                          }
                        } catch (e) {
                          print("Not available");
                        }
                      },
                      child: Icon(
                        Icons.download_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          opacity: 0.4,
                          image: AssetImage("assets/overlay.png"),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 230,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                  url,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.d["items"][0]["volumeInfo"]["title"],
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          "by " +
                              widget.d["items"][0]["volumeInfo"]["authors"][0],
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15, color: Colors.grey[400])),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Rating",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[400])),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  rating,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Pages",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[400])),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  pagecount,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Language",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[400])),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  lang,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Publish date",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[400])),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  pubdate.toUpperCase(),
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.white)),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 25),
                        child: ListView(
                          children: [
                            Text(
                              "What's it about?",
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              desc,
                              style: GoogleFonts.lato(
                                  color: Colors.grey[600], fontSize: 15),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
