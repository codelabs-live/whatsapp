import 'package:cloud_firestore/cloud_firestore.dart';

import 'entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String name,
    required String email,
    required String phoneNumber,
    required bool isOnline,
    required String uid,
    required String status,
    required String profileUrl,
  }) : super(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          isOnline: isOnline,
          uid: uid,
          status: status,
          profileUrl: profileUrl,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var myList = snapshot.data as Map<String, dynamic>;
    return UserModel(
      name: myList['name'],
      email: myList['email'],
      phoneNumber: myList['phoneNumber'],
      uid: myList['uid'],
      isOnline: myList['isOnline'],
      profileUrl: myList['profileUrl'],
      status: myList['status'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "uid": uid,
      "isOnline": isOnline,
      "profileUrl": profileUrl,
      "status": status,
    };
  }
}
