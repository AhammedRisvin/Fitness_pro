import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olympic/app/core/string_const.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/estore/view%20model/estore_provider.dart';
import 'package:olympic/app/modules/home/view%20model/home_provider.dart';
import 'package:olympic/app/modules/home/view/contact_us_sreen.dart';
import 'package:olympic/app/modules/home/view/faq_screen.dart';
import 'package:olympic/app/modules/home/view/feedback_screen.dart';
import 'package:olympic/app/modules/home/view/my_bookings_screen.dart';
import 'package:olympic/app/modules/home/view/order_history_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import 'drawer_listtile-widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  HomeProvider? homeScreenProvider;
  EstoreProvider? estoreProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeScreenProvider = context.read<HomeProvider>();
    estoreProvider = context.read<EstoreProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Responsive.width * 73,
      backgroundColor: AppConstants.drawerBgColor,
      child: ListView(
        children: [
          ListTile(
            title: const commonTextWidget(
              color: AppConstants.white,
              text: "OLYMPIC COMBAT",
              fontSize: 14,
            ),
            trailing: CommonInkwell(
              onTap: () {
                Routes.back();
              },
              child: Image.asset(
                AppImages.cancelVector,
                height: 10,
              ),
            ),
            leading: Image.asset(
              AppImages.onboardingLogo,
              height: 50,
              width: 50,
            ),
          ),
          SizeBoxH(Responsive.height * 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: Responsive.height * 10,
            width: Responsive.width * 100,
            // color: Colors.amber,
            child: FutureBuilder(
                future:
                    context.read<HomeProvider>().fetchUserDataAndCarouselData(),
                builder: (context, snapshot) {
                  return Row(
                    children: [
                      CommonInkwell(
                        onTap: () {
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (context) {
                          //     return Container(
                          //       height: Responsive.height * 20,
                          //       width: Responsive.width * 100,
                          //       padding:
                          //           const EdgeInsets.symmetric(horizontal: 15),
                          //       decoration: const BoxDecoration(
                          //         borderRadius: BorderRadius.only(
                          //           topLeft: Radius.circular(20),
                          //           topRight: Radius.circular(20),
                          //         ),
                          //         color: AppConstants.drawerBgColor,
                          //       ),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               const commonTextWidget(
                          //                 color: AppConstants.white,
                          //                 text: "Open with",
                          //                 fontSize: 14,
                          //               ),
                          //               TextButton(
                          //                 onPressed: () {
                          //                   Routes.back();
                          //                 },
                          //                 child: const commonTextWidget(
                          //                   color: AppConstants.red,
                          //                   text: "Cancel",
                          //                   fontSize: 14,
                          //                 ),
                          //               )
                          //             ],
                          //           ),
                          //           SizeBoxH(Responsive.height * 1.5),
                          //           Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceEvenly,
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.center,
                          //             children: [
                          //               GalleryOrCameraWidget(
                          //                 icon: AppImages.cameraIcon,
                          //                 title: "Camera",
                          //                 onTap: () {
                          //                   homeScreenProvider
                          //                       ?.changeProfilePhoto(
                          //                           false, context);
                          //                 },
                          //               ),
                          //               GalleryOrCameraWidget(
                          //                 icon: AppImages.galleryIcon,
                          //                 title: "Gallery",
                          //                 onTap: () {
                          //                   homeScreenProvider
                          //                       ?.changeProfilePhoto(
                          //                           true, context);
                          //                 },
                          //               ),
                          //             ],
                          //           )
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: snapshot.data?.userData?.image?.url != null
                                  ? Image.network(
                                      snapshot.data?.userData?.image?.url ?? "",
                                      fit: BoxFit.cover,
                                      width: Responsive.width * 20,
                                      height: Responsive.height * 10,
                                    )
                                  : homeScreenProvider?.thumbnailImage == null
                                      ? Image.asset(
                                          AppImages.profilePic,
                                          height: 70,
                                        )
                                      : Image.file(
                                          homeScreenProvider?.thumbnailImage ??
                                              File(""),
                                          fit: BoxFit.cover,
                                          width: Responsive.width * 20,
                                          height: Responsive.height * 10,
                                        ),
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              right: 20,
                              bottom: 20,
                              child: Image.asset(
                                AppImages.camera,
                                height: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizeBoxV(Responsive.width * 3),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonTextWidget(
                              color: AppConstants.white,
                              text:
                                  "${homeScreenProvider?.capitalizeFirstLetter(snapshot.data?.userData?.name ?? "")} ",
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            SizeBoxH(Responsive.height * 1),
                            commonTextWidget(
                              color: AppConstants.white,
                              text:
                                  "Membership ID:${snapshot.data?.userData?.id?.substring(snapshot.data!.userData!.id!.length - 7) ?? "xxxx"}"
                                      .toUpperCase(),
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
          SizeBoxH(Responsive.height * 1),
          DrawerListTileWidget(
            icon: AppImages.homeIcon,
            title: "Home",
            ontap: () {
              Navigator.of(context).pop();
            },
          ),
          DrawerListTileWidget(
            icon: AppImages.drawerCalenderIcon,
            title: "My booking",
            ontap: () {
              Routes.push(screen: const MyBookingScreen());
            },
          ),
          DrawerListTileWidget(
            icon: AppImages.orderIcon,
            title: "Order",
            ontap: () {
              estoreProvider?.getEstoreOrderHistory();
              Routes.push(screen: const OrderHistoryScreen());
            },
          ),
          DrawerListTileWidget(
            icon: AppImages.feedbackIcon,
            title: "Feedback",
            ontap: () {
              Routes.push(screen: const FeedBackScreen());
            },
          ),
          DrawerListTileWidget(
            icon: AppImages.referFriendIcon1,
            title: "Refer a friend",
            ontap: () {
              homeScreenProvider?.shareApp();
            },
          ),
          DrawerListTileWidget(
            icon: AppImages.contactUsIcon,
            title: "Contact Us",
            ontap: () {
              Routes.push(screen: const ContactUsScreen());
            },
          ),
          DrawerListTileWidget(
            icon: AppImages.faqIcon,
            title: "FAQ",
            ontap: () {
              Routes.push(screen: const FaqScreen());
            },
          ),
          SizeBoxH(Responsive.height * 1),
          Container(
            width: Responsive.height * 100,
            height: Responsive.height * 8,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonSocialMediaWidget(
                  title: "Facebook",
                  image: AppImages.facebook,
                  onTap: () {
                    homeScreenProvider
                        ?.launchUrl("https://www.facebook.com/olympiccombat");
                  },
                ),
                CommonSocialMediaWidget(
                  title: "Instagram",
                  image: AppImages.instagram,
                  onTap: () {
                    homeScreenProvider
                        ?.launchUrl("https://www.instagram.com/olympiccombat/");
                  },
                ),
                CommonSocialMediaWidget(
                  title: "Youtube",
                  image: AppImages.youtube,
                  onTap: () {
                    homeScreenProvider
                        ?.launchUrl("https://www.youtube.com/@OlympicCombat");
                  },
                ),
              ],
            ),
          ),
          SizeBoxH(Responsive.height * 0.8),
          DrawerListTileWidget(
            icon: AppImages.logout,
            title: "Logout",
            ontap: () {
              StringConst.logout();
            },
            isLogout: true,
          ),
          SizeBoxH(Responsive.height * 2)
        ],
      ),
    );
  }
}

class CommonSocialMediaWidget extends StatelessWidget {
  final void Function() onTap;
  final String image;
  final String title;
  const CommonSocialMediaWidget({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            image,
            height: 28,
          ),
          SizeBoxH(Responsive.height * 1),
          commonTextWidget(
            color: AppConstants.white,
            text: title,
            fontSize: 12,
          )
        ],
      ),
    );
  }
}

class GalleryOrCameraWidget extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onTap;
  const GalleryOrCameraWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 50,
          ),
          const SizeBoxH(10),
          commonTextWidget(
            color: AppConstants.white,
            text: title,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
