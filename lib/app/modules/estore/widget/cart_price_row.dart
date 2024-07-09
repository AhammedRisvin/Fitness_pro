import 'package:flutter/material.dart';
import '../../../helpers/common_widget.dart';

import '../../../utils/app_constants.dart';

class CartPriceRowWidget extends StatelessWidget {
  final String title;
  final String price;
  final double titleSize;
  final double priceSize;
  final FontWeight titleWeight;
  final FontWeight priceWeight;
  const CartPriceRowWidget(
      {super.key,
      required this.title,
      required this.price,
      this.priceSize = 18,
      this.titleSize = 18,
      this.priceWeight = FontWeight.normal,
      this.titleWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonTextWidget(
            color: AppConstants.white,
            text: title,
            fontSize: titleSize,
            fontWeight: titleWeight,
          ),
          commonTextWidget(
            color: AppConstants.white,
            text: price,
            fontSize: priceSize,
            fontWeight: priceWeight,
          ),
        ],
      ),
    );
  }
}
