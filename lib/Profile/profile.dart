import 'package:IIIT_Surat_Connect/aboutUs.dart';
import 'package:IIIT_Surat_Connect/Academics Resources/academicResources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authScreens/login.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import '../drawer.dart';

class Profile extends StatefulWidget {
  final String userName;
  final String email;
  Profile({
    this.userName,
    this.email,
  });
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences preferences;
  String userName = "";
  String userPhone = "";
  String address = "";
  String email = "";
  bool isPhone = false;
  bool isName = false;
  bool isPass = false;

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
    return SafeArea(
      child: Scaffold(
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
            "Profile",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        drawer: DrawerCode(),
        backgroundColor: bc,
        body: Stack(
          children: [
            Positioned(
              bottom: h * 0,
              child: Container(
                height: h * 550,
                width: b * 375,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(b * 75),
                    topRight: Radius.circular(b * 75),
                  ),
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: b * 20),
                  children: [
                    sh(80),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: b * 15, vertical: h * 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ico(Icons.person_outline),
                          SizedBox(width: b * 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                !isName ? 'Name' : 'Change Name',
                                style:
                                    txtS(isName ? bc : pc, 14, FontWeight.w500),
                              ),
                              sh(3),
                              isName
                                  ? Container(
                                      width: b * 225,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        style: txtS(
                                            textColor, 15, FontWeight.w500),
                                        decoration: dec('Enter Your Name'),
                                      ),
                                    )
                                  : Text(
                                      "Ritesh Shukla",
                                      style:
                                          txtS(textColor, 16, FontWeight.w400),
                                    ),
                              isName ? butt(null) : SizedBox(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isName = !isName;
                                  });
                                },
                                child: ediB(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: b * 17, vertical: h * 11),
                      width: b * 335,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            color: bc,
                            size: b * 18,
                          ),
                          SizedBox(width: b * 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                isPhone ? 'Change Number' : 'Number',
                                style: txtS(
                                    isPhone ? bc : pc, 14, FontWeight.w500),
                              ),
                              sh(3),
                              isPhone
                                  ? Container(
                                      width: b * 225,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        style: txtS(
                                            textColor, 15, FontWeight.w500),
                                        decoration: dec('Phone Number'),
                                      ),
                                    )
                                  : Text(
                                      "6387246025",
                                      style:
                                          txtS(textColor, 16, FontWeight.w400),
                                    ),
                              isPhone ? butt(null) : SizedBox(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isPhone = !isPhone;
                                  });
                                },
                                child: ediB(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: b * 17, vertical: h * 11),
                      width: b * 335,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock_outlined,
                            color: bc,
                            size: b * 18,
                          ),
                          SizedBox(width: b * 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                isPass ? 'Change PassWord' : 'Password',
                                style:
                                    txtS(isPass ? bc : pc, 14, FontWeight.w500),
                              ),
                              sh(3),
                              isPass
                                  ? Column(children: [
                                      Container(
                                        width: b * 225,
                                        child: TextField(
                                          obscureText: true,
                                          style: txtS(
                                              textColor, 15, FontWeight.w500),
                                          decoration: dec('Old Password'),
                                        ),
                                      ),
                                      sh(10),
                                      Container(
                                        width: b * 225,
                                        child: TextField(
                                          obscureText: true,
                                          style: txtS(
                                              textColor, 15, FontWeight.w500),
                                          decoration: dec('New Password'),
                                        ),
                                      ),
                                    ])
                                  : Text(
                                      "**********",
                                      style:
                                          txtS(textColor, 16, FontWeight.w400),
                                    ),
                              isPass ? butt(null) : SizedBox(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isPass = !isPass;
                                  });
                                },
                                child: ediB(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: b * 15, vertical: h * 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ico(Icons.engineering_outlined),
                          SizedBox(width: b * 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Enrollment Number',
                                style: txtS(pc, 14, FontWeight.w500),
                              ),
                              sh(6),
                              Text(
                                "UI19EC39",
                                style: txtS(bc, 16, FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: b * 15, vertical: h * 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ico(Icons.location_city_outlined),
                          SizedBox(width: b * 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Department',
                                style: txtS(pc, 14, FontWeight.w500),
                              ),
                              sh(3),
                              Text(
                                "Electronics and Communication",
                                style: txtS(bc, 15, FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: b * 15, vertical: h * 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ico(Icons.school_outlined),
                          SizedBox(width: b * 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Semester',
                                style: txtS(pc, 14, FontWeight.w500),
                              ),
                              sh(3),
                              Text(
                                "4th",
                                style: txtS(bc, 16, FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    sh(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {
                            logOut();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: b * 25),
                            height: h * 60,
                            width: b * 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(b * 10),
                              color: bc,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 16 * b,
                                ),
                                SizedBox(width: b * 17),
                                Text(
                                  'Log Out',
                                  style:
                                      txtS(Colors.white, 16, FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: SizeConfig.screenWidth * 0.5 - b * 138 / 2,
              bottom: h * 482.5,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: b * 138,
                    height: h * 138,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1603993097397-89c963e325c7?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: pc,
                        radius: SizeConfig.screenWidth * 20 / 375,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: SizeConfig.screenWidth * 20 / 375,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon ico(m) {
    return Icon(
      m,
      color: bc,
      size: SizeConfig.screenWidth / 375 * 16,
    );
  }

  Padding butt(Function fn) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth / 375 * 150,
          top: SizeConfig.screenHeight / 812 * 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth / 375 * 17,
            vertical: SizeConfig.screenHeight / 812 * 6,
          ),
          width: SizeConfig.screenWidth / 375 * 80,
          decoration: BoxDecoration(
            color: pc,
            borderRadius:
                BorderRadius.circular(SizeConfig.screenWidth / 375 * 18),
          ),
          child: Row(children: [
            Text(
              'Save',
              style: txtS(Colors.white, 12, FontWeight.w300),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: SizeConfig.screenWidth / 375 * 16,
            ),
          ]),
        ),
      ),
    );
  }

  Icon ediB() {
    return Icon(
      Icons.edit,
      color: bc,
      size: SizeConfig.screenWidth / 375 * 18,
    );
  }

  InputDecoration dec(String hin) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: bc,
          width: SizeConfig.screenWidth / 375 * 0.75,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: bc,
          width: SizeConfig.screenWidth * 0.75 / 375,
        ),
      ),
      hintText: hin,
      hintStyle: TextStyle(
        color: textColor,
        fontSize: SizeConfig.screenWidth / 375 * 14,
        fontWeight: FontWeight.w300,
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 9 / 896),
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

  logOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      await firebaseAuth.signOut().then((value) {
        preferences.setBool('isLoggedIn', false);
        preferences.clear();
        print("Signed Out");
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return Login();
        }), (route) => false);
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
