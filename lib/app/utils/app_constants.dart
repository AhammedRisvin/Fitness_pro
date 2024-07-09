import 'package:flutter/material.dart';
import 'package:olympic/app/modules/auth/view%20model/auth_provider.dart';
import 'package:olympic/app/modules/home/view%20model/home_provider.dart';
import 'package:olympic/app/modules/onboarding/view%20model/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../modules/class booking/view model/classbooking_provider.dart';
import '../modules/estore/view model/estore_provider.dart';
import '../modules/facility rental/view model/facility_rental_provider.dart';
import '../modules/home/view model/payment_provider.dart';
import '../modules/pharma/view model/pharma_procider.dart';
import '../modules/pharmacy/view/view_model/pharmacy_provider.dart';
import '../modules/telemedicine/view_model/tele_medicine_provider.dart';

class AppConstants {
  //APP COLORS

  static const white = Color(0xFFFFFFFF);
  static const subTextGrey = Color(0xFFA5A5A5);
  static const appPrimaryColor = Color(0xFFFFDD11);
  static const transparent = Colors.transparent;
  static const black = Color(0xff000000);
  static final black10 = const Color(0xff000000).withOpacity(10);
  static const textFieldTextColor = Color(0xffCFCFCF);
  static final textFormFieldBg = const Color(0xff636363).withOpacity(10);
  static const drawerBgColor = Color(0xFF151515);
  static const red = Color(0xff95021d);
  static const darkYellow = Color(0xff302B0E);
  static final border = const Color(0xffFFFFFF).withOpacity(0.2);
  static const teleContainerBg = Color(0xff343434); //#2B2B2B
  static const searchColor = Color(0xff343434);
}

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: ((context) => OnBoardingProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => HomeProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => EstoreProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => ClassBookingProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => FacilityRentalProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => AuthProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => PaymentProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => PharmacyProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => TelemedicineProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => PharmaProvider()),
  ),
];
