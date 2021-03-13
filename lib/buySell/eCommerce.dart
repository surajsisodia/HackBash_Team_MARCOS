import 'package:IIIT_Surat_Connect/buySell/sellPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import '../drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ECommerce extends StatefulWidget {
  _ECommerceState createState() => _ECommerceState();
}

class _ECommerceState extends State<ECommerce> {
  SharedPreferences preferences;
  String userName = "";
  String userPhone = "";
  String address = "";
  String email = "";

  loadData() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      userName = preferences.getString("currentUserName");
      email = preferences.getString("currentUserEmail");

      if (preferences.containsKey("currentUserPhone")) {
        userPhone = preferences.getString("currentUserPhone");
      } else {
        userPhone = "Not Provided";
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (contexr) {
              return Sell();
            }));
          },
          icon: null,
          backgroundColor: pc,
          label: Container(
            alignment: Alignment.center,
            width: b * 140,
            child: Text(
              "Sell",
              style: txtS(Colors.white, 24, FontWeight.w600),
            ),
          ),
        ),
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
            "E-Commerce",
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
              items: quoteItems.map((i) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('eCommerceProduct')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                                    offset: Offset(0, 6)),
                              ],
                            ),
                            child: FadeInImage(
                              image: NetworkImage(snapshot.data('image1')),
                            ))
                      ],
                    );
                  },
                );
                // return Builder(
                //   builder: (BuildContext context) {
                //     return Column(mainAxisSize: MainAxisSize.min, children: [
                //       Container(
                //         alignment: Alignment.center,
                //         height: h * 136,
                //         margin: EdgeInsets.symmetric(vertical: h * 10),
                //         padding: EdgeInsets.symmetric(
                //             horizontal: b * 40, vertical: h * 10),
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(b * 15),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Color(0xffc9c9c9).withOpacity(0.49),
                //               blurRadius: 20,
                //               offset: Offset(0, 6),
                //             ),
                //           ],
                //         ),
                //         child: Text(
                //           '$i',
                //           textAlign: TextAlign.center,
                //           style: txtS(textColor, 14, FontWeight.w500),
                //         ),
                //       ),
                //     ]);
                //   },
                // );
              }).toList(),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: b * 10),
                physics: BouncingScrollPhysics(),
                children: [
                  Text(
                    "Recently Arrived",
                    style: txtS(Colors.white, 18, FontWeight.w300),
                  ),
                  sh(20),
                  cont(null, "Recent"),
                  sh(20),
                  Text(
                    "Calculators",
                    style: txtS(Colors.white, 18, FontWeight.w300),
                  ),
                  sh(20),
                  cont(null, "Caluclators"),
                  sh(20),
                  Text(
                    "Cycles",
                    style: txtS(Colors.white, 18, FontWeight.w300),
                  ),
                  sh(20),
                  cont(null, "Cycles"),
                  sh(20),
                  Text(
                    "Books",
                    style: txtS(Colors.white, 18, FontWeight.w300),
                  ),
                  sh(20),
                  cont(null, "Books"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container cont(List items, String category) {
    // list of items to be displayed based on the category provided
    return Container(
      width: SizeConfig.screenWidth / 375 * 375,
      height: SizeConfig.screenHeight / 812 * 95,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 6,
        itemBuilder: (BuildContext ctxt, int index) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth / 375 * 7),
            width: SizeConfig.screenWidth / 375 * 152,
            decoration: BoxDecoration(
              color: Color(0xffc4c4c4),
              borderRadius:
                  BorderRadius.circular(SizeConfig.screenWidth / 375 * 10),
            ),
          );
        },
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
