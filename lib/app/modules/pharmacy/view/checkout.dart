import 'package:flutter/material.dart';
import 'package:olympic/app/modules/pharmacy/view/saved_address.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../widgets/cuppenWidgets.dart';
import '../widgets/favandcartcard.dart';
import '../widgets/payment_summary_widgets.dart';
import '../widgets/saved_address_widgets.dart';
import 'payment.dart';

class ChackOutScreen extends StatelessWidget {
  const ChackOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        centerTitle: true,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: 'Checkout',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      SizeBoxH(Responsive.height * 2),
                  itemCount: 4,
                  itemBuilder: (context, index) => const FavAndCartWidgets(
                        isCheckOut: true,
                      )),
              SizeBoxH(Responsive.height * 2),
              const commonTextWidget(
                color: AppConstants.white,
                text: 'Saved Address',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              SizeBoxH(Responsive.height * 2),
              CommonInkwell(
                  onTap: () {
                    Routes.push(screen: const SavedAddressScreen());
                  },
                  child: const SavaedAddressWidgets()),
              SizeBoxH(Responsive.height * 2),
              const SavedAddressButton(),
              SizeBoxH(Responsive.height * 2),
              const CuppenWidgets(),
              SizeBoxH(Responsive.height * 2),
              const PaymentSummaryWidgets(),
              SizeBoxH(Responsive.height * 2),
              CommonButton(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Routes.push(screen: const PaymentScreen());
                  },
                  text: 'Proceed to Pay (4 items )',
                  width: Responsive.width * 100,
                  height: Responsive.height * 6),
            ],
          ),
        ),
      ),
    );
  }
}
