import 'package:flutter/material.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../../telemedicine/widgets/payment_method_widget.dart';
import '../widgets/favandcartcard.dart';
import '../widgets/payment_summary_widgets.dart';
import 'payment_successpage.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        centerTitle: true,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "Favorites",
          fontSize: 18,
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizeBoxH(Responsive.height * 2),
                        itemCount: 4,
                        itemBuilder: (context, index) =>
                            const FavAndCartWidgets(
                              isCheckOut: true,
                            )),
                    SizeBoxH(Responsive.height * 2),
                    const PaymentSummaryWidgets(),
                    SizeBoxH(Responsive.height * 2),
                    const commonTextWidget(
                      color: AppConstants.white,
                      text: 'Payment method',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    SizeBoxH(Responsive.height * 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          PaymentMethodWidget(
                            img: AppImages.profilePic,
                            paymentName: 'Stripe',
                          ),
                          SizeBoxH(Responsive.height * 1),
                          PaymentMethodWidget(
                            img: AppImages.facebook,
                            paymentName: 'Paypal',
                          ),
                        ],
                      ),
                    ),
                    SizeBoxH(Responsive.height * 4),
                    CommonButton(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Routes.push(screen: const PaymentSuccesScreen());
                        },
                        text: 'Proceed to Pay (4 items )',
                        width: Responsive.width * 100,
                        height: Responsive.height * 6),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
