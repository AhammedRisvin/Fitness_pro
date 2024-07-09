import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/class%20booking/view%20model/classbooking_provider.dart';
import 'package:olympic/app/modules/home/view%20model/home_provider.dart';
import 'package:olympic/app/modules/home/view/subscription_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../models/class_model.dart';

class ClassDetailsScreen extends StatefulWidget {
  final ClassDatum classesWithSlote;
  final Slote? slote;
  const ClassDetailsScreen(
      {super.key, required this.classesWithSlote, required this.slote});

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  ClassBookingProvider? classBookingProvider;

  @override
  void initState() {
    super.initState();
    classBookingProvider = context.read<ClassBookingProvider>();
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
                  url: widget.classesWithSlote.classData?.image?.url ??
                      "https://media.gettyimages.com/id/117373714/photo/young-boy-with-black-belt-in-karate-kicking-in-air.jpg?s=612x612&w=0&k=20&c=16BUM3yN-19auVFYWJ7CpGIleHUVJX-5dEYUPENnu4E=",
                ),
                SizeBoxH(Responsive.height * 1.5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonTextWidget(
                            color: AppConstants.white,
                            text:
                                widget.classesWithSlote.classData?.title ?? "",
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          commonTextWidget(
                            color: AppConstants.subTextGrey,
                            text: widget
                                    .classesWithSlote.classData?.description ??
                                "",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            align: TextAlign.start,
                          ),
                          ClassDetailsStaticRow(
                            image: AppImages.ageContainer,
                            title: "Age",
                            subTitle:
                                "${widget.classesWithSlote.classData?.ageCategory?.fromAge ?? ""}-${widget.classesWithSlote.classData?.ageCategory?.toAge ?? ""}",
                          ),
                          ClassDetailsStaticRow(
                            image: AppImages.technicContainer,
                            title: "Class type",
                            subTitle:
                                widget.classesWithSlote.classData?.classType ??
                                    "",
                          ),
                          ClassDetailsStaticRow(
                            image: AppImages.dateContainer,
                            title: "Date",
                            subTitle: context
                                .read<ClassBookingProvider>()
                                .convertDateToMontFormate(),
                          ),
                          ClassDetailsStaticRow(
                            image: AppImages.timeContainer,
                            title: "Time",
                            subTitle:
                                "${classBookingProvider?.convertUtcToLocalTime(widget.slote?.time?.startTime ?? "") ?? ""} - ${classBookingProvider?.convertUtcToLocalTime(widget.slote?.time?.endTime ?? "") ?? ""}",
                          ),
                          ClassDetailsStaticRow(
                            image: AppImages.availableSlotContainer,
                            title: "Available slot",
                            subTitle:
                                "${(widget.classesWithSlote.classData?.availableSloteCount ?? 0) - (widget.slote?.availableSlote ?? 0)}/${widget.classesWithSlote.classData?.availableSloteCount ?? ""}",
                          ),
                          ClassDetailsStaticRow(
                            image: AppImages.ageContainer,
                            title: "Address",
                            subTitle:
                                "${context.read<HomeProvider>().capitalizeFirstLetter(widget.classesWithSlote.classData?.branch?.branchName ?? "")}\n${context.read<HomeProvider>().capitalizeFirstLetter(widget.classesWithSlote.classData?.branch?.address?.city ?? "")},${widget.classesWithSlote.classData?.branch?.address?.country ?? ""},${widget.classesWithSlote.classData?.branch?.address?.zipCode ?? ""}",
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8, bottom: 8),
                            child: CommonButton(
                              onTap: () {
                                if (context
                                            .read<HomeProvider>()
                                            .classLeftCount !=
                                        0 &&
                                    context
                                            .read<HomeProvider>()
                                            .classLeftCount >
                                        0) {
                                  context
                                      .read<ClassBookingProvider>()
                                      .classBookingFun(
                                          slotId: widget.slote?.sloteId ?? "",
                                          classId:
                                              widget.classesWithSlote.id ?? "",
                                          context: context);
                                } else {
                                  // Show the popup when "Book Now" is tapped
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: Stack(
                                          children: [
                                            Container(
                                              height: Responsive.height * 40,
                                              width: Responsive.width * 80,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color:
                                                    AppConstants.drawerBgColor,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const commonTextWidget(
                                                    color: AppConstants.white,
                                                    text: "Book a class",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  const commonTextWidget(
                                                    color: AppConstants
                                                        .subTextGrey,
                                                    text:
                                                        "Your class is empty please choose a plan or book one time",
                                                    fontSize: 17,
                                                  ),
                                                  // ClassDetailsStaticRow(
                                                  //   image: AppImages.karateStanding,
                                                  //   title: "Price for one time",
                                                  //   subTitle: "Aed 100",
                                                  // ),
                                                  CommonButton(
                                                    onTap: () {
                                                      Routes.back();
                                                      Routes.push(
                                                          screen:
                                                              const SubscriptionPlansScreen());
                                                    },
                                                    text: 'Choose a plan',
                                                    width:
                                                        Responsive.width * 80,
                                                    height:
                                                        Responsive.height * 5.2,
                                                  ),
                                                  // CommonButton(
                                                  //   onTap: () {},
                                                  //   text: 'Book one time',
                                                  //   width: Responsive.width * 80,
                                                  //   height: Responsive.height * 5.2,
                                                  //   bgColor: AppConstants.black,
                                                  //   textColor:
                                                  //       AppConstants.appPrimaryColor,
                                                  //   borderColor:
                                                  //       AppConstants.appPrimaryColor,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 10,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    AppConstants.black,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    size: 14,
                                                    color: AppConstants.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              text: "Book Now",
                              width: Responsive.width * 100,
                              height: Responsive.height * 6,
                            ),
                          ),
                          SizeBoxH(Responsive.height * .2),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                    text: "Class Details",
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

class ClassDetailsStaticRow extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  const ClassDetailsStaticRow({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          height: Responsive.height * 4.5,
        ),
        SizeBoxV(Responsive.width * 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonTextWidget(
              color: AppConstants.subTextGrey,
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
            ),
            SizeBoxH(Responsive.height * .3),
            commonTextWidget(
              color: AppConstants.white,
              text: subTitle,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
            ),
          ],
        )
      ],
    );
  }
}
