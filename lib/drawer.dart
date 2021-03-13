import 'package:IIIT_Surat_Connect/Academics%20Resources/academicResources.dart';
import 'package:IIIT_Surat_Connect/Assignment/assignment.dart';
import 'package:IIIT_Surat_Connect/aboutUs.dart';
import 'package:IIIT_Surat_Connect/attendance/attendance.dart';
import 'package:IIIT_Surat_Connect/buySell/eCommerce.dart';
import 'package:IIIT_Surat_Connect/canteenMenu.dart';
import 'package:IIIT_Surat_Connect/facultyContact.dart';
import 'package:IIIT_Surat_Connect/mainMenu.dart';
import 'package:IIIT_Surat_Connect/results/results.dart';
import 'package:IIIT_Surat_Connect/timeTable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';
import 'authScreens/login.dart';

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
        sh(5),
        row(Icons.home, "Home", Home()),
        row(Icons.assignment, "Assignments", Assignment()),
        row(Icons.event, "Time-Table", TimeTable()),
        Container(height: h * 0.15, color: bc),
        row(Icons.school, "Attendance", Attendance()),
        row(Icons.book, "Academic Resources", Academics()),
        row(Icons.book_online, "Results", Results()),
        Container(height: h * 0.15, color: bc),
        row(Icons.shopping_cart_rounded, "Buy/Sell", ECommerce()),
        row(Icons.contact_mail, "Admin Contact", FacultyContact()),
        row(Icons.restaurant, "Canteen Menu", Canteen()),
        Container(height: h * 0.15, color: bc),
        row(Icons.logout, "Logout", null),
        row(Icons.info, "About", AboutPage()),
      ]),
    );
  }

  InkWell row(ic, String tit, dynamic nextPage) {
    return InkWell(
      splashColor: pc,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return nextPage;
        }));
      },
      child: Container(
        height: SizeConfig.screenHeight * 47 / 812,
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

  void logOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      await firebaseAuth.signOut().then((value) {
        preferences.setBool('isLoggedIn', false);
        preferences.remove('currentUserName');
        preferences.remove('currentUserPhone');
        preferences.remove('currentUserEmail');
        print("Signed Out");
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
            return Login();
          }),
          (route) => false,
        );
      }).catchError((e) {
        print(e);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
