import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class FacultyContact extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getData(String kiska) async {
    var ss = await _firestore.collection('facultyContacts').doc(kiska).get();
    return ss.data();
  }

  FutureBuilder contactTile(String kaun) {
    return FutureBuilder(
        future: getData(kaun),
        builder: (context, snapshot) => !snapshot.hasData
            ? Container()
            : colu(kaun, snapshot.data['email'],
                snapshot.data['number'].toString(), () {}, () {}));
  }

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
            "Faculty Contact",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        body: Stack(children: [
          Positioned(
            top: h * 55,
            child: Container(
              width: b * 375,
              height: h * 700,
              padding:
                  EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 0),
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
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  sh(150),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Faculty Members",
                      style: txtS(Colors.black, 18, FontWeight.w600),
                    ),
                    children: <Widget>[
                      contactTile('Director'),
                      sh(20),
                      contactTile('Gopal Aggarwal'),
                      sh(20),
                      contactTile('Director'),
                      sh(20),
                      contactTile('Gopal Aggarwal'),
                      sh(20),
                    ],
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Club Coordinators",
                      style: txtS(Colors.black, 18, FontWeight.w600),
                    ),
                    children: <Widget>[
                      contactTile('Director'),
                      sh(20),
                      contactTile('Gopal Aggarwal'),
                      sh(20),
                      contactTile('Director'),
                      sh(20),
                      contactTile('Gopal Aggarwal'),
                      sh(20),
                    ],
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      "Administration Contact",
                      style: txtS(Colors.black, 18, FontWeight.w600),
                    ),
                    children: <Widget>[
                      contactTile('Director'),
                      sh(20),
                      contactTile('Gopal Aggarwal'),
                      sh(20),
                      contactTile('Director'),
                      sh(20),
                      contactTile('Gopal Aggarwal'),
                      sh(20),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 12),
              margin: EdgeInsets.symmetric(horizontal: b * 25),
              height: h * 190,
              width: b * 325,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(b * 27),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border.all(color: pc, width: b * 1),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  contactTile('Director'),
                  sh(20),
                  contactTile('Gopal Aggarwal'),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Column colu(String name, String email, String phone, Function emailSend,
      Function calling) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: txtS(Colors.black, 16, FontWeight.w600),
        ),
        sh(7),
        InkWell(
          onTap: () {}, //email function
          child: Row(
            children: [
              Icon(Icons.mail,
                  color: Colors.black, size: SizeConfig.screenWidth * 15 / 375),
              SizedBox(width: SizeConfig.screenWidth * 10 / 375),
              Text(
                email,
                style: txtS(Colors.black, 14, FontWeight.w400),
              ),
            ],
          ),
        ),
        sh(5),
        InkWell(
          onTap: () {}, //calling function
          child: Row(
            children: [
              Icon(Icons.call,
                  color: Colors.black, size: SizeConfig.screenWidth * 15 / 375),
              SizedBox(width: SizeConfig.screenWidth * 10 / 375),
              Text(
                phone,
                style: txtS(Colors.black, 14, FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
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

class Contact {
  final String nameIncharge;
  final String phoneNumber;
  final String email;

  Contact(this.nameIncharge, this.phoneNumber, this.email);
}

// isko call krna haiiiii
List<Contact> contacts = [
  Contact(
    'Director',
    '6387246205',
    'ui19ec39@iiitsurat.ac.in',
  ),
];
