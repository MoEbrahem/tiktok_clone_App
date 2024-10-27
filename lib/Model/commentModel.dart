import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String userName;
  String uid;
  String id;
  List likes;
  String profilePhoto;
  String comment;
  final datePublished;

  CommentModel({
    required this.userName,
    required this.uid,
    required this.comment,
    required this.datePublished,
    required this.id,
    required this.likes,
    required this.profilePhoto,
  });
  Map<String, dynamic> toJson() => {
        "name": userName,
        "uid":uid,
        "id":id,
        "comment":comment,
        "likes":likes,
        "datePublished":datePublished,
        "profilePhoto":profilePhoto,

      };
  static CommentModel fromJson(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;
    return CommentModel(
      userName: snapshot["name"], 
      uid: snapshot["uid"], 
      comment: snapshot["comment"], 
      datePublished: snapshot["datePublished"], 
      id: snapshot['id'], 
      likes: snapshot['likes'], 
      profilePhoto: snapshot["profilePhoto"],
      );

  }    
}
