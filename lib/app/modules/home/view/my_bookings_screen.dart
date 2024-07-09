import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/home/view%20model/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../widget/completed_booking_screen.dart';
import '../widget/upcoming_booking_screen.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  // HomeScreenProvider? homeScreenProvider;

  @override
  void initState() {
    super.initState();
    // homeScreenProvider = context.read<HomeScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "My Bookings",
          fontSize: 18,
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
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: Responsive.width * 100,
                  height: Responsive.height * 6.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppConstants.drawerBgColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommonInkwell(
                        onTap: () {
                          homeScreenProvider.setShowUpcomingList(true);
                        },
                        child: Container(
                          height: Responsive.height * 4.5,
                          width: Responsive.width * 43,
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: homeScreenProvider.showUpcomingList
                                ? AppConstants.darkYellow
                                : AppConstants.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: commonTextWidget(
                              color: homeScreenProvider.showUpcomingList
                                  ? AppConstants.appPrimaryColor
                                  : AppConstants.subTextGrey,
                              text: "Upcoming",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      CommonInkwell(
                        onTap: () {
                          homeScreenProvider.setShowUpcomingList(false);
                        },
                        child: Container(
                          height: Responsive.height * 4.5,
                          width: Responsive.width * 43,
                          margin: const EdgeInsets.only(right: 5, left: 5),
                          decoration: BoxDecoration(
                            color: homeScreenProvider.showUpcomingList
                                ? AppConstants.transparent
                                : AppConstants.darkYellow,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: commonTextWidget(
                              color: homeScreenProvider.showUpcomingList
                                  ? AppConstants.subTextGrey
                                  : AppConstants.appPrimaryColor,
                              text: "Completed",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                Expanded(
                  child: homeScreenProvider.showUpcomingList
                      ? const UpcomingList()
                      : const CompletedList(),
                ),
              ],
            ),
            // Positioned(
            //   bottom: Responsive.height * 5,
            //   child: CommonButton(
            //     onTap: () {
            //       Routes.push(screen: const ClassBookingHomeScreen());
            //     },
            //     text: "Book New Class",
            //     width: Responsive.width * 93,
            //     height: Responsive.height * 7,
            //     borderColor: AppConstants.transparent,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
