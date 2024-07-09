// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/modules/facility%20rental/view/facility_rental_home.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:signature/signature.dart';

import '../../../core/app_router.dart';
import '../../../core/server_client_services.dart';
import '../../../core/string_const.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
import '../../../utils/loading_overlay.dart';
import '../model/get_all_facility_model.dart';
import '../model/get_booked_facility_model.dart';
import '../model/get_facility_slote_model.dart';
import '../view/facility_rental_booking.dart';

class FacilityRentalProvider extends ChangeNotifier {
  FacilityRentalProvider() {
    initialize();
    initializeUserId();
  }
  //GET USER ID
  String userId = '';
  Future<void> initializeUserId() async {
    userId = await StringConst.getFacilityUserId();
    log("userId  --  :  $userId");
  }

  //BOTTOM NAV
  final screens = [
    const FacilityRentalHomeScreen(),
    const FacilityRentalBookingsScreen()
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
  //BOTTOM NAV END

  // button

  bool _isFirstButtonVisible = true;

  bool get isFirstButtonVisible => _isFirstButtonVisible;

  void toggleButtonVisibility() {
    _isFirstButtonVisible = !_isFirstButtonVisible;
    notifyListeners();
  }

  //CALENDAR Start

  late CalendarWeekController calendarWeekController;
  late DateTime currentWeekStartDate;
  late DateTime date;

  void initialize() {
    calendarWeekController = CalendarWeekController();
    currentWeekStartDate = DateTime.now();
    date = DateTime.now();
  }

  void setSelectedDate(DateTime value) async {
    date = value;
    log("date : $date");
    notifyListeners();
  }

// today date for handling the ontap of the calender
  String today = '';
  String selectedDate = '';

  void SelectedDate(DateTime value) async {
    selectedDate = DateFormat('MMMM dd').format(value);
    log("date : $selectedDate");
    notifyListeners();
  }

  String formatDateTimeToString(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  void setSelectedDateAndFormat(DateTime dateTime) {
    setSelectedDate(dateTime);
    today = formatDateTimeToString(dateTime);
    SelectedDate(dateTime);
    notifyListeners();
  }

  //CALENDAR END

  //SIGN
  final SignatureController signController = SignatureController(
    penStrokeWidth: 3,
    penColor: AppConstants.white,
  );
  //SIGN END

  // GET FACILITIES LIST

  GetAllFacilityStatus getAllFacilityStatus = GetAllFacilityStatus.initial;

  List<SloteData> facilityDataList = [];

  Future<GetAllFacilityModel> getFacilityListFn() async {
    try {
      getAllFacilityStatus = GetAllFacilityStatus.loading;
      List response = await ServerClient.get(StringConst.facilityHomeList);
      if (response.first >= 200 && response.first < 300) {
        GetAllFacilityModel slotModel =
            GetAllFacilityModel.fromJson(response.last);

        facilityDataList.clear();
        facilityDataList.addAll(slotModel.sloteDatas ?? []);
        notifyListeners();
        getAllFacilityStatus = GetAllFacilityStatus.loaded;
        notifyListeners();
        return slotModel;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getAllFacilityStatus = GetAllFacilityStatus.error;
      throw Exception('Failed to fetch posts');
    }
  }

  //SINGLE FACILITY

  late SloteData? slotdata;

  getSingleFacility(SloteData? singleFacilityData) {
    slotdata = singleFacilityData;
    notifyListeners();
  }

  //Date

  String getFormattedDate() {
    DateTime now = DateTime.now();
    String monthName = DateFormat('MMMM').format(now);
    String day = DateFormat('d').format(now);
    return '$monthName $day';
  }

  // GET BOOKED FACILITIES LIST

  GetAllBookedFacilityStatus getAllBookedFacilityStatus =
      GetAllBookedFacilityStatus.initial;

  List<SlotesWithBooking> bookedFacilityList = [];

  Future<GetBookedFacilityModel> getBookedFacilityListFn() async {
    getAllBookedFacilityStatus = GetAllBookedFacilityStatus.loading;

    try {
      List response = await ServerClient.get(StringConst.facilityBookingList);
      if (response.first >= 200 && response.first < 300) {
        GetBookedFacilityModel slotModel =
            GetBookedFacilityModel.fromJson(response.last);

        log("   status :  ${slotModel.slotesWithBookings?.length}");

        bookedFacilityList.clear();
        bookedFacilityList.addAll(slotModel.slotesWithBookings ?? []);
        notifyListeners();
        getAllBookedFacilityStatus = GetAllBookedFacilityStatus.loaded;
        notifyListeners();
        return slotModel;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getAllBookedFacilityStatus = GetAllBookedFacilityStatus.error;
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  //GET SLOTS

  GetAllFacilitySlotStatus getAllFacilitySlotStatus =
      GetAllFacilitySlotStatus.initial;

  List<Slot> slot = <Slot>[];

  Future<void> facilityGetSlotFn() async {
    getAllFacilitySlotStatus = GetAllFacilitySlotStatus.loading;
    try {
      List response = await ServerClient.post(StringConst.facilityGetSlot,
          data: {
            "facilityId": slotdata?.id,
            "date": date.toString(),
          },
          post: true);

      log("slot  ::${response.last}");
      if (response.first >= 200 && response.first < 300) {
        GetFacilitySlotModel slotModel =
            GetFacilitySlotModel.fromJson(response.last);
        slot.clear();
        slot = slotModel.slots ?? [];
        notifyListeners();

        getAllFacilitySlotStatus = GetAllFacilitySlotStatus.loaded;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getAllFacilitySlotStatus = GetAllFacilitySlotStatus.error;
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

// APPLY FOR RENT

  Future<void> applyForRentFn({
    required BuildContext context,
    required String? singleSlotId,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(StringConst.applyForFacility,
          data: {
            "facilityId": slotdata?.id,
            "sloteId": singleSlotId,
            "dateForSlot": date.toString(),
          },
          post: true);

      if (response.first >= 200 && response.first < 300) {
        log("resonse  :  $response");

        await facilityGetSlotFn();
        await getBookedFacilityListFn();

        LoadingOverlay.of(context).hide();
      } else if (response.first == 400) {
        LoadingOverlay.of(context).hide();
        toast(context, title: 'You Already Applied For This Slot');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      getAllFacilitySlotStatus = GetAllFacilitySlotStatus.error;
      throw Exception('Failed to fetch posts');
    }
  }

  // STRIPE PAYMENT

  //SINGLE FACILITY

  late Slot? singleSlot;

  getSingleSlot(Slot? singleSlotData) {
    singleSlot = singleSlotData;
    notifyListeners();
  }

  String paymentIntentId = '';
  Future stripeFn({
    required String? singleSlotId,
    required String? bookingId,
    required BuildContext context,
  }) async {
    try {
      List response = await ServerClient.post(
        StringConst.facilityStripeUrl,
        data: {
          "amount": "1",
          "currency": "INR",
          "facilityId": slotdata?.id,
          "sloteId": singleSlotId,
          "date": date.toString()
        },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        log(response.last['clientSecret']);
        paymentIntentId = response.last['clientSecret'];
        log("payment intend id :  $paymentIntentId");

        makeStripePayment(
            singleSlotId: singleSlotId, bookingId: bookingId, context: context);
      } else if (response.first >= 300 && response.first < 500) {
        toast(
          context,
          title: "Slot Already Booked",
          backgroundColor: Colors.red,
        );
        facilityGetSlotFn();
        Routes.back();
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<void> makeStripePayment({
    required singleSlotId,
    required bookingId,
    required context,
  }) async {
    try {
      try {
        log('aaaaaaaaaaaaaaaaaaaaaaaa');
        log(paymentIntentId.toString());
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                // googlePay:
                //     const PaymentSheetGooglePay(merchantCountryCode: "USD"),
                merchantDisplayName: "prospect",
                // customerId: paymentIntentData!["customer"],
                paymentIntentClientSecret: paymentIntentId

                // customerEphemeralKeySecret:
                //     paymentIntentData!["ephemeralkey"]

                ));
        log('bbbbbbbbbbbbbbbbbbbbbbbbbb');
      } catch (e) {
        log("message$e");
      }
      //STEP 3: Display Payment sheet
      try {
        log('cccccccccccccccccccccccc');
        await Stripe.instance.presentPaymentSheet().then((value) async {});
        log(' singleSlotId  : $singleSlotId');
        await paymentValidationFn(
          clintId: paymentIntentId,
          singleSlotId: singleSlotId,
          bookingId: bookingId,
          context: context,
        );

        log("success");
      } on Exception catch (e) {
        log('message');
        log(e.toString());
        if (e is StripeException) {
          log("error from stripe $e");
        } else {
          log("Unforeseen erro $e");
        }
      } catch (e) {
        log("Exceptio   ---$e");
      }
      // displayPaymentSheet();
    } catch (err) {
      log('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      // hideLoading();
      log(err.toString());
    }
  }

  Future paymentValidationFn({
    required clintId,
    required singleSlotId,
    required bookingId,
    required context,
  }) async {
    // log('aaaaaaaaaaaaaaaaaaaaaaaa');
    try {
      List response = await ServerClient.post(
        StringConst.facilityPaymentValidationUrl,
        data: {
          "clientSecret": clintId,
          "facilityId": slotdata?.id,
          "sloteId": singleSlotId,
          "date": date.toString(),
          "bookingId": bookingId,
        },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        log('apiiiiiiiiiiiiiiiiiiiiiiiiiiiii');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: Responsive.height * 30,
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
                    const commonTextWidget(
                      text: "Successful",
                      color: AppConstants.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                    const commonTextWidget(
                      text: "facility booking completed successfully",
                      color: AppConstants.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      align: TextAlign.center,
                      letterSpacing: 1.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AlertDialogButtonWidget(
                          onTap: () {
                            Navigator.of(context).pop();
                            facilityGetSlotFn();
                            getFacilityListFn();
                            getBookedFacilityListFn();
                            signController.clear();
                            Routes.back();
                          },
                          text: "Continue",
                          buttonBgColor: AppConstants.appPrimaryColor,
                          buttonBorderColor: AppConstants.black,
                          textColor: AppConstants.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    }
  }

  //CONVERTING UTC INTO LOCAL TIME

  String? formatTime(String? dateTime) {
    if (dateTime != null) {
      String utcTimeString = dateTime;
      DateTime utcTime = DateTime.parse(utcTimeString);
      DateTime localTime = utcTime.toLocal();

      // Format the time as 'hh:mm a'
      // String formattedTime = DateFormat('hh:mm a').format(localTime);
      final formatter = DateFormat('MM-dd-yy')
          .format(localTime); // Define your desired format
      print('Time: $formatter');

      return formatter;
    }
    return ""; // or return an appropriate default value or message
  }

  String convertUtcToLocalTime(String utcTime) {
    // Parse the UTC time string to DateTime object
    final utcFormat = DateFormat('HH:mm');
    DateTime utcDateTime = utcFormat.parse(utcTime);

    // Adjust UTC time to Dubai time (UTC+4)
    utcDateTime = utcDateTime.add(const Duration(hours: 4));

    // Format the local time in Dubai time zone
    final dubaiFormat = DateFormat('hh:mm a');
    return dubaiFormat.format(utcDateTime);
  }
}
