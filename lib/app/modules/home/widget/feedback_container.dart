import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../view model/home_provider.dart';

class FeedBackContainer extends StatelessWidget {
  final int index;
  final String title;

  const FeedBackContainer({
    Key? key,
    required this.index,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedbackContainerState = Provider.of<HomeProvider>(context);
    final isSelected = feedbackContainerState.selectedFeedbackIndex == index;

    return CommonInkwell(
      onTap: () {
        if (isSelected) {
          feedbackContainerState.selectFeedbackIndex(null, title);
        } else {
          feedbackContainerState.selectFeedbackIndex(index, title);
        }
      },
      child: Container(
        height: Responsive.height * 7,
        width: Responsive.width * 100,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? AppConstants.appPrimaryColor
                : AppConstants.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonTextWidget(
              color: AppConstants.white,
              text: title,
              fontSize: 14,
            ),
            CircleAvatar(
              backgroundColor: isSelected
                  ? AppConstants.transparent
                  : AppConstants.drawerBgColor,
              radius: 10,
              child: CircleAvatar(
                backgroundColor: isSelected
                    ? AppConstants.appPrimaryColor
                    : AppConstants.drawerBgColor,
                radius: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
