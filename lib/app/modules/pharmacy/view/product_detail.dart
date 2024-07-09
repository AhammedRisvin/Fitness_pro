import 'package:flutter/material.dart';
import 'package:olympic/app/core/app_router.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import 'review_page.dart';

class PrdoductDetailsScreen extends StatelessWidget {
  const PrdoductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: SingleChildScrollView(
        child: SizedBox(
          width: Responsive.width * 100,
          height: Responsive.height * 100,
          child: Stack(
            children: [
              Container(
                width: Responsive.width * 100,
                height: Responsive.height * 40,
                decoration: BoxDecoration(
                  color: const Color(0xffffffd1).withOpacity(0.2),
                  image: DecorationImage(
                    image: AssetImage(
                      AppImages.detailsbg,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: Responsive.height * 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      width: Responsive.width * 85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonInkwell(
                            onTap: () {
                              Routes.back();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: AppConstants.white,
                              size: 20,
                            ),
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: AppConstants.white,
                                child: Icon(
                                  Icons.favorite_border,
                                  color: AppConstants.red,
                                ),
                              ),
                              SizeBoxV(Responsive.width * 2),
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: AppConstants.white,
                                child: Icon(
                                  Icons.share,
                                  color: AppConstants.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
              Positioned(
                top: Responsive.height * 35,
                child: Container(
                  width: Responsive.width * 100,
                  height: Responsive.height * 80,
                  decoration: const BoxDecoration(
                    color: AppConstants.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizeBoxH(Responsive.height * 2),
                      const commonTextWidget(
                        fontWeight: FontWeight.w700,
                        color: AppConstants.white,
                        text: "mcT OIL",
                        fontSize: 18,
                      ),
                      SizeBoxH(Responsive.height * 0.5),
                      const commonTextWidget(
                        align: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.white,
                        text:
                            "MCT oil, which stands for medium-chain triglyceride oil, is a type of dietary fat that is composed of medium-length chains of fatty acids. These fatty acids are called medium-chain triglycerides.",
                        fontSize: 12,
                      ),
                      SizeBoxH(Responsive.height * 1.5),
                      const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xffFF9F00),
                          ),
                          SizeBoxV(5),
                          commonTextWidget(
                            color: AppConstants.white,
                            text: '4.2',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          SizeBoxV(5),
                          commonTextWidget(
                            color: AppConstants.white,
                            text: '(100)',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizeBoxH(Responsive.height * 1.5),
                      CommonInkwell(
                        onTap: () {
                          Routes.push(screen: const ViewPageScreen());
                        },
                        child: const Row(
                          children: [
                            commonTextWidget(
                              fontWeight: FontWeight.w500,
                              color: AppConstants.white,
                              text: "View reviews",
                              fontSize: 14,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppConstants.white,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                      SizeBoxH(Responsive.height * 0.5),
                      const commonTextWidget(
                        color: AppConstants.appPrimaryColor,
                        text: 'AED 57.75',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      SizeBoxH(Responsive.height * 3.7),
                      const commonTextWidget(
                        fontWeight: FontWeight.w700,
                        color: AppConstants.white,
                        text: "Related Products",
                        fontSize: 18,
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const commonTextWidget(
                        align: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.white,
                        text: "People usually order these as well",
                        fontSize: 12,
                      ),
                      SizeBoxH(Responsive.height * 2),
                      SizedBox(
                        height: Responsive.height * 22,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return const RelatedContainer();
                            },
                            separatorBuilder: (context, index) =>
                                SizeBoxV(Responsive.width * 5),
                            itemCount: 3),
                      ),

                      // const commonTextWidget(
                      //   color: AppConstants.appPrimaryColor,
                      //   text: 'AED 57.75',
                      //   fontSize: 20,
                      //   fontWeight: FontWeight.w600,
                      // ),
                      CommonButton(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            // Routes.push(screen: const FavoritesScreen());
                          },
                          text: 'Add to cart',
                          width: Responsive.width * 100,
                          height: Responsive.height * 6),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RelatedContainer extends StatelessWidget {
  const RelatedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 40,
      height: Responsive.height * 20,
      decoration: BoxDecoration(
          color: AppConstants.searchColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          commonNetworkImage(
            url: '',
            height: Responsive.height * 15,
            width: Responsive.width * 40,
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
