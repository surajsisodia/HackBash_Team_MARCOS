import 'package:IIIT_Surat_Connect/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:IIIT_Surat_Connect/Utils/SizeConfig.dart';

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
                height: h * 136,
                width: b * 125,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(b * 10),
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
                        'IIIT SURAT CONNECT',
                        style: txtS(bc, 24, FontWeight.w400),
                      ),
                    ],
                  ),
                  sh(10),
                  Text(
                    'Acha sa description. Acha sa description. Acha sa description. Acha sa description. Acha sa Acha sa description. Acha sa description. Acha sa Acha sa description. Acha sa description.Acha sa Acha sa description.Acha sa description.Acha sa Acha sa ',
                    style: txtS(bc, 14, FontWeight.w400),
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
