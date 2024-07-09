import 'package:flutter/material.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../view/new_address.dart';

class SavaedAddressWidgets extends StatelessWidget {
  const SavaedAddressWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppConstants.searchColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.radio_button_on,
                        color: AppConstants.appPrimaryColor,
                      ),
                      SizeBoxV(Responsive.width * 2),
                      const commonTextWidget(
                        color: AppConstants.white,
                        text: 'House (Al Muraqqabat)',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: AppConstants.white, width: 1)),
                    padding: const EdgeInsets.all(3),
                    child: const commonTextWidget(
                      color: AppConstants.white,
                      text: 'Home',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.edit,
                    color: AppConstants.appPrimaryColor,
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 2),
              const commonTextWidget(
                color: AppConstants.white,
                text: '18 Al Murwah Street, Ajman',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              SizeBoxH(Responsive.height * 0.8),
              const commonTextWidget(
                color: AppConstants.white,
                text: 'Al rigga, Green corner , 703, 7',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              SizeBoxH(Responsive.height * 0.8),
              const commonTextWidget(
                color: AppConstants.white,
                text: 'Mobile number: +971 502407809',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SavedAddressButton extends StatelessWidget {
  const SavedAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: () {
        Routes.push(screen: const NewAddressScreen());
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 15),

        width: Responsive.width * 100,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: AppConstants.black,
            border: Border.all(color: AppConstants.white)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const commonTextWidget(
              color: AppConstants.white,
              text: 'Add New Address',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            SizeBoxV(Responsive.width * 3),
            const Icon(
              Icons.add,
              color: AppConstants.white,
            )
          ],
        ),
      ),
    );
  }
}
