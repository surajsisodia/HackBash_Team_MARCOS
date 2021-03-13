import 'package:IIIT_Surat_Connect/results/bar_chart_demo.dart';
import 'package:flutter/material.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    List grades = ['AA', 'AB', 'BB', 'BC', 'CC', 'CD', 'DD', 'FF'];
    List colors = [
      Color(0xff15ae37),
      Color(0xff6adc83),
      Color(0xffd0d321),
      Color(0xffe27f24),
      Color(0xffff4d00),
      Color(0xffe0503c),
      Color(0xffd6271c),
      Color(0xffff0000),
    ];
    //name must be in 4 characters only
    List subjectNames = ['uCon', 'DCom', 'ACir', 'EMag', 'CNet', 'OSys'];

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
            "Results",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        body: Stack(children: [
          Positioned(
            top: h * 0,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "8.5",
                        style: txtS(Colors.black, 45, FontWeight.w200),
                      ),
                      Text(
                        "CGPA",
                        style: txtS(Colors.black, 16, FontWeight.w600),
                      ),
                    ],
                  ),
                  sh(20),
                  BarChartDemo(),
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
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        "First Semester",
                        style: txtS(Colors.black, 18, FontWeight.w600),
                      ),
                      children: <Widget>[
                        sh(20),
                        GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.2,
                            ),
                            itemCount: 6,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Container(
                                width: b * 100,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        subjectNames[index],
                                        style: txtS(
                                            Colors.black, 16, FontWeight.w500),
                                      ),
                                      cont("AB", colors[index]),
                                    ]),
                              );
                            }),
                      ],
                    ),
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
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        "Second Semester",
                        style: txtS(Colors.black, 18, FontWeight.w600),
                      ),
                      children: <Widget>[
                        sh(20),
                        GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.2,
                              crossAxisSpacing: b * 10,
                            ),
                            itemCount: 6,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Subject",
                                      style: txtS(
                                          Colors.black, 16, FontWeight.w500),
                                    ),
                                    cont("AB", colors[index]),
                                  ]);
                            }),
                      ],
                    ),
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
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        "Third Semester",
                        style: txtS(Colors.black, 18, FontWeight.w600),
                      ),
                      children: <Widget>[],
                    ),
                  ),
                  sh(20),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Container cont(String grade, Color col) {
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    return Container(
      alignment: Alignment.center,
      height: h * 90,
      width: b * 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: col,
      ),
      child: CircleAvatar(
        radius: b * 27,
        backgroundColor: Colors.white,
        child: Text(
          grade,
          style: txtS(Colors.black, 16, FontWeight.w700),
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

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 812);
  }
}
