import 'package:IIIT_Surat_Connect/Academics%20Resources/academicResources.dart';
import 'package:IIIT_Surat_Connect/Assignment/assignment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';
import 'canteenMenu.dart';

class DrawerCode extends StatefulWidget {
  _DrawerCodeState createState() => _DrawerCodeState();
}

class _DrawerCodeState extends State<DrawerCode> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    return Drawer(
      child: ListView(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 10),
          height: h * 170,
          width: b * 301,
          decoration: BoxDecoration(
            color: bc,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(b * 30),
            ),
          ),
          child: StreamBuilder(
            stream: _firestore
                .collection('studentUsers')
                .where('email', isEqualTo: _auth.currentUser.email)
                .snapshots(),
            builder: (context, snapshot) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: pc,
                  radius: b * 78 / 2,
                  child: !snapshot.hasData
                      ? Container()
                      : CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              snapshot.data.docs[0].data()['photoUrl'] == null
                                  ? ''
                                  : snapshot.data.docs[0].data()['photoUrl'],
                          fadeInDuration: Duration(microseconds: 0),
                          fadeOutDuration: Duration(microseconds: 0),
                          placeholder: (context, url) => Container(),
                        ),
                ),
                sh(8),
                Text(
                  !snapshot.hasData ? '' : snapshot.data.docs[0].data()['name'],
                  style: txtS(Colors.white, 16, FontWeight.w300),
                ),
                sh(4),
                Text(
                  !snapshot.hasData
                      ? ''
                      : snapshot.data.docs[0].data()['email'],
                  style: txtS(Colors.white, 14, FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
        sh(30),
        row(Icons.lock_clock, "Time-Table", null),
        row(Icons.school, "Schedule", null),
        row(Icons.book, "Academic Resources", () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => Academics()));
        }),
        row(Icons.bookmark_sharp, "Assignments", () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => Assignment()));
        }),
        row(Icons.shopping_basket, "Buy/Sell", null),
        row(Icons.restaurant, "Canteen Menu", () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Canteen()));
        }),
        row(Icons.book_online, "Results", null),
        row(Icons.person, "Profile", null),
        row(Icons.logout, "Logout", null),
        row(Icons.share, "Share", null),
        row(Icons.info, "About", null),
      ]),
    );
  }

  InkWell row(ic, String tit, Function fn) {
    return InkWell(
      splashColor: pc,
      onTap: fn,
      child: Container(
        height: SizeConfig.screenHeight * 50 / 812,
        child: Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 20 / 375),
            Icon(ic,
                color: Colors.black, size: SizeConfig.screenWidth * 22 / 375),
            SizedBox(width: SizeConfig.screenWidth * 20 / 375),
            Text(
              tit,
              style: txtS(Colors.black, 18, FontWeight.w300),
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
