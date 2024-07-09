import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class PaymentSummaryWidgets extends StatelessWidget {
  const PaymentSummaryWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const commonTextWidget(
          color: AppConstants.white,
          text: 'Payment summary',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        SizeBoxH(Responsive.height * 2),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonTextWidget(
              color: AppConstants.white,
              text: 'Payment summary',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            commonTextWidget(
              color: AppConstants.white,
              text: 'AED 9.00',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        SizeBoxH(Responsive.height * 2),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonTextWidget(
              color: AppConstants.white,
              text: 'Payable',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            commonTextWidget(
              color: AppConstants.white,
              text: 'AED 9.00',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        SizeBoxH(Responsive.height * 2),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonTextWidget(
              color: AppConstants.appPrimaryColor,
              text: 'Payment summary',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            commonTextWidget(
              color: AppConstants.appPrimaryColor,
              text: 'AED 9.00',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}
