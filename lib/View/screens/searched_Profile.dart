import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/controllers/profileController.dart';

class SearchedProfileScreen extends StatefulWidget {
  final String uid;
  const SearchedProfileScreen({super.key, required this.uid});

  @override
  State<SearchedProfileScreen> createState() => _SearchedProfileScreenState();
}

class _SearchedProfileScreenState extends State<SearchedProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    profileController.updateUserId(widget.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (controller) {
          if (controller.user.isEmpty ) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              centerTitle: true,
              
              leading: const Icon(Icons.person_add_alt),
              actions: const [Icon(Icons.more_horiz)],
              title: Text(
                controller.user['name'],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                              imageUrl: controller.user['profilePhoto'],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                controller.user['followings'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Following",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 15,
                            width: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              border: Border.all(color: Colors.black12),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user['followers'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 15,
                            width: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              border: Border.all(color: Colors.black12),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user['likes'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "likes",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 100,
                        width: 95,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {

                                controller.followUser();
                              
                            },
                            child: Text(
                               controller.user['isFollowing']
                                      ? 'UnFollow'
                                      : "Follow",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.window_outlined,size: 25,color: Colors.grey[400],),
                            const SizedBox(width: 5,),
                            Text("Posts",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[400]),),
                        
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                        endIndent: 8,
                        indent: 8,
                      ),
                      const SizedBox(height: 10,),
                      
                      (controller.user['thumbnails'] as List).isEmpty 
                      ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: Center(child: Text("No Posts Here",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),),
                      ) 
                      : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.user['thumbnails'].length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          String thumbnail =
                              controller.user['thumbnails'][index];
                          return CachedNetworkImage(
                            imageUrl: thumbnail,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                            errorWidget: (context, url, error) => const Center(child: Icon(Icons.error),),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
