import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:olympic/app/modules/facility%20rental/view/terms_and_condition.dart';
import 'package:olympic/app/utils/enums.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../../../utils/shimmers.dart';
import '../../class booking/view/class_detaails_screen.dart';
import '../model/get_facility_slote_model.dart';
import '../view model/facility_rental_provider.dart';
import '../widget/calender_widget.dart';

class FacilityDetailsScreen extends StatefulWidget {
  const FacilityDetailsScreen({
    super.key,
  });

  @override
  State<FacilityDetailsScreen> createState() => _FacilityDetailsScreenState();
}

class _FacilityDetailsScreenState extends State<FacilityDetailsScreen> {
  FacilityRentalProvider? facilityRentalProvider;

  @override
  void initState() {
    super.initState();
    facilityRentalProvider = context.read<FacilityRentalProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                commonNetworkImage(
                  isTopCurved: false,
                  height: Responsive.height * 27,
                  width: Responsive.width * 100,
                  url: facilityRentalProvider?.slotdata?.image?.url ??
                      "https://media.gettyimages.com/id/117373714/photo/young-boy-with-black-belt-in-karate-kicking-in-air.jpg?s=612x612&w=0&k=20&c=16BUM3yN-19auVFYWJ7CpGIleHUVJX-5dEYUPENnu4E=",
                ),
                SizeBoxH(Responsive.height * 2),
              ],
            ),
            Positioned(
              top: Responsive.height * 27,
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizeBoxH(Responsive.height * 1.5),
                      commonTextWidget(
                        color: AppConstants.white,
                        text: facilityRentalProvider?.slotdata?.name ?? "",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      SizeBoxH(Responsive.height * 2),
                      commonTextWidget(
                        color: AppConstants.white,
                        fontSize: 15,
                        text: facilityRentalProvider?.slotdata?.about ??
                            "Experience the ultimate in comfort, convenience, and professionalism with our premium meeting room rental. Reserve your space today and elevate your next business meeting or event to new heights",
                        fontWeight: FontWeight.w500,
                        align: TextAlign.start,
                      ),
                      SizeBoxH(Responsive.height * 2),
                      // const commonTextWidget(
                      //   color: AppConstants.white,
                      //   fontSize: 15,
                      //   text: "Address",
                      //   fontWeight: FontWeight.w500,
                      //   align: TextAlign.start,
                      // ),
                      // SizeBoxH(Responsive.height * 2),
                      // commonTextWidget(
                      //   color: AppConstants.white,
                      //   fontSize: 15,
                      //   text: facilityRentalProvider?.slotdata?.address ??
                      //       "Experience the ultimate in comfort, convenience, and professionalism with our premium meeting room rental. Reserve your space today and elevate your next business meeting or event to new heights",
                      //   fontWeight: FontWeight.w500,
                      //   align: TextAlign.start,
                      // ),
                      ClassDetailsStaticRow(
                        image: AppImages.addressContainer,
                        title: "Address",
                        subTitle:
                            facilityRentalProvider?.slotdata?.address ?? "",
                      ),
                      SizeBoxH(Responsive.height * 2),
                      const commonTextWidget(
                        color: AppConstants.subTextGrey,
                        text: "Slots Available",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      SizeBoxH(Responsive.height * 2),
                      Selector<FacilityRentalProvider, String>(
                        selector: (_, facilityRentalProvider) =>
                            facilityRentalProvider.selectedDate,
                        builder: (_, selectedDate, __) {
                          return commonTextWidget(
                            color: AppConstants.white,
                            text: facilityRentalProvider?.today ==
                                    facilityRentalProvider
                                        ?.formatDateTimeToString(DateTime.now())
                                ? "Today, ${facilityRentalProvider?.getFormattedDate()}"
                                : selectedDate,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          );
                        },
                      ),
                      SizeBoxH(Responsive.height * 2),
                      const FacilityRentalCalenderWidget(),
                      SizeBoxH(Responsive.height * 2),
                      Selector<FacilityRentalProvider, List<Slot>>(
                        selector: (_, provider) => provider.slot,
                        builder: (context, slotList, _) {
                          if (slotList.isEmpty) {
                            return const commonTextWidget(
                              color: AppConstants.white,
                              text: "No Slot Available",
                            );
                          } else {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = slotList[index];
                                return facilityRentalProvider
                                            ?.getAllFacilitySlotStatus ==
                                        GetAllFacilitySlotStatus.loading
                                    ? const ShimmerSlotContainer()
                                    : facilityRentalProvider
                                                ?.getAllFacilitySlotStatus ==
                                            GetAllFacilitySlotStatus.loaded
                                        ? ApplyForRentContainer(
                                            facilityRentalProvider:
                                                facilityRentalProvider,
                                            singleSlot: data,
                                            price:
                                                "${data.fees?.currency} ${data.fees?.amount} ",
                                            time:
                                                "${facilityRentalProvider?.convertUtcToLocalTime(data.time?.startTime ?? "") ?? ""}-${facilityRentalProvider?.convertUtcToLocalTime(data.time?.endTime ?? "") ?? ""}",
                                            // time:
                                            //     "${data.time?.startTime} - ${data.time?.endTime} ",
                                          )
                                        : const commonTextWidget(
                                            color: AppConstants.white,
                                            text: "No Slot Available",
                                          );
                              },
                              separatorBuilder: (context, index) {
                                return SizeBoxH(Responsive.height * 2);
                              },
                              itemCount: slotList.length,
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 5,
              right: 0,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Routes.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppConstants.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const commonTextWidget(
                    color: AppConstants.white,
                    text: "Facility Details",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ApplyForRentContainer extends StatelessWidget {
  final String time;
  final String price;
  final Slot? singleSlot;
  final FacilityRentalProvider? facilityRentalProvider;
  const ApplyForRentContainer({
    super.key,
    required this.time,
    required this.price,
    this.facilityRentalProvider,
    this.singleSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 8,
      width: Responsive.width * 100,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              commonTextWidget(
                color: AppConstants.subTextGrey,
                text: time,
                fontSize: 14,
              ),
              commonTextWidget(
                color: AppConstants.white,
                text: price,
                fontSize: 14,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              singleSlot?.bookingStatus == "Waiting List"
                  ? CommonButton(
                      onTap: () {
                        log("aaaaaaaaaaaaaaa :{message}");
                      },
                      bgColor: const Color(0xff302B0E),
                      textColor: AppConstants.appPrimaryColor,
                      text: "Waiting List",
                      width: Responsive.width * 40,
                      height: Responsive.height * 5,
                      size: 14,
                    )
                  : singleSlot?.bookingStatus == "Available"
                      ? CommonButton(
                          onTap: () {
                            facilityRentalProvider?.applyForRentFn(
                              context: context,
                              singleSlotId: singleSlot?.sloteId,
                            );

                            log("  singleSlot?.id  :${singleSlot?.sloteId}");
                          },
                          text: "Apply for rent",
                          width: Responsive.width * 40,
                          height: Responsive.height * 5,
                          size: 14,
                        )
                      : singleSlot?.bookingStatus == "Booked"
                          ? CommonButton(
                              onTap: () {
                                toast(
                                  context,
                                  title:
                                      "Please select another slot for booking",
                                  backgroundColor: Colors.red,
                                );
                              },
                              bgColor: const Color(0xff302B0E),
                              textColor: AppConstants.appPrimaryColor,
                              text: "Booked",
                              width: Responsive.width * 40,
                              height: Responsive.height * 5,
                              size: 14,
                            )
                          : CommonButton(
                              onTap: () {
                                facilityRentalProvider
                                    ?.getSingleSlot(singleSlot);
                                Routes.push(
                                  screen:
                                      const FacilityRentalTermsAndConditionScreen(),
                                );
                              },
                              text: "Pay Now",
                              width: Responsive.width * 40,
                              height: Responsive.height * 5,
                              size: 14,
                            ),
            ],
          )
        ],
      ),
    );
  }
}
