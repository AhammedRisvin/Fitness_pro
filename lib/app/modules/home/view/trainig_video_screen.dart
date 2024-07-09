import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/home/widget/youtube_video_player.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/enums.dart';
import '../view model/home_provider.dart';

class TrainingVideosScreen extends StatelessWidget {
  const TrainingVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          text: 'Training Videos',
          color: AppConstants.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {
            Routes.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppConstants.white,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: homeScreenProvider.getTrainingVideosStatus ==
                  GetTrainingVideosStatus.loading
              ? const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppConstants.appPrimaryColor,
                    ),
                  ),
                )
              : homeScreenProvider.trainingVideosModel == null
                  ? SizedBox(
                      height: Responsive.height * 50,
                      width: Responsive.width * 100,
                      child: Center(
                          child: Image.asset(
                        AppImages.noData,
                        height: Responsive.height * 20,
                      )),
                    )
                  : Consumer<HomeProvider>(
                      builder: (context, value, child) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data =
                                value.trainingVideosModel?.response?[index];

                            return SizedBox(
                              height: Responsive.height * 29,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTextWidget(
                                    color: AppConstants.white,
                                    text: homeScreenProvider
                                        .capitalizeFirstLetter(
                                            data?.categoryName ??
                                                "Olympic Combat Home  Workout"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizeBoxH(Responsive.height * 2),
                                  SizedBox(
                                    height: Responsive.height * 23,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var videodata =
                                            data?.trainingVideos?[index];
                                        return CommonInkwell(
                                          onTap: () {
                                            Routes.push(
                                                screen:
                                                    YoutubeVideoPlayerScreen(
                                              videoUrl:
                                                  videodata?.videoUrl ?? "",
                                            ));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            width: Responsive.width * 35,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  videodata?.thumpImage?.url ??
                                                      "assets/images/trainigVideo1.png",
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizeBoxH(Responsive.height * 1),
                                                Image.asset(
                                                  AppImages.onboardingLogo,
                                                  height: 55,
                                                ),
                                                commonTextWidget(
                                                  color: AppConstants.white,
                                                  text: homeScreenProvider
                                                      .capitalizeFirstLetter(
                                                          videodata
                                                                  ?.videoName ??
                                                              ""),
                                                  fontSize: 12,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (index, context) {
                                        return SizeBoxV(Responsive.width * 5);
                                      },
                                      itemCount:
                                          data?.trainingVideos?.length ?? 0,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizeBoxH(Responsive.height * 4);
                          },
                          itemCount:
                              value.trainingVideosModel?.response?.length ?? 0),
                    ),
        ),
      ),
    );
  }
}

class YoutubeVideoPlayer extends StatefulWidget {
  final bool isFullscreen;
  final String url;
  const YoutubeVideoPlayer(
      {super.key,
      this.isFullscreen = false,
      this.url = "https://youtu.be/qvsiJKdDxPs?si=j00e9BDdupuYTTCq"});

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  @override
  void initState() {
    // context.read<HomeScreenProvider>().initializeYoutubeController(
    //     "https://youtu.be/qvsiJKdDxPs?si=j00e9BDdupuYTTCq");
    super.initState();
  }

  bool isFullScreen = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      //   child: YoutubePlayerBuilder(
      //       onEnterFullScreen: () {
      //         setState(() {
      //           isFullScreen = true;
      //         });
      //       },
      //       onExitFullScreen: () {
      //         setState(() {
      //           isFullScreen = false;
      //         });
      //       },
      //       player: YoutubePlayer(
      //         aspectRatio: 13 / 10,
      //         showVideoProgressIndicator: true,
      //         width: Responsive.width * 100,
      //         controller:
      //             context.read<HomeScreenProvider>().youtubeControllerMain,
      //       ),
      //       builder: (context, player) {
      //         return SizedBox(
      //             width: isFullScreen
      //                 ? Responsive.width * 100
      //                 : Responsive.width * 100,
      //             height: isFullScreen
      //                 ? Responsive.height * 100
      //                 : Responsive.height * 100,
      //             child: player);
      //       }),
    );
  }
}
