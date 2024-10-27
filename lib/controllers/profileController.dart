import 'package:get/get.dart';
import 'package:tiktok_flutter/View/screens/auth/loginScreen.dart';
import 'package:tiktok_flutter/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  bool isFollowing = false;

  final Rx<String> _uid = "".obs;
  String get uid => _uid.value;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myvidoes = await firebasefireStore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myvidoes.docs.length; i++) {
      thumbnails.add((myvidoes.docs[i].data() as dynamic)['thumbnail']);
    }

    var userDoc =
        await firebasefireStore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;

    for (var item in myvidoes.docs) {
      likes += (item.data()['likes'] as List).length;
    }
    var followerscoll = await firebasefireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingscoll = await firebasefireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followings')
        .get();
    followers = followerscoll.docs.length;
    following = followingscoll.docs.length;

    await firebasefireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authcontroller.user.value!.uid)
        .get()
        .then(
      (value) {
        if (value.exists) {
          isFollowing = true;
        } else {
          isFollowing = false;
        }
      },
    );
    _user.value = {
      'followings': following.toString(),
      'followers': followers.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
    };
    update();
  }

  signOut() async {
    authcontroller.user.value = null;
    authcontroller.file = null;
    Get.offAll(LoginScreen());
    await firebaseAuth.signOut();

  }

  followUser() async {
    var doc = await firebasefireStore
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .doc(authcontroller.user.value!.uid)
        .get();
    if (!doc.exists) {
      await firebasefireStore
          .collection("users")
          .doc(_uid.value)
          .collection("followers")
          .doc(authcontroller.user.value!.uid)
          .set({});
      await firebasefireStore
          .collection("users")
          .doc(authcontroller.user.value!.uid)
          .collection("followings")
          .doc(_uid.value)
          .set({});

      _user.value.update(
        "followers",
        (val) => (int.parse(val) + 1).toString(),
      );
    } else {
      await firebasefireStore
          .collection("users")
          .doc(_uid.value)
          .collection("followers")
          .doc(authcontroller.user.value!.uid)
          .delete();
      await firebasefireStore
          .collection("users")
          .doc(authcontroller.user.value!.uid)
          .collection("followings")
          .doc(_uid.value)
          .delete();

      _user.value.update(
        "followers",
        (val) => (int.parse(val) - 1).toString(),
      );
    }
    _user.value.update(
      "isFollowing",
      (val) => !val,
    );
    update();
  }
}
