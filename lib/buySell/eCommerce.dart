import 'package:IIIT_Surat_Connect/buySell/productDetail.dart';
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
  List<String> mainImageList = List<String>();
  List<String> recentImageList = List<String>();
  List<String> calcImageList = List<String>();
  List<String> cycleImageList = List<String>();
  List<String> bookImageList = List<String>();

  Future<List> loadMainList() async {
    FirebaseFirestore.instance
        .collection('eCommerceProduct')
        .snapshots()
        .listen((snapshot) {
      List<QueryDocumentSnapshot> documentSnapshot = snapshot.docs;

      for (var i in documentSnapshot) {
        mainImageList.add(i.data()['image1']);
      }
    });

    return mainImageList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
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
            FutureBuilder(
                future: loadMainList(),
                builder: (context, snap) {
                  return CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        height: h * 190,
                        autoPlay: true,
                      ),
                      items: mainImageList.map((i) {
                        return Builder(builder: (BuildContext context) {
                          return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: h * 136,
                                    // margin:
                                    //     EdgeInsets.symmetric(vertical: h * 10),
                                    // padding: EdgeInsets.symmetric(
                                    //     horizontal: b * 40, vertical: h * 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(b * 15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffc9c9c9)
                                              .withOpacity(0.49),
                                          blurRadius: 20,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Image(
                                      image: NetworkImage(i),
                                      fit: BoxFit.fitWidth,
                                    )),
                              ]);
                        });
                      }).toList());
                }),
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
                  //cont(null, "Recent"),
                  sh(20),
                  Text(
                    "Calculators",
                    style: txtS(Colors.white, 18, FontWeight.w300),
                  ),
                  sh(20),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('eCommerceProduct')
                        .where('itemCategry', isEqualTo: 'Calculator')
                        .snapshots(),
                    builder: (context, snapshot) {
                      return Container(
                        width: SizeConfig.screenWidth / 375 * 375,
                        height: SizeConfig.screenHeight / 812 * 95,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.hasData) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AboutProduct(
                                        snapshot.data.docs[index]['itemUID']);
                                  }));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.screenWidth / 375 * 7),
                                  width: SizeConfig.screenWidth / 375 * 152,
                                  decoration: BoxDecoration(
                                    color: Color(0xffc4c4c4),
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.screenWidth / 375 * 10),
                                  ),
                                  child: Image(
                                      image: NetworkImage(
                                          snapshot.data.docs[index]['image1'])),
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      );
                    },
                  ),
                  sh(20),
                  Text(
                    "Cycles",
                    style: txtS(Colors.white, 18, FontWeight.w300),
                  ),
                  sh(20),
                  // StreamBuilder(
                  //   stream: FirebaseFirestore.instance
                  //       .collection('eCommerceProduct')
                  //       .where('itemCategry', isEqualTo: 'Cycle')
                  //       .snapshots(),
                  //   builder: (context, snapshot) {
                  //     return Container(
                  //       width: SizeConfig.screenWidth / 375 * 375,
                  //       height: SizeConfig.screenHeight / 812 * 95,
                  //       child: ListView.builder(
                  //         shrinkWrap: true,
                  //         scrollDirection: Axis.horizontal,
                  //         physics: BouncingScrollPhysics(),
                  //         padding: EdgeInsets.zero,
                  //         itemCount: snapshot.data.docs.length,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           if (snapshot.hasData) {
                  //             return InkWell(
                  //               child: Container(
                  //                 margin: EdgeInsets.symmetric(
                  //                     horizontal:
                  //                         SizeConfig.screenWidth / 375 * 7),
                  //                 width: SizeConfig.screenWidth / 375 * 152,
                  //                 decoration: BoxDecoration(
                  //                   color: Color(0xffc4c4c4),
                  //                   borderRadius: BorderRadius.circular(
                  //                       SizeConfig.screenWidth / 375 * 10),
                  //                 ),
                  //                 child: Image(
                  //                     image: NetworkImage(
                  //                         snapshot.data.docs[index]['image1'])),
                  //               ),
                  //             );
                  //           } else {
                  //             return CircularProgressIndicator();
                  //           }
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                  sh(20),
                  Text(
                    "Books",
                    style: txtS(Colors.white, 18, FontWeight.w300),
                  ),
                  sh(20),
                  //cont(null, "book"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FutureBuilder cont(List items, String category) {
  //   // list of items to be displayed based on the category provided
  //   return FutureBuilder(
  //     future: loadItemList(category),
  //     builder: (context, snapshot) {
  //       return Container(
  //         width: SizeConfig.screenWidth / 375 * 375,
  //         height: SizeConfig.screenHeight / 812 * 95,
  //         child: ListView.builder(
  //           shrinkWrap: true,
  //           scrollDirection: Axis.horizontal,
  //           physics: BouncingScrollPhysics(),
  //           padding: EdgeInsets.zero,
  //           itemCount: calcImageList.length,
  //           itemBuilder: (BuildContext ctxt, int index) {
  //             return Container(
  //               margin: EdgeInsets.symmetric(
  //                   horizontal: SizeConfig.screenWidth / 375 * 7),
  //               width: SizeConfig.screenWidth / 375 * 152,
  //               decoration: BoxDecoration(
  //                 color: Color(0xffc4c4c4),
  //                 borderRadius:
  //                     BorderRadius.circular(SizeConfig.screenWidth / 375 * 10),
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

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

  Future<List> loadRecentList() async {
    FirebaseFirestore.instance
        .collection('eCommerceProduct')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      List<QueryDocumentSnapshot> documentSnapshot = snapshot.docs;

      for (var i in documentSnapshot) {
        mainImageList.add(i.data()['image1']);
      }
    });

    return mainImageList;
  }

  Future<void> loadItemList(String itemcat) async {
    List<String> tempList = List<String>();
    FirebaseFirestore.instance
        .collection('eCommerceProduct')
        .where('itemCategory', isEqualTo: itemcat)
        .snapshots()
        .listen((snapshot) {
      List<QueryDocumentSnapshot> documentSnapshot = snapshot.docs;

      for (var i in documentSnapshot) {
        tempList.add(i.data()['image1']);
      }
    });

    if (itemcat == 'calc')
      calcImageList = tempList;
    else if (itemcat == 'cycle')
      cycleImageList = tempList;
    else
      bookImageList = tempList;
  }
}
