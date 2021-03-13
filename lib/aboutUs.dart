import 'Utils/constants.dart';
import 'package:flutter/material.dart';
import 'Utils/SizeConfig.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bc,
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
            "About",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        body: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(b * 40),
              topRight: Radius.circular(b * 40),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: h * 15),
                padding: EdgeInsets.fromLTRB(b * 15, h * 15, b * 15, h * 15),
                height: h * 150,
                width: b * 130,
                decoration: BoxDecoration(
                  color: bc,
                  borderRadius: BorderRadius.circular(b * 10),
                ),
                child: Image.asset(
                  'images/co.png',
                  height: h * 100,
                  width: b * 100,
                ),
              ),
              SizedBox(height: h * 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(color: bc, height: h * 25, width: b * 4),
                      SizedBox(width: b * 5),
                      Text(
                        'ConJoin',
                        style: txtS(bc, 24, FontWeight.w500),
                      ),
                    ],
                  ),
                  sh(20),
                  Text(
                    'ConJoin is a cross platform mobile application that is super handy for a college student. The basic idea is that a student faces a lot of challenges in accomplishing various tasks of a college and the being updated with everything that\'s happening around is a Herculean task. The students can get access to almost everything they need in a college be it important notifications regarding any events, results, timetable, assignments or even getting any sort of academic resources they would ever want. The students can even sell old goods to the others who need. Well, tons of issues; and solution is just a tap.',
                    style: txtS(bc, 15, FontWeight.w400),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(color: bc, height: h * 25, width: b * 4),
                      SizedBox(width: b * 5),
                      Text(
                        'Designed and Developed By:',
                        style: txtS(Colors.black, 20, FontWeight.w600),
                      ),
                    ],
                  ),
                  sh(5),
                  Row(
                    children: [
                      Text(
                        'Team',
                        style: txtS(Colors.black, 18, FontWeight.w400),
                      ),
                      SizedBox(width: b * 5),
                      Text(
                        'MARCOS',
                        style: txtS(Colors.black, 18, FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              sh(10),
            ],
          ),
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
