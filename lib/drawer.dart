import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class DrawerCode extends StatefulWidget {
  final String userName;
  final String email;
  DrawerCode({
    this.userName,
    this.email,
  });
  _DrawerCodeState createState() => _DrawerCodeState();
}

class _DrawerCodeState extends State<DrawerCode> {
  SharedPreferences preferences;
  String userName = "";
  String userPhone = "";
  String address = "";
  String email = "";

  loadData() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      if (preferences.getString('currentUserName') == null)
        userName = preferences.getString('currentUserUiNumber').toUpperCase();
      else
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
    return Drawer(
      child: ListView(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 10),
          height: h * 170,
          width: b * 301,
          decoration: BoxDecoration(
            color: bc,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(b * 30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: pc,
                radius: b * 78 / 2,
              ),
              sh(8),
              Text(
                "Ritesh Shukla",
                style: txtS(Colors.white, 16, FontWeight.w300),
              ),
              sh(4),
              Text(
                "ui19ec39@iiitsurat.ac.in",
                style: txtS(Colors.white, 14, FontWeight.w200),
              ),
            ],
          ),
        ),
        sh(30),
        row(Icons.lock_clock, "Time-Table", null),
        row(Icons.school, "Schedule", null),
        row(Icons.book, "Academic Resources", null),
        row(Icons.bookmark_sharp, "Assignments", null),
        row(Icons.shopping_basket, "Buy/Sell", null),
        row(Icons.restaurant, "Canteen Menu", null),
        row(Icons.book_online, "Results", null),
        row(Icons.person, "Profile", null),
        row(Icons.logout, "Logout", null),
        row(Icons.share, "Share", null),
        row(Icons.info, "About", null),
      ]),
    );
  }

  InkWell row(ic, String tit, Function fn) {
    return InkWell(
      splashColor: pc,
      onTap: () {},
      child: Container(
        height: SizeConfig.screenHeight * 50 / 812,
        child: Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 20 / 375),
            Icon(ic,
                color: Colors.black, size: SizeConfig.screenWidth * 22 / 375),
            SizedBox(width: SizeConfig.screenWidth * 20 / 375),
            Text(
              tit,
              style: txtS(Colors.black, 18, FontWeight.w300),
            ),
          ],
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
