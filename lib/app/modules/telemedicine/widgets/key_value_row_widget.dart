import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';

class KeyValueRowWidget extends StatelessWidget {
  final String keyValue;
  final String value;
  const KeyValueRowWidget({
    super.key,
    required this.keyValue,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonTextWidget(
          text: keyValue,
          color: AppConstants.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        commonTextWidget(
          text: value,
          color: AppConstants.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
