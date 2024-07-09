import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class DoctorWidget extends StatelessWidget {
  const DoctorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      height: Responsive.height * 24,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppConstants.teleContainerBg),
      child: Row(
        children: [
          SizedBox(
            width: Responsive.width * 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 117,
                  width: 121,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppConstants.white),
                  child: const commonNetworkImage(
                      height: 117,
                      width: 121,
                      fit: BoxFit.cover,
                      isTopCurved: true,
                      radius: 5,
                      url:
                          'https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg'),
                ),
                const SizeBoxH(15),
                CommonButton(
                    onTap: () {},
                    text: "Book Now",
                    size: 12,
                    width: 105,
                    height: 32)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            width: Responsive.width * 53,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const commonTextWidget(
                      text: 'D.r Amanda',
                      color: AppConstants.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    Container(
                      height: 20,
                      width: 48,
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppConstants.white),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          commonTextWidget(
                            text: '4.3',
                            color: AppConstants.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          SizeBoxV(2),
                          Icon(
                            Icons.star,
                            size: 12,
                            color: AppConstants.appPrimaryColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const commonTextWidget(
                  text: 'Cardiolagist',
                  color: AppConstants.appPrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                const commonTextWidget(
                  text: '10  Years Experience',
                  color: AppConstants.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                const SizeBoxH(5),
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
                const SizeBoxH(8),
                Container(
                  height: 70,
                  width: Responsive.width * 48,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppConstants.white),
                  child: const Column(
                    children: [
                      commonTextWidget(
                        text: 'Next Available',
                        color: AppConstants.black,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                      SizeBoxH(4),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonTextWidget(
                              text: '10  AM Tommorrow',
                              color: AppConstants.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            commonTextWidget(
                              text: 'Consultation Fees',
                              color: AppConstants.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                            commonTextWidget(
                              text: 'AED 100 ',
                              color: AppConstants.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
