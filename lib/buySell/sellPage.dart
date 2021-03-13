import 'dart:io';
import 'package:IIIT_Surat_Connect/buySell/dropDownMenu.dart';
import 'package:IIIT_Surat_Connect/models/sellProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class Sell extends StatefulWidget {
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  File image1, image2;
  bool getImage1 = false;
  bool getImage2 = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return SafeArea(
      child: Scaffold(
        key: _scafoldKey,
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
            "Sell",
            style: txtS(Colors.white, 20, FontWeight.w300),
          ),
        ),
        backgroundColor: bc,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 10),
          padding: EdgeInsets.symmetric(horizontal: b * 30, vertical: h * 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(b * 25),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Item Category",
                  style: txtS(bc, 16, FontWeight.w300),
                ),
                sh(5),
                DropDownMenuBar(),
                sh(20),
                Text(
                  "Title",
                  style: txtS(bc, 16, FontWeight.w300),
                ),
                sh(5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: b * 23),
                  height: h * 35,
                  width: 280 * b,
                  decoration: BoxDecoration(
                    color: Color(0xffd8d1ea),
                    borderRadius: BorderRadius.circular(b * 10),
                  ),
                  child: TextField(
                    controller: titleController,
                    style: txtS(brc, 14, FontWeight.w400),
                    decoration: dec('Enter item title'),
                  ),
                ),
                sh(20),
                Text(
                  "Description",
                  style: txtS(bc, 16, FontWeight.w300),
                ),
                sh(5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: b * 23),
                  height: h * 100,
                  width: 280 * b,
                  decoration: BoxDecoration(
                    color: Color(0xffd8d1ea),
                    borderRadius: BorderRadius.circular(b * 10),
                  ),
                  child: TextField(
                    controller: descriptionController,
                    style: txtS(brc, 14, FontWeight.w400),
                    decoration: dec('Enter item Descrition'),
                    maxLines: null,
                  ),
                ),
                sh(20),
                Text(
                  "Contact Number",
                  style: txtS(bc, 16, FontWeight.w300),
                ),
                sh(5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: b * 23),
                  height: h * 35,
                  width: 280 * b,
                  decoration: BoxDecoration(
                    color: Color(0xffd8d1ea),
                    borderRadius: BorderRadius.circular(b * 10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: contactController,
                    style: txtS(brc, 14, FontWeight.w400),
                    decoration: dec('Enter Your Contact'),
                  ),
                ),
                sh(20),
                Text(
                  "Price",
                  style: txtS(bc, 16, FontWeight.w300),
                ),
                sh(10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: b * 23),
                  height: h * 35,
                  width: 280 * b,
                  decoration: BoxDecoration(
                    color: Color(0xffd8d1ea),
                    borderRadius: BorderRadius.circular(b * 10),
                  ),
                  child: TextField(
                    controller: priceController,
                    style: txtS(brc, 14, FontWeight.w400),
                    decoration: dec('Enter expected Price'),
                  ),
                ),
                sh(20),
                Text(
                  "Photos",
                  style: txtS(bc, 16, FontWeight.w300),
                ),
                sh(10),
                Row(
                  children: [
                    InkWell(
                      splashColor: bc,
                      onTap: () {
                        pickImage('1');
                      },
                      child: getImage1
                          ? Container(
                              height: h * 80,
                              width: b * 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: bc),
                                borderRadius: BorderRadius.circular(b * 5),
                              ),
                              child: Image.file(image1),
                            )
                          : Container(
                              height: h * 80,
                              width: b * 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: bc),
                                borderRadius: BorderRadius.circular(b * 5),
                              ),
                              child: Icon(Icons.add, color: pc),
                            ),
                    ),
                    SizedBox(width: b * 20),
                    InkWell(
                      splashColor: bc,
                      onTap: () {
                        pickImage('2');
                      },
                      child: getImage2
                          ? Container(
                              height: h * 80,
                              width: b * 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: bc),
                                borderRadius: BorderRadius.circular(b * 5),
                              ),
                              child: Image.file(image2),
                            )
                          : Container(
                              height: h * 80,
                              width: b * 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: bc),
                                borderRadius: BorderRadius.circular(b * 5),
                              ),
                              child: Icon(Icons.add, color: pc),
                            ),
                    ),
                  ],
                ),
                sh(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      splashColor: Colors.white,
                      onPressed: () {
                        addProductToDB();
                      },
                      color: pc,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(b * 35),
                      ),
                      elevation: 0,
                      height: h * 45,
                      minWidth: b * 200,
                      child: Text(
                        'Confirm & Post',
                        style: txtS(Colors.white, 20, FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 812);
  }

  InputDecoration dec(String txt) {
    return InputDecoration(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: txt,
      hintStyle: TextStyle(
        color: brc,
        fontSize: SizeConfig.screenWidth * 13 / 375,
        fontWeight: FontWeight.w300,
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 7 / 812),
    );
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 375,
    );
  }

  pickImage(String imageNo) async {
    var picker = await ImagePicker().getImage(source: ImageSource.gallery);
    File selectedImage = File(picker.path);
    setState(() {
      if (imageNo == '1') {
        image1 = selectedImage;
        getImage1 = true;
      } else {
        image2 = selectedImage;
        getImage2 = true;
      }
    });
  }

  addProductToDB() async {
    String cat = categoryController.text;
    String title = titleController.text;
    String des = descriptionController.text;
    String phone = contactController.text;
    String price = priceController.text;

    Timestamp timestamp = Timestamp.now();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString('currentUserEmail');

    try {
      await FirebaseStorage.instance
          .ref()
          .child('eCommerce-Media')
          .child(timestamp.toString() + '-1')
          .putFile(image1);

      await FirebaseStorage.instance
          .ref()
          .child('eCommerce-Media')
          .child(timestamp.toString() + '-2')
          .putFile(image2);

      String image1Url = await FirebaseStorage.instance
          .ref()
          .child('eCommerce-Media')
          .child(timestamp.toString() + '-2')
          .getDownloadURL();

      String image2Url = await FirebaseStorage.instance
          .ref()
          .child('eCommerce-Media')
          .child(timestamp.toString() + '-2')
          .getDownloadURL();

      Product product = Product(
          itemCategory: cat,
          itemTitle: title,
          itemDes: des,
          itemPrice: price,
          sellerContact: phone,
          sellerEmail: email,
          image1Url: image1Url,
          image2Url: image2Url,
          timestamp: timestamp);

      var map = product.toMap();

      await FirebaseFirestore.instance
          .collection('eCommerceProduct')
          .add(map)
          .then((value) {
        Toast.show("Item Posted Successfuly", context,
            duration: Toast.LENGTH_LONG);
        Navigator.pop(context);
      });
    } on FirebaseException catch (e) {
      print(e.message);
      _scafoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }
}
