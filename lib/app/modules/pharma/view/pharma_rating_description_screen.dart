import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/pharma/view/order_details_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';

class PharmacyRatingDescriptionWritingScreen extends StatelessWidget {
  const PharmacyRatingDescriptionWritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBarScaffold(
      isCenterTitle: true,
      text: "Write Review",
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const commonTextWidget(
              color: AppConstants.white,
              text: " Add any more notes?",
            ),
            const SizeBoxH(20),
            TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: TextEditingController(),
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
                    color: AppConstants.appPrimaryColor,
                    width: 5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: AppConstants.appPrimaryColor,
                  ),
                ),
                fillColor: AppConstants.drawerBgColor,
                filled: true,
                hintText: "How can we improve?",
                hintStyle: const TextStyle(
                  color: AppConstants.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            SizeBoxH(Responsive.height * 10),
            CommonButton(
              width: Responsive.width * 100,
              height: Responsive.height * 6,
              onTap: () {},
              text: 'Submit',
              bgColor: AppConstants.appPrimaryColor,
              radius: 12,
            ),
          ],
        ),
      ),
    );
  }
}
