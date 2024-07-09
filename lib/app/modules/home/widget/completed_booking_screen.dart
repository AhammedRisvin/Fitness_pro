import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
import '../../../utils/shimmers.dart';
import '../view model/home_provider.dart';

class CompletedList extends StatefulWidget {
  const CompletedList({Key? key}) : super(key: key);

  @override
  State<CompletedList> createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  @override
  void initState() {
    context.read<HomeProvider>().myBookingCompletedFn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      return value.bookingDetailModel.isEmpty
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonTextWidget(color: Colors.grey, text: 'No Bookings')
              ],
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final plans = value.bookingDetailModel[index];

                return value.booingCompletedStatus ==
                        MyBookingCompletedStatus.loading
                    ? const CardShimmers()
                    : Container(
                        height: Responsive.height * 17,
                        width: Responsive.width * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppConstants.drawerBgColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: [
                              commonNetworkImage(
                                height: Responsive.height * 12,
                                width: Responsive.width * 24,
                                url: "${plans.image?.url}",
                              ),
                              SizeBoxV(Responsive.width * 4),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonTextWidget(
                                      color: AppConstants.white,
                                      text:
                                          "${plans.ageCategory?.fromAge}-${plans.ageCategory?.toAge} age",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    commonTextWidget(
                                      color: AppConstants.white,
                                      text:
                                          "${plans.slotTime?.startTime} - ${plans.slotTime?.endTime}",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    commonTextWidget(
                                      color: AppConstants.white,
                                      text: '${plans.title}',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    commonTextWidget(
                                      color: AppConstants.white,
                                      text: DateFormat("MMM d").format(
                                          plans.dateForSlot ?? DateTime.now()),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
              },
              separatorBuilder: (context, index) {
                return SizeBoxH(Responsive.height * 2);
              },
              itemCount: value.bookingDetailModel.length,
            );
    });
  }
}
