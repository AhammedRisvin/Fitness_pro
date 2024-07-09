import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:olympic/app/core/app_router.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/loading_overlay.dart';

import '../../../core/server_client_services.dart';
import '../../../core/string_const.dart';
import '../../../utils/app_images.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
import '../../facility rental/view/facility_rental_home.dart';
import '../../home/view/my_bookings_screen.dart';
import '../models/class_model.dart';

class ClassBookingProvider extends ChangeNotifier {
  CalendarWeekController calendarWeekController = CalendarWeekController();
  late DateTime currentWeekStartDate;

  ClassBookingProvider() {
    initialize();
  }

  void initialize() {
    currentWeekStartDate = DateTime.now();
    selectedDateT = DateFormat('yyyy-MM-dd')
        .format(DateTime.now()); // Initialize with today's date
  }

  bool _isTodaySelected = false;
  // Getter for isTodaySelected
  bool get isTodaySelected => _isTodaySelected;

  // Setter for isTodaySelected
  set isTodaySelected(bool value) {
    _isTodaySelected = value;
    notifyListeners();
  }

  String selectedDateT = ''; // Store the selected date here

  // Getter for selectedDate
  selecteDateStringFn(DateTime value) {
    selectedDateT = DateFormat('yyyy-MM-dd').format(value);
    getAllClassesFn(selectedDateT);
    notifyListeners();
  }

//* Get All Classes  - start  */

  GetAllClassesStatus getAllClassesStatus = GetAllClassesStatus.initial;
  // GetClassesModel? classesModel;
  List<ClassDatum> classesModelList = [];

  Future<void> getAllClassesFn(String date) async {
    try {
      getAllClassesStatus = GetAllClassesStatus.loading;
      List response = await ServerClient.get(
        StringConst.getAllClasses + date,
      );
      if (response.first >= 200 && response.first < 300) {
        var classesModel = GetClassesModel.fromJson(response.last);
        log("response -----${classesModel.toJson()}");
        classesModelList.clear();
        classesModelList.addAll(classesModel.classData ?? []);

        log('startDate ${classesModelList[0].slotes?[0].time?.startTime}');
        getAllClassesStatus = GetAllClassesStatus.loaded;
        notifyListeners();
      } else {
        getAllClassesStatus = GetAllClassesStatus.loaded;
        getAllClassesStatus = GetAllClassesStatus.error;
        notifyListeners();
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getAllClassesStatus = GetAllClassesStatus.loaded;
      getAllClassesStatus = GetAllClassesStatus.error;
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
    notifyListeners();
  }

//* Class slot Time Convert  to local */
  String convertUtcToLocalTime(String utcTime) {
    final utcFormat = DateFormat('HH:mm');
    DateTime utcDateTime = utcFormat.parseUtc(utcTime);
    utcDateTime = utcDateTime.toLocal();
    final localFormat = DateFormat('hh:mm a');
    final newTime = localFormat.format(utcDateTime);
    log("new time $newTime  db time $utcTime");
    return newTime;
  }

  String convertDateToMontFormate() {
    DateTime date = DateTime.parse(selectedDateT);

    // Format the DateTime object into "MMM d" format
    String formattedDate = DateFormat("MMM d").format(date);

    // Add suffix to the day part
    String finalFormattedDate = formattedDate + getSuffix(date.day);
    log(finalFormattedDate);
    return finalFormattedDate;
  }

  String getSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

//end/

//** Class Booking Fn */

  Future<void> classBookingFun(
      {required String slotId,
      required String classId,
      required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "classId": classId,
        "sloteId": slotId,
        "date": selectedDateT
      };
      List response =
          await ServerClient.post(StringConst.bookClass, data: params);

      log('${response.last}');

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: Responsive.height * 40,
                width: Responsive.width * 90,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppConstants.black,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppConstants.drawerBgColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppImages.successImage))),
                    ),
                    const commonTextWidget(
                      text: "Successfull",
                      color: AppConstants.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                    const commonTextWidget(
                      text: "Class booking completed successfully",
                      color: AppConstants.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      align: TextAlign.center,
                      letterSpacing: 1.5,
                    ),
                    AlertDialogButtonWidget(
                      onTap: () {
                        Routes.back();
                        Routes.pushReplace(screen: const MyBookingScreen());
                      },
                      text: "Continue",
                      buttonBgColor: AppConstants.appPrimaryColor,
                      buttonBorderColor: AppConstants.black,
                      textColor: AppConstants.black,
                    ),
                  ],
                ),
              ),
            );
          },
        );

        notifyListeners();
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: AppConstants.red);
        notifyListeners();
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
    notifyListeners();
  }
}
