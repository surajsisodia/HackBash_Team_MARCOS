import 'package:IIIT_Surat_Connect/Utils/SizeConfig.dart';
import 'package:IIIT_Surat_Connect/Utils/constants.dart';
import 'package:IIIT_Surat_Connect/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bc,
        drawer: DrawerCode(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bc,
          leading: Builder(builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                MdiIcons.sortVariant,
                color: pc,
                size: b * 24,
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
              FutureBuilder(
                future:
                    _firestore.collection('events').doc('customEvents').get(),
                builder: (context, snapshot) => Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth / 375 * 30),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: !snapshot.hasData
                          ? 0
                          : snapshot.data['events'].length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: !snapshot.hasData
                                ? Container()
                                : eventCard(
                                    context: context,
                                    title: snapshot.data['events'][index]
                                        ['name'],
                                    organiser: snapshot.data['events'][index]
                                        ['organiser'],
                                    link: snapshot.data['events'][index]
                                        ['registrationLink'],
                                    date: snapshot.data['events'][index]
                                        ['date'],
                                    time: snapshot.data['events'][index]
                                        ['time'],
                                    description: snapshot.data['events'][index]
                                        ['about'],
                                    image: snapshot.data['events'][index]
                                        ['coverImage']));
                      }),
                ),
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

  Widget eventCard(
      {String title,
      String date,
      String time,
      String organiser,
      String description,
      String image,
      String link,
      BuildContext context}) {
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
                                image: NetworkImage(image),
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
                                  title,
                                  style: txtS(bc, 18, FontWeight.w700),
                                ),
                                SizedBox(height: h * 10),
                                Text(
                                  'Date',
                                  style: txtS(pc, 14, FontWeight.w400),
                                ),
                                Text(
                                  date,
                                  style: txtS(bc, 17, FontWeight.w700),
                                ),
                                sh(10),
                                Text(
                                  'Time',
                                  style: txtS(pc, 14, FontWeight.w400),
                                ),
                                Text(
                                  time,
                                  style: txtS(bc, 16, FontWeight.w700),
                                ),
                                sh(10),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(b * 5),
                                  ),
                                  elevation: 5,
                                  onPressed: () async {
                                    await canLaunch(link)
                                        ? await launch(link)
                                        : throw 'Could not launch $link';
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
                                  description,
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
                  image: NetworkImage(image),
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
                              date[0] + date[1],
                              style: txtS(bc, 18, FontWeight.w700),
                            ),
                            Text(
                              date[3] + date[4] + date[5],
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
                              title,
                              style: txtS(Colors.white, 24, FontWeight.w700),
                            ),
                            sh(5),
                            Text(
                              organiser,
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
