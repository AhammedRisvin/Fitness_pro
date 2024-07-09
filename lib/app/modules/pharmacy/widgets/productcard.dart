import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../helpers/common_widget.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppConstants.searchColor,
      ),
      padding: const EdgeInsets.all(9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xffFFD600),
                  ),
                  commonTextWidget(
                    color: AppConstants.white,
                    text: '4.2',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: AppConstants.white,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              )
            ],
          ),
          commonNetworkImage(
            url: '',
            height: Responsive.height * 10,
            width: Responsive.width * 40,
          ),
          SizeBoxH(Responsive.height * 0.5),
          const commonTextWidget(
            color: AppConstants.white,
            text: 'Amlodipine tablets',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          SizeBoxH(Responsive.height * 0.5),
          const commonTextWidget(
            color: AppConstants.white,
            text: 'Amlodipine tablets',
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          SizeBoxH(Responsive.height * 0.5),
          const commonTextWidget(
            color: AppConstants.appPrimaryColor,
            text: 'AED 57.75',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
