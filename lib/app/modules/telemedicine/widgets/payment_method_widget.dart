import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../view_model/tele_medicine_provider.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String img;
  final String paymentName;

  const PaymentMethodWidget({
    required this.img,
    required this.paymentName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<TelemedicineProvider, String>(
      selector: (p0, p1) => p1.selectedpayment,
      builder: (context, value, child) => RadioListTile(
        activeColor: AppConstants.appPrimaryColor,
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: const EdgeInsets.all(0),
        dense: true,
        title: Row(
          children: [
            Image.asset(
              img,
              height: 16,
              width: 16,
            ),
            const SizeBoxV(10),
            Text(
              paymentName,
              style: const TextStyle(
                color: AppConstants.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 0.09,
              ),
            ),
          ],
        ),
        value: paymentName.toLowerCase(),
        groupValue: value,
        onChanged: (value) {
          context
              .read<TelemedicineProvider>()
              .selectPaymentForBooking(value!.toLowerCase());
        },
      ),
    );
  }
}
