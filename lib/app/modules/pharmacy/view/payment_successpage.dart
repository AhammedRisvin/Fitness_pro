import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/utils/app_images.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class PaymentSuccesScreen extends StatelessWidget {
  const PaymentSuccesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            commonTextWidget(
              color: AppConstants.appPrimaryColor,
              text: 'Skip',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ],
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const commonTextWidget(
              color: AppConstants.appPrimaryColor,
              text: 'Order succes',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            SizeBoxH(Responsive.height * 2),
            CircleAvatar(
              radius: 50,
              backgroundColor: AppConstants.white,
              child: Image.asset(AppImages.succesbg),
            ),
            SizeBoxH(Responsive.height * 5),
            const commonTextWidget(
              color: AppConstants.white,
              text: 'Thank you!  \nAhmed, We have received your order ',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            SizeBoxH(Responsive.height * 5),
            const commonTextWidget(
              color: AppConstants.white,
              text:
                  'we might contact you for tracking and\n confirming your order ',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizeBoxH(Responsive.height * 5),
            CommonButton(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  // Routes.push(screen: const FavoritesScreen());
                },
                text: 'Add to cart',
                width: Responsive.width * 100,
                height: Responsive.height * 6),
            SizeBoxH(Responsive.height * 3),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonTextWidget(
                  color: AppConstants.white,
                  text: 'Continue shopping',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                Icon(
                  Icons.trending_flat,
                  color: AppConstants.appPrimaryColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
