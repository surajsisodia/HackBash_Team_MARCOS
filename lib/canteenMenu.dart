import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class Canteen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    List<menuList> itemList;

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
            "Canteen Menu",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        body: Container(
          width: b * 375,
          padding: EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 0),
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
          child: ListView(physics: BouncingScrollPhysics(), children: [
            sh(20),
            Text(
              "Category 1",
              style: txtS(Colors.black, 18, FontWeight.w500),
            ),
            sh(10),
            cont('category1'),
            sh(20),
            Text(
              "Category 2",
              style: txtS(Colors.black, 18, FontWeight.w500),
            ),
            sh(10),
            cont('category2'),
            sh(20),
            Text(
              "Category 3",
              style: txtS(Colors.black, 18, FontWeight.w500),
            ),
            sh(10),
            cont('category3'),
            sh(20),
            Text(
              "Category 4",
              style: txtS(Colors.black, 18, FontWeight.w500),
            ),
            sh(10),
            cont('category4'),
          ]),
        ),
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

  Widget cont(String category) {
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return FutureBuilder(
        future: _firestore.collection('canteenMenu').doc(category).get(),
        builder: (context, snapshot) => !snapshot.hasData
            ? Container()
            : Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data['items'].length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: b * 30, vertical: h * 5),
                      child: Row(children: [
                        Text(
                          snapshot.data['items'][index]['name'],
                          style: txtS(Colors.black, 14, FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          snapshot.data['items'][index]['price'],
                          style: txtS(Colors.black, 14, FontWeight.w300),
                        ),
                      ]),
                    );
                  },
                ),
              ));
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 812);
  }
}

//to call that for items
class menuList {
  String category;
  String name;
  String price;

  menuList(this.category, this.name, this.price);
}
