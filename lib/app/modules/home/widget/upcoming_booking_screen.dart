import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
import '../../../utils/shimmers.dart';
import '../view model/home_provider.dart';

class UpcomingList extends StatefulWidget {
  const UpcomingList({Key? key}) : super(key: key);

  @override
  State<UpcomingList> createState() => _UpcomingListState();
}

class _UpcomingListState extends State<UpcomingList> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().myUpcomingBookingCompletedFn();
  }

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<HomeProvider>(context);
    return Consumer<HomeProvider>(
      builder: (context, value, child) => value
              .upcomingbookingDetailModel.isEmpty
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonTextWidget(color: Colors.grey, text: 'No Bookings')
              ],
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final plans = value.upcomingbookingDetailModel[index];
                return value.upcomingBooingCompletedStatus ==
                        MyUpcomingBookingCompletedStatus.loading
                    ? const CardShimmers()
                    : Container(
                        height: Responsive.height * 21,
                        width: Responsive.width * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppConstants.drawerBgColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  commonNetworkImage(
                                    height: Responsive.height * 12,
                                    width: Responsive.width * 24,
                                    url: "${plans.image?.url}",
                                  ),
                                  SizeBoxH(Responsive.height * 1),
                                ],
                              ),
                              SizeBoxV(Responsive.width * 4),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonTextWidget(
                                      color: AppConstants.white,
                                      text:
                                          "${plans.ageCategory?.fromAge}-${plans.ageCategory?.toAge} age",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    commonTextWidget(
                                      color: AppConstants.white,
                                      text:
                                          "${value.convertUtcToLocalTime(plans.slotTime?.startTime ?? '')} - ${value.convertUtcToLocalTime(plans.slotTime?.endTime ?? '')}",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    commonTextWidget(
                                      color: AppConstants.white,
                                      text: '${plans.title}',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    commonTextWidget(
                                      color: AppConstants.appPrimaryColor,
                                      text: DateFormat("MMM d").format(
                                          plans.dateForSlot ?? DateTime.now()),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    CommonInkwell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              content: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 10,
                                                ),
                                                height: Responsive.height * 50,
                                                width: Responsive.width * 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: AppConstants.black,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      AppImages
                                                          .cancelshowdialog,
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    SizeBoxH(
                                                        Responsive.height * 2),
                                                    const commonTextWidget(
                                                      color: Colors.white,
                                                      text:
                                                          'Cancel the Booking?',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                    SizeBoxH(Responsive.height *
                                                        0.5),
                                                    const commonTextWidget(
                                                        align: TextAlign.start,
                                                        color:
                                                            Color(0xffA5A5A5),
                                                        text:
                                                            'Are you sure you want to cancel Booking?'),
                                                    SizeBoxH(
                                                        Responsive.height * 3),
                                                    CommonButton(
                                                      onTap: () {
                                                        tabProvider
                                                            .bookingCancelFnc(
                                                                bookingId: plans
                                                                    .bookingId
                                                                    .toString(),
                                                                classsId: plans
                                                                    .classId
                                                                    .toString(),
                                                                sloteId: plans
                                                                    .sloteId
                                                                    .toString(),
                                                                index: index,
                                                                context:
                                                                    context);
                                                        // Routes.back();
                                                      },
                                                      text: "yes,cancel",
                                                      width: Responsive.width *
                                                          100,
                                                      height:
                                                          Responsive.height *
                                                              6.5,
                                                      bgColor: const Color(
                                                          0xffD92D20),
                                                      textColor:
                                                          AppConstants.white,
                                                      borderColor: const Color(
                                                          0xffD92D20),
                                                    ),
                                                    SizeBoxH(
                                                        Responsive.height * 2),
                                                    CommonButton(
                                                      onTap: () {
                                                        Routes.back();
                                                      },
                                                      text: "Back",
                                                      width: Responsive.width *
                                                          100,
                                                      height:
                                                          Responsive.height *
                                                              6.5,
                                                      bgColor:
                                                          AppConstants.white,
                                                      textColor:
                                                          AppConstants.black,
                                                      borderColor:
                                                          AppConstants.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: Responsive.height * 4.5,
                                        width: Responsive.width * 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: AppConstants.darkYellow,
                                        ),
                                        child: const Center(
                                          child: commonTextWidget(
                                            color: AppConstants.appPrimaryColor,
                                            text: "Cancel Booking",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
              separatorBuilder: (context, index) {
                return SizeBoxH(Responsive.height * 2);
              },
              itemCount: value.upcomingbookingDetailModel.length,
            ),
    );
  }
}
