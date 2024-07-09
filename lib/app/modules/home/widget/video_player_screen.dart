// ignore_for_file: library_private_types_in_public_api

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:olympic/app/modules/home/view%20model/home_provider.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../utils/app_constants.dart';

class VideoPlayerPage extends StatefulWidget {
  final bool isFullscreen;
  final String url;
  const VideoPlayerPage(
      {Key? key,
      this.isFullscreen = false,
      this.url =
          "'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'"})
      : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  void initState() {
    super.initState();
    // Initialize video player through the model
    context.read<HomeProvider>().initializeVideoPlayer(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: Consumer<HomeProvider>(
        builder: (context, model, child) {
          return model.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Responsive.height * 100,
                      width: Responsive.width * 100,
                      child: CustomVideoPlayer(
                        customVideoPlayerController:
                            CustomVideoPlayerController(
                          context: context,
                          videoPlayerController: model.videoPlayerController,
                          customVideoPlayerSettings:
                              const CustomVideoPlayerSettings(
                                  settingsButtonAvailable: false,
                                  enterFullscreenOnStart: false,
                                  exitFullscreenOnEnd: true),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 15,
                      child: IconButton(
                        onPressed: () {
                          context
                              .read<HomeProvider>()
                              .videoPlayerController
                              .pause();
                          Routes.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppConstants.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
