import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/home/view%20model/home_provider.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';

class FeedbackTypingScreen extends StatefulWidget {
  const FeedbackTypingScreen({super.key});

  @override
  State<FeedbackTypingScreen> createState() => _FeedbackTypingScreenState();
}

class _FeedbackTypingScreenState extends State<FeedbackTypingScreen> {
  HomeProvider? homeScreenProvider;
  @override
  void initState() {
    super.initState();
    homeScreenProvider = context.read<HomeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "Write Feedback",
          fontSize: 18,
        ),
        leading: IconButton(
          onPressed: () {
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
        padding: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeBoxH(Responsive.height * 1),
            const commonTextWidget(
              color: AppConstants.white,
              text: "What could we do better?",
              fontSize: 18,
            ),
            SizeBoxH(Responsive.height * 3),
            const commonTextWidget(
              color: AppConstants.subTextGrey,
              text: "How can we make the app even better\nfor you?",
              fontSize: 16,
              align: TextAlign.start,
            ),
            SizeBoxH(Responsive.height * 3),
            Expanded(
              child: TextField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: homeScreenProvider?.feedbackController,
                maxLines: null,
                minLines: 11,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  color: AppConstants.white,
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: AppConstants.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  fillColor: AppConstants.drawerBgColor,
                  filled: true,
                  hintText: "How can we improve?",
                  hintStyle: const TextStyle(
                    color: AppConstants.subTextGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CommonButton(
                onTap: () {
                  homeScreenProvider?.feedbackUpdate(
                    context: context,
                    isFromWriteFeedback: true,
                  );
                },
                text: "Send Feedback",
                width: Responsive.width * 100,
                height: Responsive.height * 6.5,
              ),
            ),
            const SizeBoxH(30)
          ],
        ),
      ),
    );
  }
}
