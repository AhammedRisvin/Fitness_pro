import 'package:flutter/material.dart';
import 'package:olympic/app/modules/pharmacy/view/checkout.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../widgets/cuppenWidgets.dart';
import '../widgets/favandcartcard.dart';
import '../widgets/payment_summary_widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        centerTitle: true,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "Cart",
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      SizeBoxH(Responsive.height * 2),
                  itemCount: 4,
                  itemBuilder: (context, index) => const FavAndCartWidgets(
                        isCart: true,
                      )),
              SizeBoxH(Responsive.height * 2),
              const CuppenWidgets(),
              SizeBoxH(Responsive.height * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                    checkColor: AppConstants.white,
                    activeColor: const Color.fromARGB(255, 76, 56, 56),
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    side: const BorderSide(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const commonTextWidget(
                            color: AppConstants.white,
                            text: 'Use the coins',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          SizeBoxV(Responsive.width * 20),
                          Container(
                            decoration: BoxDecoration(
                                color: AppConstants.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Row(
                              children: [
                                Image.asset(AppImages.wallet),
                                SizeBoxV(Responsive.width * 1),
                                const commonTextWidget(
                                  color: AppConstants.black,
                                  text: '20 coins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const commonTextWidget(
                        color: AppConstants.white,
                        text:
                            'You can only spend 30% of your coins\n on each order.',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        overFlow: TextOverflow.clip,
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 2),
              const PaymentSummaryWidgets(),
              SizeBoxH(Responsive.height * 2),
              CommonButton(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Routes.push(screen: const ChackOutScreen());
                  },
                  text: 'Checkout',
                  width: Responsive.width * 100,
                  height: Responsive.height * 6),
            ],
          ),
        ),
      ),
    );
  }
}
