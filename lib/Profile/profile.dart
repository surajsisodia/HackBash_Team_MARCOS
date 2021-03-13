import 'dart:io';

import 'package:IIIT_Surat_Connect/Academics%20Resources/academicResources.dart';
import 'package:IIIT_Surat_Connect/Utils/SizeConfig.dart';
import 'package:IIIT_Surat_Connect/Utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../drawer.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;
  String phone;
  bool isPhone = false;
  bool isName = false;
  File imageFile;
  String imageName;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  SharedPreferences preferences;

  Future<String> uploadDisplayImageToFireStorage(
      File file, String fileName) async {
    final reference = _storage.ref().child(fileName);
    final uploadTask = reference.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    super.initState();
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
        body: StreamBuilder(
            stream: _firestore
                .collection('studentUsers')
                .where('email', isEqualTo: _auth.currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                var doc = snapshot.data.docs[0];
                var data = doc.data();
                return Stack(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        !isName ? 'Name' : 'Change Name',
                                        style: txtS(isName ? bc : pc, 14,
                                            FontWeight.w500),
                                      ),
                                      sh(3),
                                      isName
                                          ? Container(
                                              width: b * 225,
                                              child: TextField(
                                                onChanged: (val) {
                                                  name = val.trim();
                                                },
                                                keyboardType:
                                                    TextInputType.name,
                                                style: txtS(textColor, 15,
                                                    FontWeight.w500),
                                                decoration:
                                                    dec('Enter Your Name'),
                                              ),
                                            )
                                          : Text(
                                              (!snapshot.hasData ||
                                                      data['name'] == null)
                                                  ? data['uiNumber']
                                                      .toString()
                                                      .toUpperCase()
                                                  : data['name'],
                                              style: txtS(textColor, 16,
                                                  FontWeight.w400),
                                            ),
                                      isName
                                          ? butt(() async {
                                              if (name != null && name != '') {
                                                await doc.reference
                                                    .update({'name': name});
                                              }
                                              isName = !isName;
                                              setState(() {});
                                            })
                                          : SizedBox(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        isPhone ? 'Change Number' : 'Number',
                                        style: txtS(isPhone ? bc : pc, 14,
                                            FontWeight.w500),
                                      ),
                                      sh(3),
                                      isPhone
                                          ? Container(
                                              width: b * 225,
                                              child: TextField(
                                                onChanged: (val) {
                                                  phone = val.trim();
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                style: txtS(textColor, 15,
                                                    FontWeight.w500),
                                                decoration: dec('Phone Number'),
                                              ),
                                            )
                                          : Text(
                                              (!snapshot.hasData ||
                                                      data['phone'] == null)
                                                  ? 'Not Provided'
                                                  : data['phone'],
                                              style: txtS(textColor, 16,
                                                  FontWeight.w400),
                                            ),
                                      isPhone
                                          ? butt(() async {
                                              if (phone != null &&
                                                  phone != '') {
                                                await doc.reference
                                                    .update({'phone': phone});
                                              }
                                              isPhone = !isPhone;
                                              setState(() {});
                                            })
                                          : SizedBox(),
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
                                            setState(() {});
                                          })
                                        : SizedBox(),
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
                                      (!snapshot.hasData ||
                                              data['uiNumber'] == null)
                                          ? ''
                                          : data['uiNumber'].toUpperCase(),
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
                                      (!snapshot.hasData ||
                                              data['department'] == null)
                                          ? ''
                                          : (data['department'] == 'cs'
                                              ? 'Computer Science'
                                              : 'Electronics and Communication'),
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
                                      (!snapshot.hasData || data['sem'] == null)
                                          ? ''
                                          : data['sem'] + 'th',
                                      style: txtS(bc, 16, FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          sh(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: b * 25),
                                  height: h * 60,
                                  width: b * 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(b * 10),
                                    border: Border.all(
                                      color: pc,
                                      width: b * 1,
                                    ),

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Enrollment Number',
                                        style: txtS(pc, 14, FontWeight.w500),
                                      ),
                                      sh(6),
                                      Text(
                                        (!snapshot.hasData ||
                                                data['uiNumber'] == null)
                                            ? ''
                                            : data['uiNumber'].toUpperCase(),
                                        style: txtS(bc, 16, FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  _auth.signOut();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: b * 25),
                                  height: h * 60,
                                  width: b * 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(b * 10),
                                    color: bc,

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Semester',
                                        style: txtS(pc, 14, FontWeight.w500),
                                      ),
                                      sh(3),
                                      Text(
                                        (!snapshot.hasData ||
                                                data['sem'] == null)
                                            ? ''
                                            : data['sem'] + 'th',
                                        style: txtS(bc, 16, FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            sh(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: b * 25),
                                    height: h * 60,
                                    width: b * 150,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(b * 10),
                                      border: Border.all(
                                        color: pc,
                                        width: b * 1,
                                      ),
                                    ),
                                    child: Text(
                                      'Change Password',
                                      textAlign: TextAlign.center,
                                      style: txtS(bc, 16, FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    logOut();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: b * 25),
                                    height: h * 60,
                                    width: b * 150,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(b * 10),
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
                                          style: txtS(Colors.white, 16,
                                              FontWeight.w400),
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
                          InkWell(
                            onTap: () async {},
                            child: CircleAvatar(
                              radius: b * 138 / 2,
                              backgroundColor: Colors.amber,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: data['photoUrl'] == null
                                    ? ''
                                    : data['photoUrl'],
                                fadeInDuration: Duration(microseconds: 0),
                                fadeOutDuration: Duration(microseconds: 0),
                                placeholder: (context, url) => Container(),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: InkWell(
                              onTap: () async {
                                final pickedFile = await ImagePicker()
                                    .getImage(source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  imageFile = File(pickedFile.path);
                                  imageName = data['email'];
                                  uploadDisplayImageToFireStorage(
                                          imageFile, imageName)
                                      .then((value) {
                                    doc.reference.update({'photoUrl': value});
                                  });
                                } else {
                                  return;
                                }
                              },
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
                );
              }
            }),
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
        onTap: fn,
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

  pwdChangeRequest(String pwd, String newPwd) {
    FirebaseAuth auth = FirebaseAuth.instance;

    EmailAuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser.email, password: pwd);

    auth.currentUser.reauthenticateWithCredential(credential).catchError((e) {
      print("Error is: $e");
    }).then((value) {
      auth.currentUser.updatePassword(newPwd).catchError((e) {
        print(e);
      }).timeout(Duration(seconds: 10), onTimeout: () {
        Toast.show("Server Error", context, duration: Toast.LENGTH_LONG);
      }).then((value) {
        Toast.show("Password Changed Succesfully", context,
            duration: Toast.LENGTH_LONG);
      });
    });
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
        preferences.clear();
        print("Signed Out");
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
