class UserModel {
  String? uid;
  String? fname;
  String? lname;
  String? email;
  dynamic profilePic;
  dynamic phone;
  dynamic height;
  dynamic weight;
  dynamic house;
  dynamic city;
  dynamic state;
  dynamic family;
  int? gender;
  int? age;
  UserModel({
    this.uid,
    this.fname,
    this.lname,
    this.email,
    this.profilePic,
    this.phone,
    this.height,
    this.weight,
    this.house,
    this.city,
    this.state,
    this.family,
    this.gender,
    this.age,
  });
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fname': fname,
      'lname': lname,
      'email': email,
      'profilePic': profilePic,
      'phone': phone,
      'height': height,
      'weight': weight,
      'house': house,
      'city': city,
      'state': state,
      'family': family,
      'gender': gender,
      'age': age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fname: map['fname'],
      lname: map['lname'],
      email: map['email'],
      profilePic: map['profilePic'],
      phone: map['phone'],
      height: map['height'],
      weight: map['weight'],
      house: map['house'],
      city: map['city'],
      state: map['state'],
      family: map['family'],
      gender: map['gender'],
      age: map['age'],
    );
  }
}
