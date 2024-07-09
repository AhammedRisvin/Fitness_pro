import 'package:flutter/material.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../view_model/tele_medicine_provider.dart';
import 'tele_appointment_details.dart';

class TeleAppointmentScreen extends StatelessWidget {
  const TeleAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: AppConstants.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(105),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizeBoxH(25),
              IconButton(
                onPressed: () {
                  Routes.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppConstants.white,
                  size: 20,
                ),
              ),
              const TabBar(
                dividerHeight: 1, dividerColor: AppConstants.teleContainerBg,
                indicator: BoxDecoration(
                    color: AppConstants.appPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                // indicatorColor: Color(0xFFC1AE97),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 6,
                labelStyle: TextStyle(
                  color: AppConstants.appPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
                unselectedLabelColor: Color(0xFFAAA9A8),
                indicatorPadding: EdgeInsets.only(left: 8.0, top: 45),
                // padding: EdgeInsets.only(bottom: 5),
                tabs: [
                  Tab(
                    text: 'Upcoming',
                  ),
                  Tab(
                    text: 'Completed',
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              height: Responsive.height * 100,
              width: Responsive.width * 100,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 4,
                  separatorBuilder: (context, index) => const Divider(
                        height: 20,
                        thickness: 1,
                        color: AppConstants.teleContainerBg,
                      ),
                  itemBuilder: (context, index) => const TeleAppointmentWidget(
                        isUpcomming: true,
                      )),
            ),
            Container(
              height: Responsive.height * 100,
              width: Responsive.width * 100,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 4,
                  separatorBuilder: (context, index) => const Divider(
                        height: 20,
                        thickness: 1,
                        color: AppConstants.teleContainerBg,
                      ),
                  itemBuilder: (context, index) => CommonInkwell(
                        onTap: () {
                          Routes.push(
                              screen: const TeleAppointmentDetailsScreen());
                        },
                        child: const TeleAppointmentWidget(
                          isUpcomming: false,
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}

class TeleAppointmentWidget extends StatelessWidget {
  final bool isUpcomming;
  const TeleAppointmentWidget({super.key, this.isUpcomming = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Responsive.height * 30,
      width: Responsive.width * 100,
      child: Column(
        children: [
          const SizeBoxH(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 122,
                width: 121,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppConstants.white),
                child: const commonNetworkImage(
                    height: 117,
                    width: 121,
                    fit: BoxFit.cover,
                    isTopCurved: true,
                    radius: 15,
                    url:
                        'https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg'),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  width: Responsive.width * 53,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const commonTextWidget(
                            text: 'D.r Amanda',
                            color: AppConstants.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          Container(
                            height: 20,
                            width: 48,
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppConstants.black),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppConstants.appPrimaryColor,
                                ),
                                SizeBoxV(2),
                                commonTextWidget(
                                  text: '4.3',
                                  color: AppConstants.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const commonTextWidget(
                        text: 'Cardiolagist',
                        color: AppConstants.appPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      const commonTextWidget(
                        text: '10  Years Experience',
                        color: AppConstants.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizeBoxH(5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 245, 44, 81),
                                borderRadius: BorderRadius.circular(30)),
                            child: const Center(
                              child: Icon(
                                Icons.favorite,
                                size: 12,
                                color: AppConstants.white,
                              ),
                            ),
                          ),
                          const SizeBoxV(5),
                          const commonTextWidget(
                            text: '100+',
                            color: AppConstants.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizeBoxV(5),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Booking ID :",
                              style: TextStyle(
                                color: AppConstants.white,
                                fontSize: 13,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.30,
                              ),
                            ),
                            TextSpan(
                              text: ' #1233265',
                              style: TextStyle(
                                color: AppConstants.appPrimaryColor,
                                fontSize: 14,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                letterSpacing: -0.30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizeBoxV(5),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Status :",
                              style: TextStyle(
                                color: AppConstants.white,
                                fontSize: 13,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.30,
                              ),
                            ),
                            TextSpan(
                              text: ' Completed',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                letterSpacing: -0.30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizeBoxH(15),
          isUpcomming == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        height: 32,
                        child: IconButton(
                            style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: AppConstants.teleContainerBg),
                            onPressed: () {},
                            icon: const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 18,
                                  color: AppConstants.appPrimaryColor,
                                ),
                                SizeBoxV(5),
                                commonTextWidget(
                                  text: 'Add rate',
                                  color: AppConstants.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            )),
                      ),
                    ),
                    CommonButton(
                        onTap: () {},
                        text: 'Download',
                        radius: 10,
                        size: 12,
                        width: Responsive.width * 23,
                        height: 32)
                  ],
                )
              : CommonButton(
                  onTap: () {
                    context.read<TelemedicineProvider>().checkIfAppInstalled(
                        link: context
                            .read<TelemedicineProvider>()
                            .trimZoomUrl('https://zoom.us/j/5551112222.'));
                  },
                  text: 'Start At 10:30 A.M',
                  width: Responsive.width * 75,
                  radius: 10,
                  size: 14,
                  height: 40),
          const SizeBoxH(5),
        ],
      ),
    );
  }
}
