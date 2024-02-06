class UserModel {
  String? uid;
  String? name;
  String? email;
  String? profilePic;
  String? phone;
  String? address;
  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.profilePic,
      this.phone,
      this.address});
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'phone': phone,
      'address': address,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      profilePic: map['profilePic'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}
