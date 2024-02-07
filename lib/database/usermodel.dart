class UserModel {
  String? uid;
  String? name;
  String? email;
  String? profilePic;
  String? phone;
  String? address;
  String? age;
  String? weight;
  String? height;
  String? acctype;
  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.profilePic,
      this.phone,
      this.address,
      this.age,
      this.weight,
      this.height,
      this.acctype});
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'phone': phone,
      'address': address,
      'age': age,
      'weight': weight,
      'height': height,
      'acctype': acctype,
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
      age: map['age'],
      weight: map['weight'],
      height: map['height'],
      acctype: map['acctype'],
    );
  }
}
