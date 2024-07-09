import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';

class DoctorCategoryWidget extends StatelessWidget {
  final void Function()? onTap;
  const DoctorCategoryWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: SizedBox(
        height: 80,
        child: AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 250),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const ShapeDecoration(
                  color: Color(0xFFEAEAEA),
                  shape: OvalBorder(),
                ),
                child: const ClipOval(
                  child: commonNetworkImage(
                      isTopCurved: true,
                      radius: 30,
                      url:
                          'https://t3.ftcdn.net/jpg/01/21/42/44/360_F_121424481_OwtlvRwv95pemyGSKaKHRYQdPyZITpZh.jpg',
                      height: 60,
                      width: 60),
                ),
              ),
              const SizeBoxH(5),
              const commonTextWidget(
                text: "title",
                overFlow: TextOverflow.ellipsis,
                align: TextAlign.center,
                color: AppConstants.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
