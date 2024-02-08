class UserModel {
  String? uid;
  String? name;
  String? email;
  String? profilePic;
  String? phone;
  String? height;
  String? weight;
  String? house;
  String? city;
  String? state;
  String? family;
  UserModel({
    this.uid,
    this.name,
    this.email,
    this.profilePic,
    this.phone,
    this.height,
    this.weight,
    this.house,
    this.city,
    this.state,
    this.family,
  });
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'phone': phone,
      'height': height,
      'weight': weight,
      'house': house,
      'city': city,
      'state': state,
      'family': family,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      profilePic: map['profilePic'],
      phone: map['phone'],
      height: map['height'],
      weight: map['weight'],
      house: map['house'],
      city: map['city'],
      state: map['state'],
      family: map['family'],
    );
  }
}
