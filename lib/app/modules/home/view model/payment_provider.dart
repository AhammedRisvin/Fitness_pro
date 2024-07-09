import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../core/server_client_services.dart';
import '../../../core/string_const.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../../../utils/loading_overlay.dart';
import 'home_provider.dart';

class PaymentProvider extends ChangeNotifier {
  String paymentIntentId = '';
  Future stripeFn(
      {required amount, required currency, required planId, context}) async {
    // log('aaaaaaaaaaaaaaaaaaaaaaaa');
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        StringConst.stripeUrl,
        data: {"amount": '1', "currency": 'INR'},
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        log(response.last['clientSecret']);
        paymentIntentId = response.last['clientSecret'];
        // log(paymentIntentId.toString());

        makeStripePayment(planid: planId, context: context);
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      throw Exception('Failed to fetch posts');
    }
  }

  Future<void> makeStripePayment({required planid, context}) async {
    try {
      try {
        log('aaaaaaaaaaaaaaaaaaaaaaaa');
        log(paymentIntentId.toString());
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                // googlePay:
                //     const PaymentSheetGooglePay(merchantCountryCode: "USD"),
                merchantDisplayName: "prospect",
                // customerId: paymentIntentData!["customer"],
                paymentIntentClientSecret: paymentIntentId

                // customerEphemeralKeySecret:
                //     paymentIntentData!["ephemeralkey"]

                ));
        log('bbbbbbbbbbbbbbbbbbbbbbbbbb');
      } catch (e) {
        LoadingOverlay.of(context).hide();
        log("message$e");
      }
      //STEP 3: Display Payment sheet
      try {
        LoadingOverlay.of(context).hide();
        log('cccccccccccccccccccccccc');
        await Stripe.instance.presentPaymentSheet().then((value) async {});
        log(planid);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                height: Responsive.height * 50,
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppConstants.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      AppImages.successImage,
                      height: Responsive.height * 25,
                    ),
                    const commonTextWidget(
                      color: Colors.white,
                      text: 'Your plan\n Subscription is Completed',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    CommonButton(
                      onTap: () {
                        Routes.back();
                        Routes.back();
                        context.read<HomeProvider>().selectedHeadingIndex = 0;
                      },
                      text: "Back",
                      width: Responsive.width * 100,
                      height: Responsive.height * 6.5,
                      bgColor: AppConstants.black,
                      textColor: AppConstants.white,
                      borderColor: AppConstants.white,
                    )
                  ],
                ),
              ),
            );
          },
        );
        await paymentValidationFn(clintId: paymentIntentId, planId: planid);
        log("success");
      } on Exception catch (e) {
        log('message');
        log(e.toString());
        if (e is StripeException) {
          log("error from stripe $e");
        } else {
          log("Unforeseen erro $e");
        }
      } catch (e) {
        log("Exceptio   ---$e");
      }
      // displayPaymentSheet();
    } catch (err) {
      log('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      // hideLoading();
      log(err.toString());
    }
  }

  Future paymentValidationFn({required clintId, required planId}) async {
    // log('aaaaaaaaaaaaaaaaaaaaaaaa');
    try {
      List response = await ServerClient.post(
        StringConst.paymentValidationUrl,
        data: {"clientSecret": clintId, "planId": planId},
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        log('apiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    }
  }
}
