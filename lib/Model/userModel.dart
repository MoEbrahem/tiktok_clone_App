// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String profilePhoto;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'profilePhoto': profilePhoto,
        'uid': uid,
      };
  static UserModel fromFireStore(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      name: snapshot['name'],
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
