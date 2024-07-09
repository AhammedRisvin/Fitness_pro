import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/class%20booking/view/class_booking_homescreen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../view model/home_provider.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<HomeProvider>(context, listen: false).initializeVideoPlayer(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppImages.aboutUsBg,
              fit: BoxFit.cover,
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Responsive.width * 4),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.of<HomeProvider>(context, listen: false)
                              .isVideoPlaying = false;
                          Routes.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppConstants.white,
                          size: 20,
                        ),
                      ),
                      const commonTextWidget(
                        text: 'About Us',
                        color: AppConstants.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeBoxH(Responsive.height * 15),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.width * 20,
                          ),
                          child: const commonTextWidget(
                            color: AppConstants.appPrimaryColor,
                            text: "Dubai's best\nmartial arts academy",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 23),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: commonTextWidget(
                            color: AppConstants.white,
                            text:
                                "We started this program having seen what was in the region and coached at some of the main competitors and frankly thought..... We could do it better,So we did",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            align: TextAlign.start,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 5),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: commonTextWidget(
                            color: AppConstants.white,
                            text:
                                "Our facility and coaches are what allow us to make sure we focus on what is important.Each and every child,",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            align: TextAlign.start,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 5),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: commonTextWidget(
                            color: AppConstants.white,
                            text: "Join Dubai's Best Martial Arts Club",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            // align: TextAlign.start,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 5),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: commonTextWidget(
                            color: AppConstants.white,
                            text:
                                "Join us start your child on a journey to olympic confidence and an elite edge",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            align: TextAlign.start,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonButton(
                              onTap: () {
                                Routes.push(
                                    screen: const ClassBookingHomeScreen());
                              },
                              text: "Book a class",
                              width: Responsive.width * 50,
                              height: Responsive.height * 6.5,
                            ),
                          ],
                        ),
                        SizeBoxH(Responsive.height * 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.meetThePng,
                              height: 20,
                            ),
                          ],
                        ),
                        SizeBoxH(Responsive.height * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.coachPng,
                              height: 25,
                            ),
                          ],
                        ),
                        SizeBoxH(Responsive.height * 1.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.linePng,
                              height: 25,
                            ),
                          ],
                        ),
                        SizeBoxH(Responsive.height * 5),
                        CommonInkwell(
                          onTap: () {
                            Provider.of<HomeProvider>(context, listen: false)
                                .toggleVideoPlayback();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: Responsive.height * 30,
                            width: Responsive.width * 100,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/coachBgContainer.png",
                                ),
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: AppConstants.appPrimaryColor,
                            ),
                            child: Provider.of<HomeProvider>(context)
                                    .isVideoPlaying
                                ? CustomVideoPlayer(
                                    customVideoPlayerController:
                                        CustomVideoPlayerController(
                                      context: context,
                                      videoPlayerController:
                                          Provider.of<HomeProvider>(context)
                                              .videoPlayerController,
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                        SizeBoxH(Responsive.height * 2),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: commonTextWidget(
                            color: AppConstants.white,
                            text: "HAMAM CHIO - HEAD COACH / COMPETENCY",
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            align: TextAlign.start,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 2),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          height: Responsive.height * 30,
                          width: Responsive.width * 100,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/coachBgContainer.png",
                              ),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: AppConstants.appPrimaryColor,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 2),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: commonTextWidget(
                            color: AppConstants.white,
                            text: "HAMAM CHIO - HEAD COACH / COMPETENCY",
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            align: TextAlign.start,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
