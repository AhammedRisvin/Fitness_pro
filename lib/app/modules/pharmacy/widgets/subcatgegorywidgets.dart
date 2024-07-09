import 'package:flutter/material.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../view/view_model/pharmacy_provider.dart';

class SubCategoryWidget extends StatelessWidget {
  final int? index;
  final String? text;
  const SubCategoryWidget({this.index, this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.read<PharmacyProvider>().cusrrentIndex == index
            ? AppConstants.appPrimaryColor
            : Colors.transparent,
        border: Border.all(
          color: context.read<PharmacyProvider>().cusrrentIndex == index
              ? AppConstants.appPrimaryColor
              : AppConstants.white,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.center,
      child: commonTextWidget(
        color: context.read<PharmacyProvider>().cusrrentIndex == index
            ? AppConstants.black
            : AppConstants.white,
        text: text ?? 'Proteins',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
