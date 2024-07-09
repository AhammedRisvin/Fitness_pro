import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';

class TeleAddRateScreen extends StatelessWidget {
  const TeleAddRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        leading: IconButton(
          onPressed: () {
            Routes.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppConstants.white,
            size: 20,
          ),
        ),
      ),
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizeBoxH(Responsive.height * 15),
            Image.asset(
              AppImages.teleRateImage,
              height: 202,
              width: Responsive.width * 45,
            ),
            SizeBoxH(Responsive.height * 4),
            const commonTextWidget(
              text: "Booking detials",
              color: AppConstants.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            SizeBoxH(Responsive.height * 3),
            RatingBar.builder(
              itemSize: 25,
              initialRating: 3,
              minRating: 0,
              unratedColor: AppConstants.teleContainerBg,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            SizeBoxH(Responsive.height * 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonButton(
                    onTap: () {},
                    text: 'Not now',
                    width: Responsive.width * 30,
                    size: 14,
                    textColor: AppConstants.white,
                    bgColor: AppConstants.black,
                    borderColor: AppConstants.white.withOpacity(.7),
                    height: 35),
                const SizeBoxV(10),
                CommonButton(
                    onTap: () {},
                    text: 'Submit',
                    width: Responsive.width * 30,
                    size: 14,
                    height: 35)
              ],
            )
          ],
        ),
      ),
    );
  }
}
