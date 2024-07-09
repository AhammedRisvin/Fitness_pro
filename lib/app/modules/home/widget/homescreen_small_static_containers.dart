import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:olympic/app/helpers/size_box.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class HomeScreenSmallStaticContainer extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() ontap;
  const HomeScreenSmallStaticContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: Responsive.height * 6,
        width: Responsive.width * 28.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppConstants.drawerBgColor,
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizeBoxV(8),
            Image.asset(
              icon,
              height: 20,
            ),
            const SizeBoxV(8),
            Expanded(
              child: commonTextWidget(
                maxLines: 2,
                align: TextAlign.justify,
                color: AppConstants.white,
                text: title,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
