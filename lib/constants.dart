import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/View/screens/add_video.dart';
import 'package:tiktok_flutter/View/screens/profileScreen.dart';
import 'package:tiktok_flutter/View/screens/searchScreen.dart';
import 'package:tiktok_flutter/View/screens/videoScreen.dart';
import 'package:tiktok_flutter/controllers/authController.dart';

/// Colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//  Pages

List<Widget> pages = [
  const VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  const Center(child: Text("Messages Page")),
  const ProfileScreen()
];

/// firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instanceFor(
bucket: "tiktok-ec56e.appspot.com"
);
var firebasefireStore = FirebaseFirestore.instance;

//    Controllers

var authcontroller = AuthController.instance;
