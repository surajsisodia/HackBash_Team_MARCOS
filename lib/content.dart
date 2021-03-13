import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class Content extends StatelessWidget {
  final String name;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Content({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bc,
          leading: Builder(builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: pc,
                size: b * 18,
              ),
            );
          }),
          centerTitle: true,
          title: Text(
            name,
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        body: Stack(children: [
          Positioned(
            top: h * 10,
            child: Container(
              width: b * 375,
              height: h * 750,
              padding:
                  EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(b * 40),
                  topRight: Radius.circular(b * 40),
                ),
              ),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  sh(20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: b * 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(b * 5),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.25),
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.white),
                    child: itemsInGroup("Books"),
                  ),
                  sh(20),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: b * 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(b * 5),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000).withOpacity(0.25),
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Colors.white),
                      child: itemsInGroup("Class Notes")),
                  sh(20),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: b * 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(b * 5),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000).withOpacity(0.25),
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Colors.white),
                      child: itemsInGroup("Video Links")),
                  sh(20),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: b * 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(b * 5),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000).withOpacity(0.25),
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Colors.white),
                      child: itemsInGroup("Mid Semester Paper")),
                  sh(20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: b * 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(b * 5),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.25),
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.white),
                    child: itemsInGroup("End Semester Paper"),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget itemsInGroup(String type) {
    return FutureBuilder(
      future: _firestore.collection('academics resources').doc(name).get(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                type,
                style: txtS(Colors.black, 18, FontWeight.w600),
              ));
        }
        var items = snapshot.data[type];
        List<Widget> weees = [];
        for (var item in items) {
          weees.add(row(item['name'], item['link']));
          weees.add(sh(15));
        }
        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(
            type,
            style: txtS(Colors.black, 18, FontWeight.w600),
          ),
          children: weees,
        );
      },
    );
  }

  InkWell row(
    String name,
    String link,
  ) {
    return InkWell(
      onTap: () async {
        await canLaunch(link)
            ? await launch(link)
            : throw 'Could not launch $link';
      }, //download book function
      child: Row(
        children: [
          Text(
            name,
            style: txtS(Colors.black, 16, FontWeight.w400),
          ),
          Spacer(),
          Icon(Icons.download_rounded,
              color: Colors.black, size: SizeConfig.screenWidth * 18 / 375)
        ],
      ),
    );
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 375,
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 812);
  }
}

class ContentSubject {
  final String name;
  final String link;

  ContentSubject(
    this.name,
    this.link,
  );
}

// isko call krna haiiiii
List<ContentSubject> contacts = [
  ContentSubject(
    'Book Name',
    'YouTube Link',
  ),
];
