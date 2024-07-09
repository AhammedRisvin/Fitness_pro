// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/modules/auth/models/branch_model.dart';
import 'package:olympic/app/utils/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../core/estore_client_service.dart';
import '../../../core/firebase_api/notification_service.dart';
import '../../../core/server_client_services.dart';
import '../../../core/string_const.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/enums.dart';
import '../../facility rental/view model/facility_rental_provider.dart';
import '../../facility rental/view/bottom_nav_bar_screen.dart';
import '../../home/view/home_screen.dart';
import '../models/signin_model.dart';
import '../view/otp_screen.dart';
import 'number_length_validator.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  //PHONE NUMBER

  late String _selectedCountryCode = '+971';
  late int maxLength;

  AuthProvider() {
    updateMaxLength();
  }

  // String get selectedCountryCode => _selectedCountryCode;

  void updateCountryCode(String value) {
    _selectedCountryCode = value;
    updateMaxLength();
    notifyListeners();
  }

  void updateMaxLength() {
    maxLength = NumberValidation.getLength(_selectedCountryCode);
  }

  //phone number encrypting

  String decryptPhoneNumber(String encryptedPhoneNumber) {
    if (encryptedPhoneNumber.length < 4) {
      return encryptedPhoneNumber;
    }

    String firstFourDigits = encryptedPhoneNumber.substring(0, 3);
    String lastTwoDigits =
        encryptedPhoneNumber.substring(encryptedPhoneNumber.length - 3);

    String decryptedMiddle = '*' * (encryptedPhoneNumber.length - 7);

    return '$firstFourDigits$decryptedMiddle$lastTwoDigits';
  }

  String phoneNumber = '';
  //FACILITY RENTAL LOGIN
  FacilityLoginStatus facilityLoginStatus = FacilityLoginStatus.initial;

  Future<void> facilityRentalLoginFn({required BuildContext context}) async {
    LoadingOverlay.of(context).show();
    facilityLoginStatus = FacilityLoginStatus.loading;
    try {
      List response = await ServerClient.post(StringConst.facilityLogin,
          data: {
            "phone": _selectedCountryCode + phoneNumberController.text,
            "name": fullNameController.text,
          },
          post: true);

      log("reeree    :: ${response.last.toString()}");
      if (response.first >= 200 && response.first < 300) {
        log("resonse  :  $response");
        StringConst.addFacilityUserId(userId: response.last["userId"]);
        phoneNumber = _selectedCountryCode + phoneNumberController.text;

        log("phoneeee :  $phoneNumber");
        phoneNumberController.clear();
        fullNameController.clear();
        Routes.back();
        LoadingOverlay.of(context).hide();
        facilityLoginStatus = FacilityLoginStatus.loaded;
        showModalBottomSheet(
          backgroundColor: AppConstants.transparent,
          context: context,
          builder: (BuildContext context) {
            return const OtpScreen();
          },
        );
      } else {
        LoadingOverlay.of(context).hide();
        facilityLoginStatus = FacilityLoginStatus.error;
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      facilityLoginStatus = FacilityLoginStatus.error;
      throw Exception('Failed to fetch posts');
    }
  }

  // FACILITY RENTAL OTP VERIFICATION

  Future<void> facilityRentalOtpVerificationFn(
      {required BuildContext context}) async {
    LoadingOverlay.of(context).show();
    try {
      String userId = await StringConst.getFacilityUserId();
      log("userId  :  $userId");
      List response = await ServerClient.post(
        StringConst.facilityLoginOtp,
        data: {
          "otp": otpController.text,
          "userId": userId,
          "firbaseId": NotificationService().fcmToken
        },
        post: true,
      );
      if (response.first >= 200 && response.first < 300) {
        log("encryptedToken :  ${response.last["encryptedToken"]}");
        otpController.clear();
        StringConst.addUserToken(userToken: response.last["encryptedToken"]);
        StringConst.addIsFromMemberLogin(loginTrueOrFalse: "false");

        FacilityRentalProvider facilityRentalProvider =
            Provider.of<FacilityRentalProvider>(context, listen: false);
        await facilityRentalProvider.getFacilityListFn();
        LoadingOverlay.of(context).hide();
        Routes.pushRemoveUntil(screen: FacilityRentalBottomNav());
      } else if (response.first >= 300 && response.first < 500) {
        LoadingOverlay.of(context).hide();
        toast(context, title: "Check the Otp Entered");
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      throw Exception('Failed to fetch posts: $e');
    }
  }

//* Branch Select and Fetch branches */
  List<BranchDatum> branchDataList = [];
  Future<void> getBranchFn() async {
    try {
      List response = await ServerClient.get(
        StringConst.getBranch,
      );
      if (response.first >= 200 && response.first < 300) {
        GetBranchModel branchModel = GetBranchModel.fromJson(response.last);
        branchDataList.clear();
        branchDataList.addAll(branchModel.branchData ?? []);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    }
  }

  String selectedBranch = '';
  void selectBranchFn({required String branch}) {
    selectedBranch = branch;
    log("selectedBranch $selectedBranch");
    notifyListeners();
  }

//* Login signPasswordVisibility */
  bool isSignInhiddenPassword = true;
  signPasswordVisibility() {
    isSignInhiddenPassword = !isSignInhiddenPassword;
    notifyListeners();
  }

//* Login Fun*/
  Future<void> loginFun(BuildContext context) async {
    log(" firebaseId:   ${NotificationService().fcmToken}");
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "branch": selectedBranch,
        "password": passWordController.text,
        "userEmail": userNameController.text,
        "firebaseId": NotificationService().fcmToken
      };
      List response =
          await ServerClient.post(StringConst.userLogin, data: params);

      if (response.first >= 200 && response.first < 300) {
        SignInModel signInModel = SignInModel.fromJson(response.last);
        StringConst.addUserToken(
          userToken: signInModel.encryptedToken.toString(),
        );
        await StringConst.addIsFromMemberLogin(loginTrueOrFalse: "true");
        await StringConst.setUserId(userId: signInModel.userId.toString());
        await generateEstoreToken(context: context);
        LoadingOverlay.of(context).hide();
        Routes.pushRemoveUntil(screen: const HomeScreen());
      } else {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last,
          duration: 2,
          backgroundColor: AppConstants.red,
        );
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      throw Exception('Failed to fetch posts');
    } finally {
      // LoadingOverlay.of(context).hide();
    }
  }

  Future generateEstoreToken({
    required BuildContext context,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      final userId = await StringConst.getUserID();
      List response = await EstoreServerClient.tokenPost(
          StringConst.getEStoreGenerateTokenUrl,
          data: {
            "country": "United Arab Emirates",
            "appKey": "65f7d05df174e1715a51900f",
            "userId": userId
          });
      if (response.first >= 200 && response.first < 300) {
        log(response.last["token"]);
        await StringConst.storage.write(
          key: StringConst.eStoreToken,
          value: response.last["token"],
        );
        LoadingOverlay.of(context).hide();
      } else {
        LoadingOverlay.of(context).hide();
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      toast(
        context,
        title: "Try again",
        duration: 3,
        backgroundColor: AppConstants.red,
      );
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }
}
