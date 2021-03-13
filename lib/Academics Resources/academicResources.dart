import 'package:flutter/material.dart';

import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'content.dart';

class Academics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    List colors = [
      Color(0xffe77373),
      Color(0xff4ed34c),
      Color(0xffd7e439),
      Color(0xffc2862c),
      Color(0xff56c4e7),
      Color(0xffd46bb7),
    ];
    List subjectNames = ['uC', 'DCom', 'AC', 'EMag', 'CN', 'OS'];

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
            "Academics",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        body: Stack(children: [
          Positioned(
            top: 0,
            child: Container(
              width: b * 375,
              height: h * 735,
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
                  sh(50),
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: b * 30,
                        mainAxisSpacing: h * 25,
                      ),
                      itemCount: 6,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return InkWell(
                          onTap: () {
                            //todo: uncomment this
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Content(
                                    name: subjectNames[index],
                                  ),
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: h * 25),
                            height: h * 140,
                            width: b * 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(b * 20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(0.25),
                                  blurRadius: 2,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              color: colors[index],
                            ),
                            child: Column(
                              children: [
                                sh(30),
                                Image.asset('images/${index + 1}.png'),
                                sh(10),
                                Text(
                                  subjectNames[index],
                                  style:
                                      txtS(Colors.black, 24, FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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
