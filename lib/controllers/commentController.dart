import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/Model/commentModel.dart';
import 'package:tiktok_flutter/constants.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _listComments = Rx<List<CommentModel>>([]);

  List<CommentModel> get listComments => _listComments.value;
  String postId = '';
  changePostId(String id) {
    postId = id;
    getComment();
  }

  getComment() {
    _listComments.bindStream(
      firebasefireStore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot q) {
          List<CommentModel> comList = [];
          for (var element in q.docs) {
            comList.add(CommentModel.fromJson(element));
          }
          return comList;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      DocumentSnapshot userDoc = await firebasefireStore
          .collection('users')
          .doc(authcontroller.user.value!.uid)
          .get();
      var allDocs = await firebasefireStore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .get();
      int len = allDocs.docs.length;
      CommentModel comment = CommentModel(
        userName: (userDoc.data()! as dynamic)['name'],
        uid: authcontroller.user.value!.uid,
        comment: commentText.trim(),
        datePublished: DateTime.now(),
        id: "Comment $len",
        likes: [],
        profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
      );
      await firebasefireStore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .doc("Comment $len")
          .set(comment.toJson());
      DocumentSnapshot doc =
          await firebasefireStore.collection('videos').doc(postId).get();
      await firebasefireStore.collection("videos").doc(postId).update(
        {
          "commentCount": (doc.data()! as dynamic)['commentCount'] + 1,
        },
      );
      
    } catch (e) {
      Get.snackbar("Error While Commenting", e.toString());
    }
  }

  likeComment(String commentId) async {
    DocumentSnapshot doc = await firebasefireStore
        .collection("videos")
        .doc(postId)
        .collection("comments")
        .doc(commentId)
        .get();
    var userid = authcontroller.user.value!.uid;
    if ((doc.data()! as dynamic)['likes'].contains(userid)) {
      await firebasefireStore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .update(
        {
          "likes": FieldValue.arrayRemove([userid]),
        },
      );
    } else {
      await firebasefireStore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .update(
        {
          'likes': FieldValue.arrayUnion([userid])
        },
      );
    }
  }
}
