// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/View/screens/searched_Profile.dart';
import 'package:tiktok_flutter/controllers/searchController.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  SearchUserController searchController = Get.put(SearchUserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextFormField(
          decoration: const InputDecoration(
            hintText: "Search...",
            hintStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            filled: false,
          ),
          onFieldSubmitted: (value) {
            searchController.searchUser(value);
          },
        ),
      ),
      body: Obx(
        () {
          return searchController.listUsers.isEmpty
              ? const Center(
                  child: Text(
                    "Search For User Here !",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: searchController.listUsers.length,
                  itemBuilder: (context, index) {
                    var user = searchController.listUsers[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SearchedProfileScreen(uid: user.uid),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            user.profilePhoto,
                          ),
                          radius: 25,
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
