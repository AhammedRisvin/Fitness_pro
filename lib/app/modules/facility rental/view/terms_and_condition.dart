import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../view model/facility_rental_provider.dart';

class FacilityRentalTermsAndConditionScreen extends StatefulWidget {
  const FacilityRentalTermsAndConditionScreen({
    super.key,
  });

  @override
  State<FacilityRentalTermsAndConditionScreen> createState() =>
      _FacilityRentalTermsAndConditionScreenState();
}

class _FacilityRentalTermsAndConditionScreenState
    extends State<FacilityRentalTermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    FacilityRentalProvider facilityRentalProvider =
        context.read<FacilityRentalProvider>();
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "Terms and conditions",
          fontSize: 18,
          // fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
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
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const commonTextWidget(
              color: AppConstants.white,
              text: "Review Terms & Conditions",
              fontWeight: FontWeight.w500,
            ),
            SizeBoxH(Responsive.height * 2),
            const commonTextWidget(
              color: AppConstants.white,
              text:
                  "Your privacy is important to us. It is Brainstorming's policy to respect your privacy regarding any information we may collect from you across our App, and other sites we own and operate.",
              fontWeight: FontWeight.w500,
              align: TextAlign.center,
              fontSize: 16,
            ),
            SizeBoxH(Responsive.height * 2),
            const commonTextWidget(
              color: AppConstants.white,
              text:
                  "We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            SizeBoxH(Responsive.height * 2),
            const commonTextWidget(
              color: AppConstants.white,
              text:
                  "We only retain collected information for as long as necessary to provide you with your requested service. ",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            SizeBoxH(Responsive.height * 2),
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.yellowPen,
                    color: AppConstants.white,
                    height: 16,
                  ),
                  SizeBoxV(Responsive.width * 3),
                  const commonTextWidget(
                    color: AppConstants.white,
                    text: "Sign here",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )
                ],
              ),
            ),
            SizeBoxH(Responsive.height * 1),
            Expanded(
              child: Container(
                width: Responsive.width * 80,
                height: Responsive.height * 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      20), // Adjust border radius as needed
                  color: AppConstants.drawerBgColor,
                ),
                child: Stack(
                  children: [
                    Signature(
                      controller: facilityRentalProvider.signController,
                      backgroundColor: Colors.transparent,
                    ),
                    Positioned(
                      top: 8,
                      right: 15,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              AppImages.retryIcon,
                              height: 15,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              facilityRentalProvider.signController.clear();
                            },
                          ),
                          const commonTextWidget(
                            color: AppConstants.white,
                            text: "Retry",
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizeBoxH(Responsive.height * 2),
            CommonButton(
              onTap: () {
                if (facilityRentalProvider.signController.isNotEmpty) {
                  facilityRentalProvider.stripeFn(
                      singleSlotId: facilityRentalProvider.singleSlot?.sloteId,
                      bookingId: facilityRentalProvider.singleSlot?.bookingId,
                      context: context);
                } else {
                  toast(context,
                      title: "please sign in the sign pad",
                      backgroundColor: AppConstants.red);
                }
              },
              text: "I've agree with this",
              width: Responsive.width * 90,
              height: Responsive.height * 6.5,
            )
          ],
        ),
      ),
    );
  }
}
