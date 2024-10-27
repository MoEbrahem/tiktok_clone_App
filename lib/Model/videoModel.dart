import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String userName;
  String uid;
  String id;
  List likes;
  String profilePhoto;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  VideoModel({
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.likes,
    required this.profilePhoto,
    required this.shareCount,
    required this.songName,
    required this.thumbnail,
    required this.uid,
    required this.userName,
    required this.videoUrl,
  });

  Map<String, dynamic> toJson() => {
        "name": userName,
        "uid": uid,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "songName": songName,
        'caption': caption,
        "videoUrl": videoUrl,
        'thumbnail': thumbnail,
        "profilePhoto": profilePhoto
      };
  static VideoModel fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return VideoModel(
      caption: snapshot['caption'],
      commentCount: snapshot['commentCount'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      shareCount: snapshot['shareCount'],
      songName: snapshot['songName'],
      thumbnail: snapshot['thumbnail'],
      uid: snapshot['uid'],
      userName: snapshot['name'],
      videoUrl: snapshot['videoUrl'],
    );
  }
}
