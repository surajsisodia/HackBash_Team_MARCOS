import 'package:IIIT_Surat_Connect/aboutUs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutProduct extends StatefulWidget {
  final String uid;
  AboutProduct(this.uid);
  _AboutProductState createState() => _AboutProductState();
}

class _AboutProductState extends State<AboutProduct> {
  SharedPreferences preferences;
  String userName = "";
  String userPhone = "";
  String address = "";
  String email = "";

  loadData() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      userName = preferences.getString("currentUserName");
      email = preferences.getString("currentUserEmail");

      if (preferences.containsKey("currentUserPhone")) {
        userPhone = preferences.getString("currentUserPhone");
      } else {
        userPhone = "Not Provided";
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    List imageItems = [
      'Remember that the happiest people are not those getting more, but those giving more.',
      'Since you get more joy out of giving joy to others, you should put a good deal of thought into the happiness that you are able to give.',
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
            "Product Name",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        body: Column(children: [
          Container(
            alignment: Alignment.center,
            height: h * 300,
            width: b * 375,
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
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.75,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                height: h * 270,
                autoPlay: true,
              ),
              items: imageItems.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: h * 230,
                      decoration: BoxDecoration(
                        color: bc,
                        borderRadius: BorderRadius.circular(b * 15),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: b * 20),
              width: b * 375,
              color: Colors.white,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  sh(50),
                  Text(
                    "Calculator",
                    style: txtS(Colors.black, 12, FontWeight.w300),
                  ),
                  Text(
                    "Casio 950X",
                    style: txtS(Colors.black, 20, FontWeight.w500),
                  ),
                  sh(5),
                  Text(
                    "\u{20B9} 500",
                    style: txtS(Color(0xff4cca1f), 20, FontWeight.w500),
                  ),
                  sh(15),
                  Text(
                    "Description",
                    style: txtS(Colors.black, 16, FontWeight.w500),
                  ),
                  sh(7),
                  Text(
                    "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description ",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: txtS(Colors.black, 13, FontWeight.w400),
                  ),
                  sh(15),
                  Text(
                    "Seller",
                    style: txtS(Colors.black, 16, FontWeight.w500),
                  ),
                  sh(10),
                  Text(
                    "Ritesh Shukla",
                    style: txtS(Colors.black, 14, FontWeight.w500),
                  ),
                  Text(
                    "2nd Year, ECE",
                    style: txtS(Colors.black, 13, FontWeight.w400),
                  ),
                  sh(15),
                  Text(
                    "Contact Details",
                    style: txtS(Colors.black, 16, FontWeight.w500),
                  ),
                  sh(10),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(Icons.call, color: bc, size: b * 18),
                        SizedBox(width: b * 10),
                        Text(
                          "6387246025",
                          style: txtS(Colors.black, 14, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  sh(5),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(Icons.mail, color: bc, size: b * 18),
                        SizedBox(width: b * 10),
                        Text(
                          "ui19ec39@iiitsurat.ac.in",
                          style: txtS(Colors.black, 14, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
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
