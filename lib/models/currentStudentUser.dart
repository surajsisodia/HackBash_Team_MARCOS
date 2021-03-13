class CurrentStudentUser {
  String department;
  String photoUrl;
  String email;
  String name;
  String phone;
  String sem;
  String year;
  String uiNumber;
  String uid;

  CurrentStudentUser(
      {this.department,
      this.photoUrl,
      this.email,
      this.name,
      this.phone,
      this.sem,
      this.uiNumber,
      this.year,
      this.uid});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    map['email'] = this.email;
    map['phone'] = this.phone;
    map['uid'] = this.uid;
    map['department'] = this.department;
    map['year'] = this.year;
    map['sem'] = this.sem;
    map['photoUrl'] = this.photoUrl;
    map['uiNumber'] = this.uiNumber;
    return map;
  }

  // CurrentUser fromMap(Map<String, dynamic> map) {
  //   CurrentUser _message = CurrentUser();
  //   _message.name = map['name'];
  //   _message.email = map['email'];
  //   _message.phone = map['phone'];
  //   _message.uid = map['uid'];
  //   _message.token = map['token'];
  //   return _message;
  // }
}
