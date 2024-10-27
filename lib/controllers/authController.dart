import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_flutter/Model/userModel.dart';
import 'package:tiktok_flutter/View/screens/auth/loginScreen.dart';
import 'package:tiktok_flutter/View/screens/homeScreen.dart';
import 'package:tiktok_flutter/constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  File? file;
  late Rx<User?> user;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(firebaseAuth.currentUser);
    user.bindStream(firebaseAuth.authStateChanges());
    ever(user, setInitialScreen);
  }

  setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar("Profile Picture",
          "you have successfully selected your profile picture!");
      file = File(pickedImage.path);
    }
  }

  /// upload file image to fireStorage

  Future<String> uploadFile(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profilePics")
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }

  void register(
      String userName, String email, String password, File? image) async {
    List<String> usersNames = [];
    try {
      var allusers = await firebasefireStore.collection('users').get();
      for (var user in allusers.docs) {
        usersNames.add((user.data() as dynamic)['name']);
        print(usersNames);
      }
      for (var i = 0; i < usersNames.length; i++) {
        if (userName == usersNames[i]) {
          userName = '';
          Get.snackbar("Error Creating Account", 'Please Choose Unique Name');
        }
      }
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        var credintial = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadURL = await uploadFile(image);
        UserModel user = UserModel(
          uid: credintial.user!.uid,
          name: userName.toLowerCase(),
          email: email,
          profilePhoto: downloadURL,
        );
        await firebasefireStore
            .collection('users')
            .doc(credintial.user!.uid)
            .set(
              user.toJson(),
            )
            .then(
          (value) {
            Get.offAll(() => const HomeScreen());
          },
        );
      } else {
        Get.snackbar("Error Creating Account", 'Please Fill All Fields');
      }
    } catch (e) {
      Get.snackbar("Error Creating Account", e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print('Sign in successfully');
        Get.snackbar("Welcome!", 'Log in Successfully');
        Get.offAll(() => const HomeScreen());
      } else {
        Get.snackbar("Error Log in Account", 'Please Fill All Fields');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Get.snackbar(
            "Error Log in Account", 'Please Check your email and password');
      } else if (e.code == 'network-request-failed') {
        Get.snackbar(
            "Error Log in Account", 'Please Check your Internet Connection');
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error Log in Account", e.toString());
    }
  }
}
