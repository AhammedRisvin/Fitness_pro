import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../utils/extensions.dart';
import '../view model/classbooking_provider.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ClassBookingProvider>(
      builder: (context, provider, _) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: CalendarWeek(
            // controller: provider.calendarWeekController,
            backgroundColor: AppConstants.drawerBgColor,
            dateStyle: const TextStyle(
              color: AppConstants.white,
              fontSize: 14,
            ),
            dayOfWeekStyle: const TextStyle(
              color: AppConstants.white,
            ),
            pressedDateBackgroundColor: AppConstants.appPrimaryColor,
            // dayShapeBorder: BoxShape.circle,
            todayBackgroundColor: provider.selectedDateT ==
                    DateFormat('yyyy-MM-dd').format(DateTime.now())
                ? AppConstants.appPrimaryColor
                : AppConstants.transparent,
            todayDateStyle: TextStyle(
              color: provider.selectedDateT ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now())
                  ? AppConstants.black
                  : AppConstants.white,
              fontWeight: FontWeight.w600,
            ),
            weekendsStyle: const TextStyle(
              color: AppConstants.white,
            ),
            pressedDateStyle: const TextStyle(
              color: AppConstants.black,
              fontWeight: FontWeight.w600,
            ),
            height: Responsive.height * 19,
            marginDayOfWeek: const EdgeInsets.symmetric(vertical: 18),
            monthAlignment: FractionalOffset.bottomCenter,
            showMonth: true,
            minDate:
                provider.currentWeekStartDate.subtract(const Duration(days: 7)),
            maxDate: provider.currentWeekStartDate.add(const Duration(days: 7)),
            onDatePressed: (DateTime datetime) {
              provider.selecteDateStringFn(datetime);
            },
            onWeekChanged: () {
              // Do something
            },
            monthViewBuilder: (DateTime time) => Align(
              alignment: FractionalOffset.center,
              child: Container(
                color: AppConstants.transparent,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  DateFormat.yMMMM().format(time),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppConstants.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
