import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:olympic/app/core/app_router.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/pharma/view/pharma_rating_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonAppBarScaffold(
      isCenterTitle: true,
      text: 'Order Details',
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonInkwell(
              onTap: () => Routes.push(screen: const PharmacyRatingScreen()),
              child: Container(
                width: Responsive.width * 100,
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppConstants.transparent,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        commonNetworkImage(
                          url:
                              "https://img.lovepik.com/element/40115/2654.png_860.png",
                          height: Responsive.height * 12,
                          width: Responsive.width * 24,
                          radius: 15,
                        ),
                        const SizeBoxV(12),
                        Expanded(
                          child: SizedBox(
                            height: Responsive.height * 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const commonTextWidget(
                                  color: AppConstants.white,
                                  text: "Amlodipine tablets",
                                  fontSize: 18,
                                  letterSpacing: -0.1,
                                ),
                                const SizeBoxH(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Responsive.width * 18,
                                      height: Responsive.height * 3.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: AppConstants.white),
                                      ),
                                      child: const Center(
                                        child: commonTextWidget(
                                          color: AppConstants.white,
                                          text: "QTY : 1",
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Responsive.height * 1),
                                      child: const commonTextWidget(
                                        color: AppConstants.appPrimaryColor,
                                        text: "AED 57.75",
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizeBoxH(Responsive.height * 6),
                    const RowTextWidget(
                      leftText: "Discountable amount",
                      rightText: "76.98 AED",
                    ),
                    SizeBoxH(Responsive.height * 2),
                    const RowTextWidget(
                      leftText: "Payable",
                      rightText: "76.98 AED",
                    ),
                    SizeBoxH(Responsive.height * 2),
                    const RowTextWidget(
                      leftText: "Total amount",
                      rightText: "76.98 AED",
                      isFromTotalPrice: true,
                    ),
                    SizeBoxH(Responsive.height * 4),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Responsive.height * 10),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              width: Responsive.width * 100,
              // height: Responsive.height * 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppConstants.white),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonTextWidget(
                    color: AppConstants.white,
                    fontSize: 16,
                    text: "Shipping Address",
                    fontWeight: FontWeight.w600,
                  ),
                  SizeBoxH(10),
                  commonTextWidget(
                    align: TextAlign.start,
                    color: AppConstants.white,
                    fontSize: 12,
                    text:
                        "Perum Asper Rd. Mangkubumi, Wonosobo 56733 Jawa Tengah, Indonesia",
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Responsive.height * 6),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 40,
              ),
              width: Responsive.width * 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                // border: Border.all(color: AppConstants.white),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const commonTextWidget(
                    color: AppConstants.white,
                    text: "Order Status",
                    fontSize: 14,
                  ),
                  AnotherStepper(
                    stepperList: [
                      StepperData(
                          title: StepperText(
                            'Pending',
                            textStyle: const TextStyle(
                              color: AppConstants.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          //  subtitle: StepperText("Your order has been placed"),
                          iconWidget: Container(
                            // padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: AppConstants.appPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: const Center(
                                child: Icon(
                              Icons.check_rounded,
                              color: Colors.black,
                              size: 12,
                            )),
                          )),
                      StepperData(
                        title: StepperText(
                          'Order Created ',
                          textStyle: const TextStyle(
                            color: AppConstants.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        // subtitle: StepperText("Your order is being prepared"),
                        iconWidget: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: AppConstants.appPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: const Center(
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.black,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                      StepperData(
                        title: StepperText(
                          'Order Shipped ',
                          textStyle: const TextStyle(
                            color: AppConstants.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        // subtitle: StepperText("Your order is being prepared"),
                        iconWidget: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: AppConstants.appPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: const Center(
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.transparent,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                      StepperData(
                        title: StepperText(
                          "Delivered",
                          textStyle: const TextStyle(
                            color: AppConstants.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        iconWidget: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: AppConstants.appPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: const Center(
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.transparent,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                    stepperDirection: Axis.vertical,
                    iconWidth: 25,
                    iconHeight: 25,
                    activeBarColor: AppConstants.appPrimaryColor,
                    inActiveBarColor: const Color(0xFFD5D7DA),
                    inverted: false,
                    verticalGap: 30,
                    activeIndex: 1,
                    barThickness: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonAppBarScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final String text;
  final bool isCenterTitle;
  final Widget? floatingActionWidet;
  const CommonAppBarScaffold({
    super.key,
    required this.body,
    required this.isCenterTitle,
    required this.text,
    this.bottomNavigationBar,
    this.floatingActionWidet,
  });

  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      backgroundColor: AppConstants.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        leading: IconButton(
          onPressed: () {
            Routes.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppConstants.white,
            size: 18,
          ),
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppConstants.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
        centerTitle: isCenterTitle,
      ),
      body: body,
      floatingActionButton: floatingActionWidet ?? const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomNavigationBar ?? const SizedBox.shrink(),
    );
  }
}

class RowTextWidget extends StatelessWidget {
  final String leftText;
  final String rightText;
  final double fontSize;
  final bool isFromTotalPrice;
  const RowTextWidget({
    super.key,
    required this.leftText,
    required this.rightText,
    this.fontSize = 14,
    this.isFromTotalPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonTextWidget(
          color: AppConstants.white,
          fontSize: fontSize,
          text: leftText,
        ),
        commonTextWidget(
          color: isFromTotalPrice
              ? AppConstants.appPrimaryColor
              : AppConstants.white,
          fontSize: isFromTotalPrice ? 18 : fontSize,
          text: rightText,
          fontWeight: isFromTotalPrice ? FontWeight.w700 : FontWeight.w500,
        ),
      ],
    );
  }
}
