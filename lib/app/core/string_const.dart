import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:olympic/app/core/app_router.dart';
import 'package:olympic/app/env.dart';
import 'package:olympic/app/modules/onboarding/view/splash_screen.dart';

class StringConst {
  static const storage = FlutterSecureStorage();

  static String token = "userToken";
  static String eStoreToken = "eStorToken";
  static String facilityLoginUserId = "facilityLoginUserId";
  static String isFromMemberLogin = "";
  // static String showCase = 'Show Case';

  // static String name = "nameEatplek";
  // static String isLogin = "isLoginEatplek";
  // static String phoneNumber = "phoneNumberEatplek";
  // static String vendorData = "vendorDataEatplek";
  // static String hotelID = "hotelIdEatplek";
  // static String openTime = "openTimeEatplek";
  // static String closeTime = "closeTimeEatplek";

  static Future<void> logout() async {
    await storage.deleteAll();
    Routes.pushRemoveUntil(screen: const SplashScreen());
  }

  static Future<String> getUserToken() async {
    return await storage.read(key: token) ?? "";
  }

  static Future<void> addUserToken({required String userToken}) async {
    await storage.write(key: token, value: userToken);
  }

  static Future<String> getIsFromMemberLogin() async {
    return await storage.read(key: isFromMemberLogin) ?? "";
  }

  static Future<void> addIsFromMemberLogin(
      {required String loginTrueOrFalse}) async {
    await storage.write(key: isFromMemberLogin, value: loginTrueOrFalse);
  }

  static Future<String> getUserID() async {
    return await storage.read(key: 'userId') ?? "";
  }

  static Future<void> setUserId({required String userId}) async {
    await storage.write(key: 'userId', value: userId);
  }

  // static Future<String> getOpenTime() async {
  //   return await storage.read(key: openTime) ?? "";
  // }

  // static Future<String> getCloseTime() async {
  //   return await storage.read(key: closeTime) ?? "";
  // }

  static Future<void> addFacilityUserId({required String userId}) async {
    await storage.write(key: facilityLoginUserId, value: userId);
  }

  static Future<String> getFacilityUserId() async {
    return await storage.read(key: facilityLoginUserId) ?? "";
  }
  // static Future<void> addOpenTime({required String openTimes}) async {
  //   await storage.write(key: openTime, value: openTimes);
  // }

  // static Future<void> addCloseTime({required String closeTimes}) async {
  //   await storage.write(key: closeTime, value: closeTimes);
  // }

  // Api's

  static String baseUrl = Environments.baseUrl;
  static String estoreBaseUrl = Environments.estoreBaseUrl;
  static String facilityLogin = "${baseUrl}facility/login";
  static String facilityLoginOtp = "${baseUrl}facility/verifyOtp";
  static String facilityHomeList = "${baseUrl}facility/getAllFacility";
  static String facilityBookingList = "${baseUrl}facility/getBookings";
  static String facilityGetSlot = "${baseUrl}facility/getSlotes";
  static String applyForFacility = "${baseUrl}facility/applyForRent";
  static String facilityStripeUrl =
      '${baseUrl}facility/checkout-stripe-payment';
  static String facilityPaymentValidationUrl =
      '${baseUrl}facility/checkout-stripe-payment-success';

  static String getAllPlansUrl = '${baseUrl}user/getAllPlans';
  static String stripeUrl = '${baseUrl}user/stripePayment';
  static String paymentValidationUrl = '${baseUrl}user/stripeValidation';
  static String myBookingCompletedUrl = '${baseUrl}user/getCompletedClass';
  static String postFeedback = '${baseUrl}user/addFeedback';

  // static String getHotels = "${baseUrl}hotel/getHotels";
  static String bookClass = "${baseUrl}user/bookClass";
  static String userLogin = "${baseUrl}user/login";
  static String getHomeData = "${baseUrl}user/getHomeDatas";
  static String getTrainingVideos = "${baseUrl}user/getTrainingVideos";
  static String qrUsingAttendens = "${baseUrl}user/addAttendense";
  // static String getAllClasses = "${baseUrl}user/getAllClasses";
  static String upComingbookingUrtl = "${baseUrl}user/getUpcomingClass";
  static String bookingCancelUrtl = "${baseUrl}user/cancelBooking";
  static String getAllClasses = "${baseUrl}user/getAllClasses?date=";
  static String getBranch = "${baseUrl}user/getAllBranches";

  // Estore

  static String getOrderHIstory = "${estoreBaseUrl}order";
  static String getOrderCategory = "${estoreBaseUrl}app/categories";
  static String getEStoreGenerateTokenUrl = '${estoreBaseUrl}app/token';

  static String getEStoreItemUrl = '${estoreBaseUrl}product';
  static String getEStoreWishListUrl = '${estoreBaseUrl}wishlist';
  static String getEStoreCartUrl = '${estoreBaseUrl}cart';
  static String eStoreStripeUrl = '${estoreBaseUrl}order/stripePayment';
  static String eStorePlaceOrderUrl = '${estoreBaseUrl}order';

  static String grtEstorSerchingUrl = '${estoreBaseUrl}product/search?keyword=';
  // static String updateName = "${baseUrl}user/nameUpdate";
  // static String addingToCart = "${baseUrl}cart/create";
  // static String getCartList = "${baseUrl}cart/getCart";
  // static String deleteCart = "${baseUrl}cart/removeCart";
  // static String getCarousal = "${baseUrl}carousel";
  // static String updateCart = "${baseUrl}cart/updateCart";
  // static String postBooking = "${baseUrl}booking/create";
  // static String getBooking = "${baseUrl}booking/myBookings";

  // static String vendorLogin = "${baseUrl}hotel/login";
  // static String vendorFoodItems = "${baseUrl}food/getFood";
  // static String vendorHideFood = "${baseUrl}food/hideFood";
  // static String vendorBookings = "${baseUrl}booking/get";
  // static String vendorUpdateBooking = "${baseUrl}booking/accept";
  // static String vendorAcceptedOrder = "${baseUrl}booking/vendorBookings";
  // static String orderCompleted = "${baseUrl}booking/orderComplete";
  // static String timeChange = "${baseUrl}hotel/timeChange";

  // // Hash Images
  // static String latitude = "latitude";
  // static String longitude = "longitude";
}
