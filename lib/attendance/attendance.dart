import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';

class Attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    var xxx = [
      20.0,
      70.0,
      76.0,
      56.0,
      67.0,
      78.0,
      86.6,
      87.0,
      78.0,
      56.0,
      36.0
    ];

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
            "Attendance",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        body: Stack(children: [
          Positioned(
            top: h * 75,
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
                  sh(100),
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: SizeConfig.screenWidth * 33 / 375,
                      ),
                      itemCount: 11,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: h * 25),
                          height: h * 140,
                          width: b * 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(b * 20),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(0.15),
                                blurRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: pc, width: b * 1),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              sh(10),
                              Text(
                                "Subject",
                                style: txtS(Colors.black, 16, FontWeight.w600),
                              ),
                              sh(10),
                              SizedBox(
                                width: 75,
                                height: 75,
                                child: liq(xxx[index]),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 12),
              margin: EdgeInsets.symmetric(horizontal: b * 25),
              height: h * 100,
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
              child: Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag, color: Colors.black, size: b * 15),
                        SizedBox(width: b * 10),
                        Text(
                          "Goal",
                          style: txtS(Colors.black, 15, FontWeight.w600),
                        ),
                        Text(
                          ": 75%",
                          style: txtS(pc, 15, FontWeight.w600),
                        ),
                      ],
                    ),
                    sh(10),
                    Row(
                      children: [
                        Icon(Icons.flag, color: Colors.black, size: b * 15),
                        SizedBox(width: b * 10),
                        Text(
                          "Overall Attendance",
                          style: txtS(Colors.black, 15, FontWeight.w600),
                        ),
                        Text(
                          ": 80.87%",
                          style: txtS(pc, 15, FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: b * 60,
                  height: h * 68,
                  child: liq(Random().nextInt(50) + 50.0),
                ),
              ]),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.center,
              width: b * 375,
              child: Text(
                "15th March 2021",
                style: txtS(Colors.white, 16, FontWeight.w400),
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

  LiquidCircularProgressIndicator liq(double percentage) {
    return LiquidCircularProgressIndicator(
      value: percentage / 100,
      borderWidth: 2,
      borderColor: Colors.grey[400],
      backgroundColor: Colors.grey[200],
      center: Text(
        "$percentage %",
        style: txtS(Colors.black, 14, FontWeight.w600),
      ),
      valueColor: AlwaysStoppedAnimation(
          percentage < 75 ? Colors.red[400] : Colors.green),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 812);
  }
}
