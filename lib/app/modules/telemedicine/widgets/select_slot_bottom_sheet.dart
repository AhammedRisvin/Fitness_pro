import 'dart:developer';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:olympic/app/core/app_router.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/modules/telemedicine/view/doctor/doctor_details_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../helpers/size_box.dart';

void selectYourSlotBottomSheet(
  BuildContext context,
) {
  // Define the animation controller
  final AnimationController controller = AnimationController(
    // animationBehavior: AnimationBehavior.normal,
    reverseDuration: const Duration(milliseconds: 1400),
    duration: const Duration(milliseconds: 1200), // You can adjust the duration
    vsync: Navigator.of(context),
  );

  // Define the animation
  final Animation<double> animation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(controller);

  // Start the animation when the bottom sheet is opened
  showModalBottomSheet(
    backgroundColor: AppConstants.black,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      // Wrap the content with the AnimatedBuilder to control the animation
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final screenHeight = MediaQuery.of(context).size.height;
          final bottomSheetHeight = screenHeight * 0.70;

          return Container(
            height: bottomSheetHeight,
            clipBehavior: Clip.antiAlias,
            decoration: const ShapeDecoration(
              color: AppConstants.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            child: Opacity(
              opacity: animation.value,
              child: Column(
                children: [
                  //BottomSheet Appbar
                  SizedBox(
                    height: Responsive.height * 11,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  size: 28,
                                  color: AppConstants.white,
                                ),
                                onPressed: () => Routes.back(),
                              ),
                              const Expanded(
                                child: Text(
                                  'Please select a slot',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppConstants.white,
                                    fontSize: 18,
                                    fontFamily: 'Roboto Flex',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizeBoxH(5),
                          const Divider(
                            color: AppConstants.teleContainerBg,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Bottom sheet Body part
                  SizedBox(
                    height: Responsive.height * 48,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EasyDateTimeLine(
                              // activeColor: white,

                              initialDate: DateTime.now(),
                              onDateChange: (selectedDate) {
                                final now = DateTime.now();
                                DateTime dayBeforeToday =
                                    now.subtract(const Duration(days: 1));
                                final DateTime sevenDaysFromNow =
                                    now.add(const Duration(days: 13));
                                // Disable past dates
                                bool isDisabled =
                                    selectedDate.isBefore(dayBeforeToday);

                                bool isDisabledAfterSevendays =
                                    selectedDate.isBefore(dayBeforeToday) ||
                                        selectedDate.isAfter(sevenDaysFromNow);
                                if (isDisabled) {
                                  toast(context,
                                      title: "Please check the selected date");
                                  log("not booking");
                                } else if (isDisabledAfterSevendays) {
                                  toast(context,
                                      duration: 3,
                                      title:
                                          "Please check the selected date and  try again tomorrow.");
                                } else {
                                  log(" booking");
                                  log("selectedDate $selectedDate");
                                  // DateTime inputDate =
                                  //     DateTime.parse(selectedDate.toString());

                                  // String formattedDate =
                                  //     DateFormat('MM/dd/yyyy')
                                  //         .format(inputDate);

                                  // telemedicineDoctorBookingController
                                  //     .getDoctorDetailsAndSlotsFn(
                                  //         doctorId:
                                  //             doctorModel.id.toString(),
                                  //         date: formattedDate);
                                  // String formattedSelectedDate =
                                  //     DateFormat('MM-dd-yyyy')
                                  //         .format(inputDate);
                                  // telemedicineDoctorBookingController
                                  //     .selectDateForDoctorBooking(
                                  //         formattedSelectedDate);
                                }
                                //`selectedDate` the new date selected.
                              },
                              dayProps: const EasyDayProps(
                                height: 60,
                                // You must specify the width in this case.
                                width: 45,
                              ),
                              headerProps: const EasyHeaderProps(
                                selectedDateStyle: TextStyle(
                                    color: AppConstants.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                                monthStyle: TextStyle(
                                    backgroundColor: AppConstants.black,
                                    color: AppConstants.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                                selectedDateFormat:
                                    SelectedDateFormat.fullDateMonthAsStrDY,
                              ),
                              itemBuilder: (BuildContext context,
                                  String dayNumber,
                                  dayName,
                                  monthName,
                                  fullDate,
                                  isSelected) {
                                final now = DateTime.now();

                                DateTime currentDate =
                                    DateTime.parse(fullDate.toString());

                                DateTime dayBeforeToday =
                                    now.subtract(const Duration(days: 1));
                                final DateTime sevenDaysFromNow =
                                    now.add(const Duration(days: 13));
                                // Disable past dates
                                bool isDisabled =
                                    currentDate.isBefore(dayBeforeToday) ||
                                        currentDate.isAfter(sevenDaysFromNow);

                                return Container(
                                  //the same width that provided previously.
                                  height: 60,
                                  width: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: ShapeDecoration(
                                    color: isDisabled
                                        ? const Color.fromARGB(
                                            255, 250, 126, 126)
                                        : isSelected
                                            ? AppConstants.appPrimaryColor
                                            : AppConstants.teleContainerBg,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          dayNumber == now.day.toString()
                                              ? "Today"
                                              : dayName[0].toUpperCase() +
                                                  dayName
                                                      .substring(1)
                                                      .toLowerCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: isDisabled
                                                ? Colors.black
                                                : isSelected
                                                    ? Colors.black
                                                    : AppConstants.white,
                                            fontSize: 12,
                                            fontFamily: 'Roboto Flex',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                            letterSpacing: 0.06,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        dayNumber,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: isDisabled
                                              ? Colors.black
                                              : isSelected
                                                  ? Colors.black
                                                  : AppConstants
                                                      .appPrimaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Roboto Flex',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                          letterSpacing: 0.07,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizeBoxH(15),
                                    const Text(
                                      'Book your slot',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppConstants.appPrimaryColor,
                                        fontSize: 18,
                                        fontFamily: 'Roboto Flex',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                        letterSpacing: 0.09,
                                      ),
                                    ),
                                    const SizeBoxH(10),
                                    Wrap(
                                      children: List.generate(
                                        10,
                                        (index) {
                                          var slot = index;

                                          return CommonInkwell(
                                            onTap: () {},
                                            // splashColor:
                                            //     Color(0xFFC1AE97),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Container(
                                                width: 80,
                                                height: 40,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: ShapeDecoration(
                                                  color: AppConstants
                                                      .teleContainerBg,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  slot.toString(),
                                                  style: const TextStyle(
                                                    color: Color(0xFFC0C5D5),
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto Flex',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                    letterSpacing: -0.30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  //bottom sheet bottom bar
                  BookNowWidget(
                    onTap: () {},
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );

  // Start the animation
  controller.forward();
}
