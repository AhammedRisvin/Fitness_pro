import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class ViewPageScreen extends StatelessWidget {
  const ViewPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        leading: IconButton(
          onPressed: () {
            Routes.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppConstants.white,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeBoxH(Responsive.height * 3),
              Row(
                children: [
                  Container(
                    width: Responsive.width * 35,
                    height: Responsive.height * 16,
                    decoration: BoxDecoration(
                        color: AppConstants.searchColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3333330D),
                            offset: Offset(4, 4),
                            blurRadius: 26,
                            spreadRadius: 0,
                          ),
                        ]),
                    child: commonNetworkImage(
                      url: '',
                      height: Responsive.height * 14,
                      width: Responsive.width * 26,
                    ),
                  ),
                  SizeBoxV(Responsive.width * 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xffFF9F00),
                          ),
                          SizeBoxV(5),
                          commonTextWidget(
                            color: AppConstants.white,
                            text: '4.2',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          SizeBoxV(5),
                          commonTextWidget(
                            color: AppConstants.white,
                            text: '(100)',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const commonTextWidget(
                        color: AppConstants.white,
                        text: 'Based on 1666 ratings',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
                ],
              ),
              SizeBoxH(Responsive.height * 3),
              const commonTextWidget(
                color: AppConstants.white,
                text: 'Reviews',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              SizeBoxH(Responsive.height * 3),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 35,
                              child: commonNetworkImage(
                                  url: '', height: 60, width: 60),
                            ),
                            SizeBoxV(Responsive.width * 3),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const commonTextWidget(
                                      color: AppConstants.white,
                                      text: 'Ajas',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizeBoxV(Responsive.width * 25),
                                    const commonTextWidget(
                                      color: AppConstants.appPrimaryColor,
                                      text: '13 September 2023',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xffFF9F00),
                                    ),
                                    SizeBoxV(5),
                                    commonTextWidget(
                                      color: AppConstants.white,
                                      text: '4.2',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                SizeBoxH(Responsive.height * 2),
                                SizedBox(
                                  width: Responsive.width * 70,
                                  child: const commonTextWidget(
                                    color: AppConstants.white,
                                    text:
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    overFlow: TextOverflow.clip,
                                    align: TextAlign.start,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 0,
                          color: AppConstants.white,
                          height: 100,
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizeBoxH(Responsive.height * 0),
                  itemCount: 5),
            ],
          ),
        ),
      ),
    );
  }
}
