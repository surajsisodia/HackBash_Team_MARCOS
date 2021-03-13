import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'signUp.dart';
import 'package:google_fonts/google_fonts.dart';
import '../drawer.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisible = false;

  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwdEditingController = TextEditingController();
  SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: SafeArea(
        child: Scaffold(
          drawer: DrawerCode(),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: b * 20),
                    height: h * 540,
                    width: b * 375,
                    decoration: BoxDecoration(
                      color: bc,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(b * 50),
                        bottomRight: Radius.circular(b * 50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sh(49),
                        Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontSize: b * 96,
                          ),
                        ),
                        sh(30),
                        Padding(
                          padding: EdgeInsets.only(left: b * 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email ID',
                                style: txtS(Colors.white, 16, FontWeight.w300),
                              ),
                              sh(11),
                              Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: b * 23),
                                height: h * 50,
                                width: 280 * b,
                                decoration: BoxDecoration(
                                  color: Color(0xffd8d1ea),
                                  borderRadius: BorderRadius.circular(b * 100),
                                ),
                                child: TextField(
                                  controller: emailTextController,
                                  style: txtS(brc, 16, FontWeight.w400),
                                  decoration: dec('Your Email ID'),
                                ),
                              ),
                              sh(30),
                              Text(
                                'Password',
                                style: txtS(Colors.white, 16, FontWeight.w300),
                              ),
                              sh(11),
                              Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: b * 23),
                                height: h * 50,
                                width: 280 * b,
                                decoration: BoxDecoration(
                                  color: Color(0xffd8d1ea),
                                  borderRadius: BorderRadius.circular(b * 100),
                                ),
                                child: TextField(
                                  controller: pwdEditingController,
                                  obscuringCharacter: '*',
                                  obscureText: !isVisible,
                                  style: txtS(brc, 16, FontWeight.w500),
                                  decoration: InputDecoration(
                                    enabledBorder: bor(),
                                    focusedBorder: bor(),
                                    suffixIconConstraints: BoxConstraints(
                                        minWidth: b * 16, minHeight: h * 12),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: b * 15),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isVisible = !isVisible;
                                          });
                                        },
                                        child: Icon(
                                          isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                          size: b * 16,
                                        ),
                                      ),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: txtS(brc, 16, FontWeight.w300),
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: h * 15),
                                  ),
                                ),
                              ),
                              sh(10),
                              Row(
                                children: [
                                  Text(''),
                                  Spacer(),
                                  InkWell(
                                    child: Text(
                                      'Forgot Password?',
                                      style: txtS(Color(0xffffffff), 14,
                                          FontWeight.w300),
                                    ),
                                  ),
                                  SizedBox(width: b * 30),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  sh(80),
                  MaterialButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    },
                    color: pc,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(b * 35),
                    ),
                    elevation: 0,
                    height: h * 62,
                    minWidth: b * 307,
                    child: Text(
                      'Login',
                      style: txtS(Colors.white, 26, FontWeight.w300),
                    ),
                  ),
                  sh(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ? ',
                        style: txtS(Color(0xff000000), 18, FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: Text(
                          'Sign-up',
                          style: txtS(pc, 18, FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  sh(30),
                ],
              ),
            ),
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

  InputDecoration dec(String txt) {
    return InputDecoration(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: txt,
      hintStyle: TextStyle(
        color: brc,
        fontSize: SizeConfig.screenWidth * 16 / 375,
        fontWeight: FontWeight.w300,
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 15 / 812),
    );
  }

  UnderlineInputBorder bor() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffb5e8e9).withOpacity(0.36),
        width: SizeConfig.screenWidth / 375 * 1,
      ),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 812);
  }
}
