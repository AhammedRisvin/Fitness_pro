import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/home/view%20model/payment_provider.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/enums.dart';
import '../model/subscriptionplan_model.dart';
import '../view model/home_provider.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "Plans",
          fontSize: 18,
          // fontWeight: FontWeight.w600,
        ),
        // centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.read<HomeProvider>().selectedHeadingIndex = 0;

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
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: Responsive.height * 6,
              width: Responsive.width * 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppConstants.drawerBgColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildHeading(context, 'Annual', 0),
                  buildHeading(context, 'Monthly', 1),
                  buildHeading(context, 'Others', 2),
                ],
              ),
            ),
            SizeBoxH(Responsive.height * 2),
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (context, obj, child) {
                  final homeProvider = context.read<HomeProvider>();
                  if (homeProvider.allPlansStatus == AllPlanStaus.loading) {
                    log("is Loading ${homeProvider.allPlansStatus}");
                    return ListView.separated(
                        itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: AppConstants.drawerBgColor,
                              highlightColor: AppConstants.drawerBgColor,
                              period: const Duration(milliseconds: 800),
                              child: Container(
                                height: Responsive.height * 27,
                                width: Responsive.width * 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppConstants.drawerBgColor,
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) =>
                            SizeBoxH(Responsive.height * 3),
                        itemCount: 3);
                  } else {
                    return obj.annualPlans.isEmpty
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              commonTextWidget(
                                color: Colors.grey,
                                text: 'No plans',
                              )
                            ],
                          )
                        : ListView(
                            children: _getPlans(
                              obj.annualPlans,
                              Provider.of<HomeProvider>(context),
                              Provider.of<PaymentProvider>(context),
                              context,
                            ),
                          );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeading(BuildContext context, String text, int index) {
    final provider = Provider.of<HomeProvider>(context);

    final isSelected = provider.selectedHeadingIndex == index;

    return GestureDetector(
      onTap: () {
        provider.selectedHeadingIndex = index;
        if (index == 0) {
          provider.allPlansFn(plan: text, index: 0);
        } else if (index == 1) {
          provider.allPlansFn(plan: text, index: 1);
        } else {
          provider.allPlansFn(plan: 'One Time Purchase', index: 2);
        }
      },
      child: Container(
        height: Responsive.height * 4.5,
        width: Responsive.width * 28,
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.darkYellow : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: commonTextWidget(
            color: isSelected
                ? AppConstants.appPrimaryColor
                : AppConstants.subTextGrey,
            text: text,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  List<Widget> _getPlans(List<PlanData> plans, HomeProvider provider,
      PaymentProvider paymentProvider, context) {
    return plans.map((plan) {
      return Container(
          height: Responsive.height * 27,
          width: Responsive.width * 100,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImages.subscriptionPlanBg),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              commonTextWidget(
                color: AppConstants.white,
                text: plan.planName.toString(),
                letterSpacing: 2.5,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizeBoxH(Responsive.height * 1.5),
              commonTextWidget(
                color: AppConstants.white,
                text: plan.planPrice.toString(),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: provider.selectedHeadingIndex == 2
                          ? 'Purchase'
                          : 'AED /',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.white,
                      ),
                    ),
                    TextSpan(
                      text: provider.selectedHeadingIndex == 0
                          ? 'Year'
                          : provider.selectedHeadingIndex == 1
                              ? 'month'
                              : ' ',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppConstants.subTextGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizeBoxH(Responsive.height * 2),
              Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: AppConstants.white,
                    size: 20,
                  ),
                  SizeBoxV(Responsive.width * 4),
                  commonTextWidget(
                    color: AppConstants.white,
                    text: plan.description.toString(),
                    fontSize: 13,
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 1),
              CommonButton(
                onTap: () {
                  paymentProvider.stripeFn(
                      amount: plan.planPrice,
                      currency: plan.currencyType,
                      planId: plan.id,
                      context: context);
                },
                text: "Book now",
                width: Responsive.width * 100,
                height: Responsive.height * 5.5,
              )
            ],
          ));
    }).toList();
  }
}
//ListTile(
//   title: Text(plan.name),
//   subtitle: Text('AED${plan.price.toStringAsFixed(2)}'),
// ),
