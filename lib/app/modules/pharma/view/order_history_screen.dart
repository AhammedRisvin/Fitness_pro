import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:olympic/app/core/app_router.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/pharma/view/order_details_screen.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';

class PharmacyOrderHistoryScreen extends StatefulWidget {
  const PharmacyOrderHistoryScreen({super.key});

  @override
  State<PharmacyOrderHistoryScreen> createState() =>
      _PharmacyOrderHistoryScreenState();
}

class _PharmacyOrderHistoryScreenState
    extends State<PharmacyOrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonAppBarScaffold(
      text: "Order History ",
      isCenterTitle: true,
      body: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CommonInkwell(
            onTap: () => Routes.push(screen: const OrderDetailsScreen()),
            child: Container(
              width: Responsive.width * 100,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppConstants.teleContainerBg,
              ),
              child: Row(
                children: [
                  commonNetworkImage(
                    url:
                        "https://img.lovepik.com/element/40115/2654.png_860.png",
                    height: Responsive.height * 12,
                    width: Responsive.width * 24,
                    radius: 15,
                  ),
                  const SizeBoxV(10),
                  Expanded(
                    child: SizedBox(
                      height: Responsive.height * 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizeBoxH(25),
                          const commonTextWidget(
                            color: AppConstants.white,
                            text: "Amlodipine tablets",
                            fontSize: 18,
                            letterSpacing: -0.1,
                          ),
                          const SizeBoxH(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Center(
                                child: commonTextWidget(
                                  color: AppConstants.white,
                                  text: "30 july 2023 - 13:15",
                                  fontSize: 16,
                                  letterSpacing: -0.8,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: Responsive.height * 1),
                                child: const commonTextWidget(
                                  color: AppConstants.appPrimaryColor,
                                  text: "AED 57.75",
                                  fontSize: 14,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ],
                          ),
                          const SizeBoxH(10),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.pharmaRatingStar,
                              ),
                              const SizeBoxV(5),
                              const commonTextWidget(
                                color: AppConstants.appPrimaryColor,
                                text: "4.0 Rated",
                                fontSize: 14,
                                letterSpacing: -0.4,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizeBoxH(1),
        itemCount: 15,
      ),
    );
  }
}
