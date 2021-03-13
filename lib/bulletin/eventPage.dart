import 'package:IIIT_Surat_Connect/Utils/constants.dart';
import 'package:IIIT_Surat_Connect/aboutUs.dart';
import 'package:flutter/material.dart';
import 'package:IIIT_Surat_Connect/Utils/SizeConfig.dart';

class EventPage extends StatelessWidget {
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
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: pc,
                size: b * 20,
              ),
            );
          }),
          centerTitle: true,
          title: Text(
            "Events",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              sh(30),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth / 375 * 30),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                          child: eventCard('Orientation', '10 JAN', context));
                    }),
              ),
            ],
          ),
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

  Widget eventCard(String title, String date, BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    return Column(
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                  height: h * 730,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(b * 23),
                      topRight: Radius.circular(b * 23),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: h * 11),
                        height: h * 6,
                        width: b * 88,
                        decoration: BoxDecoration(
                          color: pc,
                          borderRadius: BorderRadius.circular(b * 20),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: h * 15),
                            height: h * 320,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1603993097397-89c963e325c7?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: b * 20, vertical: h * 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Event',
                                  style: txtS(pc, 14, FontWeight.w400),
                                ),
                                sh(10),
                                Text(
                                  'Orientation',
                                  style: txtS(bc, 18, FontWeight.w700),
                                ),
                                SizedBox(height: h * 10),
                                Text(
                                  'Date',
                                  style: txtS(pc, 14, FontWeight.w400),
                                ),
                                Text(
                                  '10 Jan 2020',
                                  style: txtS(bc, 17, FontWeight.w700),
                                ),
                                sh(10),
                                Text(
                                  'Time',
                                  style: txtS(pc, 14, FontWeight.w400),
                                ),
                                Text(
                                  '4 PM',
                                  style: txtS(bc, 16, FontWeight.w700),
                                ),
                                sh(10),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(b * 5),
                                  ),
                                  elevation: 5,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AboutPage(),
                                        ));
                                  },
                                  color: bc,
                                  textColor: Colors.white,
                                  child: Text(
                                    'Register',
                                    style:
                                        txtS(Colors.white, 14, FontWeight.w400),
                                  ),
                                ),
                                sh(10),
                                Text(
                                  'About',
                                  style: txtS(pc, 14, FontWeight.w600),
                                ),
                                SizedBox(
                                  height: h * 5,
                                ),
                                Text(
                                  "Hey Freshers! Is your weekly schedule swarmed only with lectures and tests? Well, you know what they say - When the going gets tough,take a much deserved breather. Save the date fellas as wecommence our adventure through the amazing world of development. It's gonna be a long road ahead, but we promise it's not gonna be bumpy at all. So Ready.? Set... Dev!!",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 6,
                                  style: txtS(bc, 13, FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            );
          },
          child: Container(
              height: h * 310,
              width: b * 310,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(2, 4),
                  )
                ],
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1603993097397-89c963e325c7?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(b * 20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(b * 20),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.pink.withOpacity(0.2),
                      Colors.black54,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 15, right: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(b * 12),
                        ),
                        height: h * 70,
                        width: b * 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '10',
                              style: txtS(bc, 18, FontWeight.w700),
                            ),
                            Text(
                              'JAN',
                              style: txtS(bc, 17, FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: SizeConfig.screenWidth / 375 * 10,
                          bottom: 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Orientation',
                              style: txtS(Colors.white, 24, FontWeight.w700),
                            ),
                            sh(5),
                            Text(
                              'DSC IIIT SURAT',
                              style: txtS(Colors.white, 14, FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
        sh(30),
      ],
    );
  }
}
