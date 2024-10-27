// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/Model/videoModel.dart';
import 'package:tiktok_flutter/View/screens/homeScreen.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:video_compress/video_compress.dart';

class Uploadvideocontroller extends GetxController {
  bool isLoading = false;
  String state = "";
  compressVideo(String videoPath) async {
    state = "compressing";

    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo?.file;
  }

  getThumbnails(String videoPath) async {
    final thumbnails = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnails;
  }

  Future<String> uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await getThumbnails(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }

  Future<String> uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await compressVideo(videoPath));
    state = 'uploading';
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();

    return downloadurl;
  }

  uploadVideo(String songName, String captionName, String videoPath) async {
    try {
      isLoading = true;
      update();
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firebasefireStore.collection('users').doc(uid).get();
      var allDoc = await firebasefireStore.collection('videos').get();
      int len = allDoc.docs.length;
      String videoUrl = await uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await uploadImageToStorage("Video $len", videoPath);
      VideoModel video = VideoModel(
        caption: captionName,
        commentCount: 0,
        id: "Video $len",
        likes: [],
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
        shareCount: 0,
        songName: songName,
        thumbnail: thumbnail,
        uid: uid,
        userName: (userDoc.data()! as Map<String, dynamic>)['name'],
        videoUrl: videoUrl,
      );
      await firebasefireStore
          .collection('videos')
          .doc('Video $len')
          .set(video.toJson());
      isLoading = false;
      update();
      Get.to(const HomeScreen());
    } catch (e) {
      print("============================= ${e.toString()}");
      Get.snackbar("Error Uploading video", e.toString());
    }
  }
}
