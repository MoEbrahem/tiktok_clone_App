import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/Model/userModel.dart';
import 'package:tiktok_flutter/constants.dart';

class SearchUserController extends GetxController {
  final Rx<List<UserModel>> _listUsers = Rx<List<UserModel>>([]);
  List<UserModel> get listUsers => _listUsers.value;

  searchUser(String input) async{
    _listUsers.bindStream(
      firebasefireStore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: input.toLowerCase())
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<UserModel> resList = [];
          for (var element in query.docs) {
            resList.add(
              UserModel.fromFireStore(element),
            );
          }
          return resList;
        },
      ),
    );
  }
}
