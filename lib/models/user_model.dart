class UserModel {
  String? uid;
  String? username;
  String? email;

  UserModel({this.email, this.uid, this.username});

  // data from server/firestore
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'], username: map['username'], email: map['email']);
  }

  // sending data
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'username': username, 'email': email};
  }
}
