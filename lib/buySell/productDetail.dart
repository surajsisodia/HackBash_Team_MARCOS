import 'dart:async';

import 'package:IIIT_Surat_Connect/aboutUs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutProduct extends StatefulWidget {
  final String uid;
  AboutProduct(this.uid);
  _AboutProductState createState() => _AboutProductState();
}

class _AboutProductState extends State<AboutProduct> {
  String cat = "old";
  String title = "";
  String des = "";
  String price = "";
  String sellerName = "";
  String sellerPhone = "";
  String sellerEmail = "";
  List<String> imageItems = List<String>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    FirebaseFirestore.instance
        .collection('eCommerceProduct')
        .where('itemUID', isEqualTo: widget.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        cat = event.docs[0].data()['itemCategry'];
        title = event.docs[0].data()['itemTitle'];
        des = event.docs[0].data()['itemDes'];
        price = event.docs[0].data()['itemSell'];
        sellerEmail = event.docs[0].data()['sellerEmail'];
        sellerPhone = event.docs[0].data()['sellerContact'];

        imageItems.add(event.docs[0].data()['image1']);
        imageItems.add(event.docs[0].data()['image2']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    print(widget.uid);
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
            "Product Name",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        body: Column(children: [
          Container(
            alignment: Alignment.center,
            height: h * 300,
            width: b * 375,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(b * 40),
                topRight: Radius.circular(b * 40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffc9c9c9).withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.75,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                height: h * 270,
                autoPlay: true,
              ),
              items: imageItems.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: h * 230,
                      decoration: BoxDecoration(
                        color: bc,
                        borderRadius: BorderRadius.circular(b * 15),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: i,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: b * 20),
              width: b * 375,
              color: Colors.white,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  sh(50),
                  Text(
                    cat,
                    style: txtS(Colors.black, 12, FontWeight.w300),
                  ),
                  Text(
                    title,
                    style: txtS(Colors.black, 20, FontWeight.w500),
                  ),
                  sh(5),
                  Text(
                    "\u{20B9} $price",
                    style: txtS(Color(0xff4cca1f), 20, FontWeight.w500),
                  ),
                  sh(15),
                  Text(
                    "Description",
                    style: txtS(Colors.black, 16, FontWeight.w500),
                  ),
                  sh(7),
                  Text(
                    des,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: txtS(Colors.black, 13, FontWeight.w400),
                  ),
                  sh(15),
                  Text(
                    "Seller",
                    style: txtS(Colors.black, 16, FontWeight.w500),
                  ),
                  sh(10),
                  Text(
                    "Ritesh Shukla",
                    style: txtS(Colors.black, 14, FontWeight.w500),
                  ),
                  Text(
                    "2nd Year, ECE",
                    style: txtS(Colors.black, 13, FontWeight.w400),
                  ),
                  sh(15),
                  Text(
                    "Contact Details",
                    style: txtS(Colors.black, 16, FontWeight.w500),
                  ),
                  sh(10),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(Icons.call, color: bc, size: b * 18),
                        SizedBox(width: b * 10),
                        Text(
                          sellerPhone,
                          style: txtS(Colors.black, 14, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  sh(5),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(Icons.mail, color: bc, size: b * 18),
                        SizedBox(width: b * 10),
                        Text(
                          sellerEmail,
                          style: txtS(Colors.black, 14, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
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
