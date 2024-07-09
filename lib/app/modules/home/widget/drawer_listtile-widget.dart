import 'package:flutter/material.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class DrawerListTileWidget extends StatelessWidget {
  final String icon;
  final String title;
  final bool isLogout;
  final void Function() ontap;
  const DrawerListTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.ontap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: Responsive.height * 6.5,
        width: Responsive.width * 100,
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 22,
            ),
            const SizeBoxV(20),
            commonTextWidget(
              color: isLogout ? AppConstants.red : AppConstants.white,
              text: title,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
