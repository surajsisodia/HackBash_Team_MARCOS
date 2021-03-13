class Product {
  String itemCategory;
  String itemTitle;
  String itemDes;
  String sellerContact;
  String sellerEmail;
  String itemPrice;
  String image1Url;
  String image2Url;

  Product(
      {this.itemCategory,
      this.itemTitle,
      this.itemDes,
      this.sellerContact,
      this.itemPrice,
      this.sellerEmail,
      this.image1Url,
      this.image2Url});

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

    return map;
  }
}
