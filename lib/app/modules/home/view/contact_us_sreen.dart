import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/class%20booking/view/class_booking_homescreen.dart';
import 'package:olympic/app/modules/home/view%20model/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../../class booking/view model/classbooking_provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  HomeProvider? homeScreenProvider;
  @override
  void initState() {
    super.initState();
    homeScreenProvider = context.read<HomeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.aboutUsBg,
              fit: BoxFit.cover,
            ),
          ),
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
                          Routes.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppConstants.white,
                          size: 20,
                        ),
                      ),
                      const commonTextWidget(
                        text: 'Contact Us',
                        color: AppConstants.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: Responsive.height * 60,
                      width: Responsive.width * 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.black.withOpacity(0.3),
                            AppConstants.black
                          ], // Add your desired colors

                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        // Adjust opacity as needed
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const commonTextWidget(
                            text: 'Contact Information',
                            color: AppConstants.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          Image.asset(
                            AppImages.clockIcon,
                            height: 40,
                          ),
                          const commonTextWidget(
                            text: 'Open: M-T 3:30pm – 5:20pm, S-S 9am – 1pm',
                            color: AppConstants.white,
                            fontSize: 12,
                          ),
                          Image.asset(
                            AppImages.mailIcon,
                            height: 40,
                          ),
                          const commonTextWidget(
                            text: ' example@example.com',
                            color: AppConstants.white,
                            fontSize: 14,
                          ),
                          Image.asset(
                            AppImages.locationIcon,
                            height: 30,
                          ),
                          const commonTextWidget(
                            text:
                                'Olympic Combat Sport Academy L.L.C Just Play Sports Complex, 15 A StreetAl Qouz Industrial Area 1',
                            color: AppConstants.white,
                            fontSize: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              width: Responsive.width * 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      log(" provide fb url");
                                      homeScreenProvider?.launchUrl(
                                          "https://www.facebook.com/olympiccombat");
                                    },
                                    child: Image.asset(
                                      AppImages.yellowFb,
                                      height: 55,
                                    ),
                                  ),
                                  SizeBoxV(Responsive.width * 5),
                                  GestureDetector(
                                    onTap: () {
                                      log("provide insta url");
                                      homeScreenProvider?.launchUrl(
                                          "https://www.instagram.com/olympiccombat/");
                                    },
                                    child: Image.asset(
                                      AppImages.whiteInsta,
                                      height: 55,
                                    ),
                                  ),
                                  SizeBoxV(Responsive.width * 5),
                                  GestureDetector(
                                    onTap: () {
                                      log("provide yt url");
                                      homeScreenProvider?.launchUrl(
                                          "https://www.youtube.com/@OlympicCombat");
                                    },
                                    child: Image.asset(
                                      AppImages.yellowYoutube,
                                      height: 55,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: CommonButton(
                    width: Responsive.width * 90,
                    height: Responsive.height * 6.5,
                    onTap: () async {
                      context
                          .read<ClassBookingProvider>()
                          .selecteDateStringFn(DateTime.now());
                      await context
                          .read<ClassBookingProvider>()
                          .getAllClassesFn(
                              DateFormat('yyyy-MM-dd').format(DateTime.now()));
                      Routes.push(screen: const ClassBookingHomeScreen());
                    },
                    text: "Book a Class",
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
