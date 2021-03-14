import 'authScreens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';
import 'drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    List images = [
      'images/p1.jpg',
      'images/p2.jpg',
      'images/p3.jpg',
      'images/p4.jpg',
      'images/p5.jpg',
      'images/p6.jpg'
    ];
    List quoteItems = [
      'Remember that the happiest people are not those getting more, but those giving more.',
      'Since you get more joy out of giving joy to others, you should put a good deal of thought into the happiness that you are able to give.',
      'We must give more in order to get more. It is the generous giving of ourselves that produces the generous harvest.',
      'We make a living by what we get. We make a life by what we give.',
      'No one is useless in this world who lightens the burdens of another.',
      'It is every man’s obligation to put back into the world at least the equivalent of what he takes out of it.',
      'The meaning of life is to find your gift. The purpose of life is to give it away.',
      'I have found that among its other benefits, giving liberates the soul of the giver.'
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bc,
          leading: Builder(builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                MdiIcons.sortVariant,
                color: pc,
                size: b * 24,
              ),
            );
          }),
          centerTitle: true,
          title: Text(
            "Home",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        drawer: DrawerCode(),
        body: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                height: h * 190,
                autoPlay: true,
              ),
              items: images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        alignment: Alignment.center,
                        height: h * 136,
                        margin: EdgeInsets.symmetric(vertical: h * 10),
                        padding: EdgeInsets.symmetric(
                            horizontal: b * 40, vertical: h * 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(b * 15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffc9c9c9).withOpacity(0.49),
                              blurRadius: 20,
                              offset: Offset(0, 6),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(i),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ]);
                  },
                );
              }).toList(),
            ),
            Expanded(
              child: Container(
                width: b * 375,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(b * 100),
                  ),
                ),
                child: Column(
                  children: [
                    sh(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Attedance",
                          style: txtS(Colors.black, 16, FontWeight.w300),
                        ),
                        SizedBox(width: b * 15),
                      ],
                    ),
                    sh(5),
                    Container(
                      margin: EdgeInsets.only(left: b * 45),
                      width: b * 315,
                      height: h * 20,
                      decoration: BoxDecoration(
                        color: Color(0xffdbdbdb),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.25),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(b * 15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: h * 20,
                            width: b * 315 * 0.75,
                            decoration: BoxDecoration(
                              color: Color(0xff4cca1f),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(0.25),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(b * 15),
                            ),
                            child: Text(
                              "75 %",
                              style: txtS(Colors.black, 13, FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    sh(40),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: b * 25, vertical: h * 15),
                            width: b * 300,
                            decoration: BoxDecoration(
                              color: Color(0xffd8d1ea),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(b * 25),
                                topLeft: Radius.circular(b * 40),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Assignments",
                                  style:
                                      txtS(Colors.black, 20, FontWeight.w500),
                                ),
                                sh(10),
                                Row(
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Analog Circuits",
                                            style: txtS(Colors.black, 16,
                                                FontWeight.w400),
                                          ),
                                          sh(5),
                                          Text(
                                            "Due 23/07/2021",
                                            style: txtS(Colors.black, 14,
                                                FontWeight.w300),
                                          ),
                                        ]),
                                    SizedBox(width: b * 20),
                                    Icon(Icons.calendar_today_outlined,
                                        size: b * 45),
                                    Spacer(),
                                    Icon(Icons.arrow_right_alt, size: b * 30)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    sh(40),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: b * 25, vertical: h * 15),
                            width: b * 300,
                            decoration: BoxDecoration(
                              color: Color(0xffd8d1ea),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(b * 40),
                                topRight: Radius.circular(b * 25),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bulletin Board",
                                  style:
                                      txtS(Colors.black, 20, FontWeight.w500),
                                ),
                                sh(10),
                                Row(
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Event Name",
                                            style: txtS(Colors.black, 16,
                                                FontWeight.w400),
                                          ),
                                          sh(5),
                                          Text(
                                            "23/07/2021  4:30 PM",
                                            style: txtS(Colors.black, 14,
                                                FontWeight.w300),
                                          ),
                                          sh(5),
                                          Text(
                                            "Place of Event",
                                            style: txtS(Colors.black, 12,
                                                FontWeight.w300),
                                          ),
                                        ]),
                                    SizedBox(width: b * 20),
                                    Icon(Icons.event, size: b * 50),
                                    Spacer(),
                                    Icon(Icons.arrow_right_alt, size: b * 30)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 812);
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 375,
    );
  }
}
