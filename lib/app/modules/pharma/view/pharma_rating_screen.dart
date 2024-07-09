import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:olympic/app/core/app_router.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/pharma/view%20model/pharma_procider.dart';
import 'package:olympic/app/modules/pharma/view/order_details_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import 'pharma_rating_description_screen.dart';

class PharmacyRatingScreen extends StatefulWidget {
  const PharmacyRatingScreen({super.key});

  @override
  State<PharmacyRatingScreen> createState() => _PharmacyRatingScreenState();
}

class _PharmacyRatingScreenState extends State<PharmacyRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonAppBarScaffold(
      isCenterTitle: true,
      text: "Rate Your Order",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<PharmaProvider>(
          builder: (context, provider, child) => Column(
            children: [
              SizeBoxH(Responsive.height * 8),
              Image.asset(
                AppImages.pharmaRateScreenImage,
                height: Responsive.height * 22,
              ),
              SizeBoxH(Responsive.height * 4),
              const commonTextWidget(
                text: 'What could’ve been better?',
                color: AppConstants.appPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              SizeBoxH(Responsive.height * 2),
              RatingBar.builder(
                initialRating: 0.5,
                minRating: 0.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                unratedColor: const Color(0xffE5E5E5),
                updateOnDrag: true,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppConstants.appPrimaryColor,
                ),
                onRatingUpdate: (rating) {
                  provider.ratingLengthFun(rating);
                },
              ),
              SizeBoxH(Responsive.height * 2),
              commonTextWidget(
                text: (provider.ratinglenght <= 2)
                    ? 'Poor'
                    : ((provider.ratinglenght > 2) &&
                            (provider.ratinglenght < 4))
                        ? "Better"
                        : "Very Good",
                color: AppConstants.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              SizeBoxH(Responsive.height * 2),
              Wrap(
                direction: Axis.horizontal,
                spacing: 8.0,
                runSpacing: 10.0,
                children: provider.reviewsBad.map((item) {
                  final isSelected = provider.selectedOptions.contains(item);
                  return OutlinedButton(
                    onPressed: () {
                      provider.toggleOption(item);
                    },
                    style: ButtonStyle(
                      side: const MaterialStatePropertyAll(
                        BorderSide(
                          color: AppConstants.white,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          if (states.contains(MaterialState.pressed) ||
                              isSelected) {
                            return AppConstants
                                .appPrimaryColor; // Change background color when pressed or selected
                          } else {
                            return Colors
                                .transparent; // Default background color
                          }
                        },
                      ),
                    ),
                    child: Text(
                      (item),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isSelected ? Colors.black : AppConstants.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizeBoxH(48),
              CommonInkwell(
                onTap: () {
                  Routes.push(
                      screen: const PharmacyRatingDescriptionWritingScreen());
                },
                child: const commonTextWidget(
                  text: 'any more notes?',
                  color: AppConstants.appPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizeBoxH(23),
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
      ),
    );
  }
}
