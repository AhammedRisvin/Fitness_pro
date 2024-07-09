import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';

import '../../../helpers/common_widget.dart';

import '../../../utils/extensions.dart';

class LoginMethodChoosingContainer extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final Color titleColor;
  final String icon;
  final String title;
  const LoginMethodChoosingContainer({
    super.key,
    required this.bgColor,
    required this.borderColor,
    required this.icon,
    required this.title,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 8.5,
      width: Responsive.width * 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: bgColor,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  height: 30,
                  width: 30,
                ),
                const SizeBoxV(10),
                commonTextWidget(
                  text: title,
                  color: titleColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
