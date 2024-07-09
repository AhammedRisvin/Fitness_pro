import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/home/view%20model/home_provider.dart';
import 'package:olympic/app/modules/home/view/feedback_typing_screen.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../widget/feedback_container.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  @override
  Widget build(BuildContext context) {
    final feedbackContainerState = Provider.of<HomeProvider>(context);

    final isFeedbackSelected =
        feedbackContainerState.selectedFeedbackIndex != null;

    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "Feedback",
          fontSize: 18,
        ),
        leading: IconButton(
          onPressed: () {
            feedbackContainerState.selectFeedbackIndex(null, '');
            Routes.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppConstants.white,
            size: 20,
          ),
        ),
      ),
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const commonTextWidget(
              color: AppConstants.white,
              text: "Your Experience with Olympic\nCombat ",
              align: TextAlign.start,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            const commonTextWidget(
              color: AppConstants.subTextGrey,
              text:
                  "Your feedback is vital in shaping the future of Olympic Combat! Sharing your experience helps us tailor our offerings to better serve your training needs and aspirations. Whether you're a seasoned competitor or a passionate beginner, your voice matters.",
              align: TextAlign.start,
              fontSize: 16,
            ),
            const FeedBackContainer(
              index: 0,
              title: "Thrilled with Olympic Combat!",
            ),
            const FeedBackContainer(
              index: 1,
              title: "Satisfied with the app overall",
            ),
            const FeedBackContainer(
              index: 2,
              title: "Neutral - could be better, could be worse",
            ),
            const FeedBackContainer(
              index: 3,
              title: "Not impressed with Olympic Combat",
            ),
            CommonInkwell(
              onTap: () {
                Routes.push(screen: const FeedbackTypingScreen());
              },
              child: Container(
                height: Responsive.height * 5,
                width: Responsive.width * 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: AppConstants.black,
                  border: Border.all(
                    color: AppConstants.appPrimaryColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      AppImages.yellowPen,
                      height: 20,
                    ),
                    const commonTextWidget(
                      color: AppConstants.white,
                      text: "Write feedback",
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
            ),
            CommonButton(
              onTap: () {
                if (isFeedbackSelected) {
                  feedbackContainerState.feedbackUpdate(
                    context: context,
                    isFromWriteFeedback: false,
                  );
                } else {
                  toast(
                    context,
                    title: "Select any feedback option",
                    backgroundColor: Colors.red,
                  );
                }
              },
              text: "Submit",
              width: Responsive.width * 100,
              height: Responsive.height * 6.5,
              bgColor: isFeedbackSelected
                  ? AppConstants.appPrimaryColor
                  : AppConstants.darkYellow,
              textColor: isFeedbackSelected
                  ? AppConstants.black
                  : AppConstants.subTextGrey,
            ),
            SizeBoxH(
              Responsive.height * 1,
            ),
          ],
        ),
      ),
    );
  }
}
