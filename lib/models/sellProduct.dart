import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String itemCategory;
  String itemTitle;
  String itemDes;
  String sellerContact;
  String sellerEmail;
  String itemPrice;
  String image1Url;
  String image2Url;
  Timestamp timestamp;

  Product(
      {this.itemCategory,
      this.itemTitle,
      this.itemDes,
      this.sellerContact,
      this.itemPrice,
      this.sellerEmail,
      this.image1Url,
      this.image2Url,
      this.timestamp});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['itemCategry'] = this.itemCategory;
    map['itemTitle'] = this.itemTitle;
    map['itemDes'] = this.itemDes;
    map['sellerContact'] = this.sellerContact;
    map['sellerEmail'] = this.sellerEmail;
    map['itemSell'] = this.itemPrice;
    map['image1'] = this.image1Url;
    map['image2'] = this.image2Url;
    map['timestamp'] = this.timestamp;

    return map;
  }
}
