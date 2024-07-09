// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:olympic/app/core/string_const.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_router.dart';
import '../../../core/server_client_services.dart';
import '../../../utils/app_images.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
import '../../facility rental/view/facility_rental_home.dart';
import '../model/completed_model.dart';
import '../model/faq_model.dart';
import '../model/subscriptionplan_model.dart';
import '../model/training_video_model.dart';
import '../model/up_coming_model.dart';
import '../model/user_homedata_and_offer_data_model.dart';
import '../view/my_bookings_screen.dart';

class HomeProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List<String> images = [
    'assets/images/offerCards.jpg',
    'assets/images/offerCards.jpg',
    'assets/images/offerCards.jpg'
  ];
  String convertUtcToLocalTime(String utcTime) {
    print(utcTime);
    final utcFormat = DateFormat('HH:mm');
    DateTime utcDateTime = utcFormat.parseUtc(utcTime);
    utcDateTime = utcDateTime.toLocal();
    final localFormat = DateFormat('hh:mm a');
    return localFormat.format(utcDateTime);
  }

//* QR CODE using attendense- start*/
  String qrResult = '';
  Future<void> fetchQrCodeData(BuildContext context) async {
    PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      // Camera permission granted
      //** For Android  */
      String? barcodeScanRes = await scanner.scan();
      print("barcodeScanRes $barcodeScanRes");
      qrResult = barcodeScanRes ?? '';

      //** For Ios  */
      // var options = const ScanOptions(
      //     android: AndroidOptions(useAutoFocus: true), useCamera: -1
      //     // set the options
      //     );

      // var result = await BarcodeScanner.scan(options: options);
      // qrResult = result.rowContent;
      notifyListeners();
    } else if (status.isDenied) {
      // Camera permission denied
      Routes.back();
    } else if (status.isPermanentlyDenied) {
      // Camera permission permanently denied, open settings to grant permission
      openAppSettings();
    }

    if (qrResult.isNotEmpty && qrResult != '') {
      await qrUsingAttendensFn(context);
    } else {
      // ignore: use_build_context_synchronously
      toast(context,
          title: "Try again", duration: 3, backgroundColor: AppConstants.red);
    }
  }

  Future<void> qrUsingAttendensFn(BuildContext context) async {
    try {
      var params = {
        "date": DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
        "qrId": qrResult,
      };
      List response =
          await ServerClient.post(StringConst.qrUsingAttendens, data: params);

      if (response.first >= 200 && response.first < 300) {
        // ignore: use_build_context_synchronously
        toast(context,
            title: response.last["message"],
            duration: 3,
            backgroundColor: AppConstants.appPrimaryColor);
      } else if (response.first == 400) {
        // ignore: use_build_context_synchronously
        toast(context,
            title: response.last,
            duration: 4,
            backgroundColor: AppConstants.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    }
  }

//* QR CODE using attendense- end*/

  //TRAINING VIDEO

  List<String> trainingVideoBgImage = [
    "assets/images/trainigVideo1.png",
    "assets/images/trainig video2.png",
    "assets/images/trainig video3.png",
    "assets/images/trainig video4.png"
  ];
  List<String> trainingVideoTitles = [
    "Kicking Practice",
    "Kicking Practice",
    "Kicking Practice",
    "Kicking Practice"
  ];

  //SUBSCRIPTION PLAN

  int _selectedHeadingIndex = 0;

  // List<SubscriptionPlan> annualPlans = [
  //   SubscriptionPlan(name: 'Annual', price: 5.99),
  //   SubscriptionPlan(name: 'Annual', price: 7.99),
  // ];

  // List<SubscriptionPlan> monthlyPlans = [
  //   SubscriptionPlan(name: 'Monthly', price: 19.99),
  //   SubscriptionPlan(name: 'Monthly', price: 24.99),
  // ];

  // List<SubscriptionPlan> otherPlans = [
  //   SubscriptionPlan(name: 'Other', price: 99.99),
  // ];

  int get selectedHeadingIndex => _selectedHeadingIndex;

  set selectedHeadingIndex(int index) {
    _selectedHeadingIndex = index;
    notifyListeners();
  }

  // String? getPlanName(PlanData plan) {
  //   if (_selectedHeadingIndex == 2) {
  //     // Index for "Others"
  //     return plan.planName; // Return only the name without appending "classes"
  //   } else {
  //     return "${plan.planName} classes"; // Append "classes" for other headings
  //   }
  // }

  //SUBSCRIPTION PLAN END

  //FAQ START

  final List<FAQ> _faqs = [
    // Add your FAQ items here
    FAQ(
        question: 'What makes you different to other programs?',
        answer: 'Answer here...'),

    FAQ(
        question:
            'My child already has a belt with another school, will we have to start again?',
        answer: 'Answer here...'),
    FAQ(
        question: 'Can we pause our monthly membership?',
        answer: 'Answer here...'),
    FAQ(question: 'What is the grading process?', answer: 'Answer here...'),
    FAQ(
        question:
            'My child has been training for a while at a different school but has had no chance to compete, are competitions available for your students?',
        answer: 'Answer here...'),
  ];

  List<FAQ> get faqs => _faqs;

  void toggleExpansion(int index) {
    // for (int i = 0; i < _faqs.length; i++) {
    //   if (i != index) {
    //     _faqs[i].isExpanded = false;
    //   }
    // }
    _faqs[index].isExpanded = !_faqs[index].isExpanded;
    notifyListeners();
  }

  //FAQ END

  // MY BOOKINGS STARTS

  bool _showUpcomingList = true;

  bool get showUpcomingList => _showUpcomingList;

  void setShowUpcomingList(bool value) {
    _showUpcomingList = value;
    notifyListeners();
  }

  // MY BOOKINGS ENDS

  // FEEDBACK START
  String? selectedFeedback = '';

  TextEditingController feedbackController = TextEditingController();

  int? selectedFeedbackIndex;
  bool isContainerSelected = false;
  void selectFeedbackIndex(int? index, String title) {
    selectedFeedbackIndex = index;
    selectedFeedback = title;
    notifyListeners();
  }

  Future feedbackUpdate({
    required BuildContext context,
    required bool isFromWriteFeedback,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      Map<String, dynamic> data = {
        "content": [
          selectedFeedback,
          feedbackController.text,
        ]
      };

      if (isFromWriteFeedback == false) {
        List response = await ServerClient.post(
          StringConst.postFeedback,
          data: data,
          post: true,
        );
        if (response.first >= 200 && response.first < 300) {
          Routes.back();
          Routes.back();
          selectedFeedback = '';
          selectFeedbackIndex(null, '');
          toast(
            context,
            title: response.last["message"],
          );
        }
      } else if (isFromWriteFeedback == true &&
          feedbackController.text.isEmpty) {
        toast(
          context,
          title: "Type Something...",
          backgroundColor: Colors.red,
        );
      } else if (isFromWriteFeedback == true &&
          feedbackController.text.isNotEmpty) {
        List response = await ServerClient.post(
          StringConst.postFeedback,
          data: data,
          post: true,
        );
        if (response.first >= 200 && response.first < 300) {
          Routes.back();
          Routes.back();
          Routes.back();
          selectedFeedback = '';
          selectFeedbackIndex(null, '');
          feedbackController.clear();
          toast(
            context,
            title: response.last["message"],
          );
        }
      }
    } finally {
      LoadingOverlay.of(context).hide();
    }
  }

  // FEEDBACK END

  //VIDEOPLAYER START
  late VideoPlayerController videoPlayerController;
  Uri videoUri = Uri.parse(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
  bool isLoading = true;
  bool isVideoPlaying = false;

  void initializeVideoPlayer(String url) {
    isLoading = true;

    videoPlayerController = VideoPlayerController.network(url.toString())
      ..initialize().then((_) {
        isLoading = false;
        notifyListeners();
      });
  }

  void toggleVideoPlayback() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      isVideoPlaying = false;
    } else {
      videoPlayerController.play();
      isVideoPlaying = true;
    }
    notifyListeners();
  }

  //VIDEOPLAYER END

  //PROFILE PICTURE START
  File? thumbnailImage;
  Future changeProfilePhoto(bool isGallery, BuildContext context) async {
    // log("object");
    try {
      final image = await ImagePicker().pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera,
      );

      if (image == null) return;
      final imageTemporary = File(image.path);
      thumbnailImage = imageTemporary;

      if (thumbnailImage != null) {
        Routes.back();
        // uploadProfileImageToAws();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  //PROFILE PIC END

//* First Letter Capital  fun/
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text; // Check if the string is empty

    // Capitalize the first letter and concatenate with the rest of the string
    return text[0].toUpperCase() + text.substring(1);
  }

//* Get Home Datas (User data , and carosel) - start*/
  GetHomeUserAndCarouselStatus getHomeUserAndCarouselStatus =
      GetHomeUserAndCarouselStatus.initial;

  Future<UserHomeDataAndOfferDataModel> fetchUserDataAndCarouselData() async {
    try {
      getHomeUserAndCarouselStatus = GetHomeUserAndCarouselStatus.loading;
      List response = await ServerClient.get(
        StringConst.getHomeData,
      );
      if (response.first >= 200 && response.first < 300) {
        UserHomeDataAndOfferDataModel userHomeDataAndOfferDataModel =
            UserHomeDataAndOfferDataModel.fromJson(response.last);

        getHomeUserAndCarouselStatus = GetHomeUserAndCarouselStatus.loaded;

        notifyListeners();
        return userHomeDataAndOfferDataModel;
      } else {
        getHomeUserAndCarouselStatus = GetHomeUserAndCarouselStatus.error;
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getHomeUserAndCarouselStatus = GetHomeUserAndCarouselStatus.error;
      throw Exception('Failed to fetch posts');
    }
  }

  int classLeftCount = 0;
  Stream<UserHomeDataAndOfferDataModel> getUserDataAndCaroselData() async* {
    while (true) {
      try {
        final data = await fetchUserDataAndCarouselData();
        classLeftCount = data.classLeft ?? 0;
        yield data;
      } catch (e) {
        yield UserHomeDataAndOfferDataModel();
      }
      await Future.delayed(const Duration(milliseconds: 800));
    }
  }

//* Get Home Datas (User data , and carosel) - end*/

//* Get Training videos  - start  */

  GetTrainingVideosStatus getTrainingVideosStatus =
      GetTrainingVideosStatus.initial;
  TrainingVideosModel? trainingVideosModel;

  Future<void> getTrainingVideosFn() async {
    try {
      getTrainingVideosStatus = GetTrainingVideosStatus.loading;
      List response = await ServerClient.get(
        StringConst.getTrainingVideos,
      );

      if (response.first >= 200 && response.first < 300) {
        trainingVideosModel = TrainingVideosModel.fromJson(response.last);
        getTrainingVideosStatus = GetTrainingVideosStatus.loaded;
        notifyListeners();
      } else {
        getTrainingVideosStatus = GetTrainingVideosStatus.error;
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getTrainingVideosStatus = GetTrainingVideosStatus.error;
      throw Exception('Failed to fetch posts');
    }
    notifyListeners();
  }

  //training video player (Youtube player)

  // String videoToPlay = '';
  // late YoutubePlayerController youtubeControllerMain;

  // initializeYoutubeController(String url) {
  //   youtubeControllerMain = YoutubePlayerController(
  //     initialVideoId: url,
  //     flags: const YoutubePlayerFlags(
  //       autoPlay: true,
  //       mute: false,
  //     ),
  //   );
  // }

  // changeVideo(
  //   String videoId,
  // ) {
  //   // titleToBe.value = title;
  //   // descriptionToBe.value = description;

  //   videoToPlay = videoId;
  //   youtubeControllerMain.load(videoToPlay);
  //   youtubeControllerMain.play();
  //   // youtubeControllerMain.cue(videoToPlay.value);
  //   notifyListeners();
  //   // youtubeControllerMain.dispose();
  //   // initializeYoutubeController();
  // }

//* Get Training videos  - end  */

  @override
  void dispose() {
    // controller?.dispose();
    videoPlayerController.dispose();
    // youtubeControllerMain.dispose();

    super.dispose();
  }

  //APi INTEGRATION

  //GET ALL PLANS
  List<PlanData> annualPlans = <PlanData>[];
  // SubscritptionPlanModel subscritptionPlanModel = SubscritptionPlanModel();
  AllPlanStaus allPlansStatus = AllPlanStaus.initial;
  Future allPlansFn({required String plan, required int index}) async {
    try {
      allPlansStatus = AllPlanStaus.loading;
      List response = await ServerClient.get(
        ('${StringConst.getAllPlansUrl}?planType=$plan'),
      );
      if (response.first >= 200 && response.first < 300) {
        final data = subscritptionPlanModelFromJson(jsonEncode(response.last));
        annualPlans.clear();
        if (index == 0) {
          annualPlans = data.planDatas!
              .where((plan) => plan.planType == 'Annual')
              .toList();
        } else if (index == 1) {
          annualPlans = data.planDatas!
              .where((plan) => plan.planType == 'Monthly')
              .toList();
        } else {
          annualPlans = data.planDatas!
              .where((plan) => plan.planType == 'One Time Purchase')
              .toList();
        }

        allPlansStatus = AllPlanStaus.loaded;
        notifyListeners();
      } else {
        allPlansStatus = AllPlanStaus.error;
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      allPlansStatus = AllPlanStaus.error;
      throw Exception('Failed to fetch posts');
    }
  }

  // GET MY BOOKINGCOMPLETED
  List<BookingDetails> bookingDetailModel = <BookingDetails>[];
  MyBookingCompletedStatus booingCompletedStatus =
      MyBookingCompletedStatus.initial;
  Future myBookingCompletedFn() async {
    try {
      booingCompletedStatus = MyBookingCompletedStatus.loading;
      List response = await ServerClient.get(StringConst.myBookingCompletedUrl);
      if (response.first >= 200 && response.first < 300) {
        final data = CompletedBookingModel.fromJson(response.last);
        bookingDetailModel.clear();
        bookingDetailModel.addAll(data.bookingDetails ?? []);
        booingCompletedStatus = MyBookingCompletedStatus.loaded;
        notifyListeners();
        return bookingDetailModel;
      } else {
        booingCompletedStatus = MyBookingCompletedStatus.error;
        notifyListeners();
      }
    } catch (e) {}
  }

  List<BookingDetail> upcomingbookingDetailModel = <BookingDetail>[];
  MyUpcomingBookingCompletedStatus upcomingBooingCompletedStatus =
      MyUpcomingBookingCompletedStatus.initial;
  Future myUpcomingBookingCompletedFn() async {
    try {
      upcomingBooingCompletedStatus = MyUpcomingBookingCompletedStatus.loading;
      List response = await ServerClient.get(StringConst.upComingbookingUrtl);

      if (response.first >= 200 && response.first < 300) {
        final data = UpcomingBookingModel.fromJson(response.last);
        upcomingbookingDetailModel.clear();
        upcomingbookingDetailModel.addAll(data.bookingDetails ?? []);

        upcomingBooingCompletedStatus = MyUpcomingBookingCompletedStatus.loaded;
        notifyListeners();
        return upcomingbookingDetailModel;
      } else {
        upcomingBooingCompletedStatus = MyUpcomingBookingCompletedStatus.error;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future bookingCancelFnc(
      {required String classsId,
      required String sloteId,
      required String bookingId,
      required index,
      required BuildContext context}) async {
    try {
      List response = await ServerClient.post(StringConst.bookingCancelUrtl,
          data: {
            "classId": classsId,
            "sloteId": sloteId,
            "bookingId": bookingId
          },
          post: true);

      if (response.first >= 200 && response.first < 300) {
        upcomingbookingDetailModel.removeAt(index);
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
                      text: "Class Cancelation   completed successfully",
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
      } else {
        print('server error');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
    }
  }

  //Share  a a friend

  void shareApp() {
    Share.share(
      "App link paste here",
      subject: "any subject",
    );
  }

  //launch url

  Future<void> launchUrl(String url) async {
    final SocialMediaUrl = url;

    if (await canLaunch(SocialMediaUrl)) {
      await launch(SocialMediaUrl);
    }
  }
}
