// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/controllers/uploadvideoController.dart';
import 'package:video_player/video_player.dart';
import 'package:tiktok_flutter/View/widgets/main_text_field.dart';

class ConfirmScreen extends StatefulWidget {
  final File videofile;
  final String videoPath;
  const ConfirmScreen({
    super.key,
    required this.videofile,
    required this.videoPath,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController videocontroller;
  late TextEditingController songController;
  late TextEditingController captionController;
  late Uploadvideocontroller uploadVideoController;
  @override
  void initState() {
    super.initState();
    setState(() {
      videocontroller = VideoPlayerController.file(widget.videofile);
    });
    videocontroller.setLooping(true);
    videocontroller.initialize();
    videocontroller.play();
    videocontroller.setVolume(0.9);
    songController = TextEditingController();
    captionController = TextEditingController();
    uploadVideoController = Get.put(Uploadvideocontroller());
  }

  @override
  void dispose() {
    super.dispose();
    videocontroller.dispose();
    songController.dispose();
    captionController.dispose();
    uploadVideoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Uploadvideocontroller>(
      builder: (controller) {
        return controller.isLoading == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    controller.state == 'compressing'? "Compressing Video.." : "Uploading ...",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const Text(
                    "It Takes some Time Please Wait",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: VideoPlayer(videocontroller),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width - 20,
                            child: MainTextField(
                              controller: songController,
                              lable: "Song Name",
                              icon: const Icon(Icons.music_note),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width - 20,
                            child: MainTextField(
                              controller: captionController,
                              lable: "Caption",
                              icon: const Icon(Icons.closed_caption),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                // uploadVideoController.isLoading = true;
                                videocontroller.setVolume(0);
                              });
                              controller.uploadVideo(
                                songController.text,
                                captionController.text,
                                widget.videofile.path,
                              );
                              // setState(
                              //   () {
                              //   uploadVideoController.isLoading = true;
                              //   controller.setVolume(0);
                              // });
                            },
                            child: const Text(
                              "Share!",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
      },
    ));
  }
}
