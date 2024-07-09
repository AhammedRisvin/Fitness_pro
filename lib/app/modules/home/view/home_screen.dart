import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/class%20booking/view%20model/classbooking_provider.dart';
import 'package:olympic/app/modules/class%20booking/view/class_booking_homescreen.dart';
import 'package:olympic/app/modules/estore/view%20model/estore_provider.dart';
import 'package:olympic/app/modules/home/view/aabout_screen.dart';
import 'package:olympic/app/modules/home/view/subscription_screen.dart';
import 'package:olympic/app/modules/home/view/trainig_video_screen.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../estore/view/botttom_navbar_screen.dart';
import '../view model/home_provider.dart';
import '../widget/drawer_widget.dart';
import '../widget/homescreen_small_static_containers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? controller;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: _currentPage);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _stopAutoPlay();
    controller?.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      controller?.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstants.black,
        title: Row(
          children: [
            Image.asset(
              AppImages.onboardingLogo,
              height: 60,
              width: 60,
            ),
            const commonTextWidget(
              text: "Olympic Combat",
              color: AppConstants.white,
              fontSize: 18,
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: AppConstants.appPrimaryColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              homeScreenProvider.fetchQrCodeData(context);
            },
            icon: Image.asset(
              AppImages.scanner,
              height: 23,
            ),
          ),
          const SizeBoxV(5),
        ],
      ),
      drawer: const DrawerWidget(),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Column(
          children: [
            StreamBuilder(
                stream: homeScreenProvider.getUserDataAndCaroselData(),
                builder: (context, snapshot) {
                  return Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 10, right: 5),
                    height: Responsive.height * 17,
                    width: Responsive.width * 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage(AppImages.HomescreenContainerBgGif),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppConstants.border,
                        )
                        // color: AppConstants.drawerBgColor,
                        ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: snapshot.data?.userData?.image?.url == null
                              ? Image.asset(
                                  AppImages.profilePic,
                                  height: 70,
                                )
                              : Image.network(
                                  snapshot.data?.userData?.image?.url ?? "",
                                  fit: BoxFit.cover,
                                  width: Responsive.width * 20,
                                  height: Responsive.height * 10,
                                ),
                        ),
                        SizeBoxV(Responsive.width * 5),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: commonTextWidget(
                                  color: AppConstants.white,
                                  text:
                                      "Hi, ${homeScreenProvider.capitalizeFirstLetter(snapshot.data?.userData?.name ?? "")} ",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  commonTextWidget(
                                      color: AppConstants.white,
                                      text:
                                          "Class left : ${snapshot.data?.classLeft ?? ""}",
                                      fontSize: 13),
                                  Expanded(
                                    child: commonTextWidget(
                                        color: AppConstants.white,
                                        text:
                                            "Valid until :${DateFormat("yyyy-MM-dd").format(snapshot.data?.userData?.planExpiringDate ?? DateTime.now())} ",
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                              FittedBox(
                                fit: BoxFit.cover,
                                child: commonTextWidget(
                                  color: AppConstants.appPrimaryColor,
                                  text:
                                      "MEMBERSHIP ID : ${snapshot.data?.userData?.id?.substring(snapshot.data!.userData!.id!.length - 7) ?? "xxxx"} "
                                          .toUpperCase(),
                                  fontSize: 15,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            SizeBoxH(Responsive.height * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeScreenSmallStaticContainer(
                  icon: AppImages.infoIcon,
                  title: "About",
                  ontap: () {
                    Routes.push(screen: const AboutScreen());
                  },
                ),
                HomeScreenSmallStaticContainer(
                  icon: AppImages.calanderIcon,
                  title: "Class Booking",
                  ontap: () {
                    context
                        .read<ClassBookingProvider>()
                        .selecteDateStringFn(DateTime.now());
                    context.read<ClassBookingProvider>().getAllClassesFn(
                        DateFormat('yyyy-MM-dd').format(DateTime.now()));
                    Routes.push(screen: const ClassBookingHomeScreen());
                  },
                ),
                HomeScreenSmallStaticContainer(
                  icon: AppImages.infoIcon,
                  title: "Training Videos",
                  ontap: () async {
                    homeScreenProvider.getTrainingVideosFn();
                    Routes.push(screen: const TrainingVideosScreen());
                  },
                ),
              ],
            ),
            SizeBoxH(Responsive.height * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeScreenSmallStaticContainer(
                  icon: AppImages.estoreIcon,
                  title: "Estore",
                  ontap: () {
                    context.read<EstoreProvider>().clearProvider();
                    Routes.push(screen: EstoreBottomNav());
                  },
                ),
                HomeScreenSmallStaticContainer(
                  icon: AppImages.rewardIcon,
                  title: "Rewards",
                  ontap: () {},
                ),
                HomeScreenSmallStaticContainer(
                  icon: AppImages.referFriendIcon,
                  title: "Refer a\nfriend",
                  ontap: () {
                    homeScreenProvider.shareApp();
                  },
                ),
              ],
            ),
            SizeBoxH(Responsive.height * 4),
            SizedBox(
              height: Responsive.height * 32,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FutureBuilder(
                      future: homeScreenProvider.fetchUserDataAndCarouselData(),
                      builder: (context, snapshot) {
                        return PageView.builder(
                          controller: controller,
                          itemCount: snapshot.data?.carouselDatas?.length ?? 0,
                          onPageChanged: (index) {
                            homeScreenProvider.updateIndex(index);
                          },
                          itemBuilder: (context, index) {
                            var data = snapshot.data?.carouselDatas?[index];
                            return Container(
                              width: Responsive.width * 90,
                              height: Responsive.height * 30,
                              // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: commonNetworkImage(
                                    url: data?.carouselImage?.url ?? "",
                                    height: Responsive.height * 30,
                                    width: Responsive.width * 90,
                                  )),
                            );
                          },
                        );
                      }),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        homeScreenProvider.images.length,
                        (index) => Container(
                          width:
                              homeScreenProvider.currentIndex == index ? 30 : 5,
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.5),
                            color: homeScreenProvider.currentIndex == index
                                ? AppConstants.appPrimaryColor
                                : Colors.grey.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizeBoxH(Responsive.height * 4),
            CommonInkwell(
              onTap: () {
                context.read<HomeProvider>().allPlansFn(
                      plan: 'Annual',
                      index: 0,
                    );

                context.read<HomeProvider>().selectedHeadingIndex = 0;
                Routes.push(screen: const SubscriptionPlansScreen());
              },
              child: Container(
                height: Responsive.height * 7,
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(AppImages.membershipPlanBgContainer),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: Responsive.height * 5.5,
                    width: Responsive.width * 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppConstants.drawerBgColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.membershipIcon,
                          height: 20,
                          width: 20,
                        ),
                        const SizeBoxV(15),
                        const commonTextWidget(
                          text: "MEMBERSHIP PLAN",
                          color: AppConstants.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
