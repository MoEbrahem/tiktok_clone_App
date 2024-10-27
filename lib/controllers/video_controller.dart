import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/Model/videoModel.dart';
import 'package:tiktok_flutter/constants.dart';

class VideoController extends GetxController {
  final Rx<List<VideoModel>> _listVideos = Rx<List<VideoModel>>([]);
  List<VideoModel> get videoList => _listVideos.value;

  @override
  void onInit() {
    super.onInit();
    _listVideos.bindStream(
      firebasefireStore
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<VideoModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(VideoModel.fromJson(element));
      }
      return retVal;
    }));
  }

  addLike(String videoId) async {
    DocumentSnapshot doc =
        await firebasefireStore.collection('videos').doc(videoId).get();
    var uid = authcontroller.user.value!.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firebasefireStore.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firebasefireStore.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
