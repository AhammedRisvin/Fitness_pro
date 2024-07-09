import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class DoctorWidgetWithoutImage extends StatelessWidget {
  const DoctorWidgetWithoutImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              commonTextWidget(
                text: "Dr Ancy K.r",
                color: AppConstants.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              Spacer(),
              Icon(
                Icons.star,
                color: AppConstants.appPrimaryColor,
                size: 15,
              ),
              SizeBoxV(5),
              commonTextWidget(
                text: "4.3",
                color: AppConstants.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const Row(
            children: [
              commonTextWidget(
                text: "Neurologists",
                color: AppConstants.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              Spacer(),
              commonTextWidget(
                text: "AED 100",
                color: AppConstants.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const commonTextWidget(
            text: "7 year of experience",
            color: AppConstants.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          const SizeBoxH(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 245, 44, 81),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Icon(
                    Icons.favorite,
                    size: 12,
                    color: AppConstants.white,
                  ),
                ),
              ),
              const SizeBoxV(5),
              const commonTextWidget(
                text: '100+',
                color: AppConstants.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Divider(
            height: 25,
            thickness: 1,
            color: AppConstants.teleContainerBg,
          )
        ],
      ),
    );
  }
}
