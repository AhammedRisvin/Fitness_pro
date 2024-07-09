import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../helpers/common_widget.dart';
import '../helpers/size_box.dart';
import 'app_constants.dart';
import 'extensions.dart';

class ShimmerSlotContainer extends StatelessWidget {
  const ShimmerSlotContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppConstants.drawerBgColor,
      highlightColor: AppConstants.drawerBgColor,
      period: const Duration(milliseconds: 800),
      child: Container(
        height: Responsive.height * 8,
        width: Responsive.width * 100,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Responsive.width * 40,
                  height: Responsive.height * 2,
                  color: Colors.grey[100],
                ),
                Container(
                  width: Responsive.width * 40,
                  height: Responsive.height * 2,
                  color: Colors.grey[100],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Responsive.width * 40,
                  height: Responsive.height * 5,
                  color: Colors.grey[100],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FacilityRentalShimmerContainer extends StatelessWidget {
  const FacilityRentalShimmerContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppConstants.drawerBgColor,
      highlightColor: AppConstants.drawerBgColor,
      period: const Duration(milliseconds: 800),
      child: Container(
        height: Responsive.height * 15,
        width: Responsive.width * 100,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppConstants.drawerBgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              commonNetworkImage(
                height: Responsive.height * 13,
                width: Responsive.width * 26,
                url: "http://via.placeholder.com/200x150",
              ),
              SizeBoxV(Responsive.width * 4),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Responsive.width * 60,
                      height: Responsive.height * 2,
                      color: Colors.grey[100],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Responsive.width * 40,
                          height: Responsive.height * 1.5,
                          color: Colors.grey[100],
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Responsive.width * 40,
                          height: Responsive.height * 1.5,
                          color: Colors.grey[100],
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EstoreOrderHistoryContainer extends StatelessWidget {
  const EstoreOrderHistoryContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppConstants.drawerBgColor,
      highlightColor: AppConstants.drawerBgColor,
      period: const Duration(milliseconds: 800),
      child: Container(
        height: Responsive.height * 15,
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          color: AppConstants.drawerBgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SizeBoxV(Responsive.width * 3),
            Container(
              width: Responsive.width * 22,
              height: Responsive.height * 11,
              color: Colors.grey[100],
            ),
            SizeBoxV(Responsive.width * 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizeBoxH(Responsive.height * 1),
                  Container(
                    width: double.infinity,
                    height: Responsive.height * 2,
                    color: Colors.grey[100],
                  ),
                  Container(
                    width: double.infinity,
                    height: Responsive.height * 1.5,
                    color: Colors.grey[100],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Responsive.width * 20,
                        height: Responsive.height * 1.5,
                        color: Colors.white,
                      ),
                      Container(
                        width: Responsive.width * 20,
                        height: Responsive.height * 1.5,
                        color: Colors.grey[100],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Responsive.width * 20,
                        height: Responsive.height * 1.5,
                        color: Colors.grey[100],
                      ),
                      Container(
                        width: Responsive.width * 20,
                        height: Responsive.height * 1.5,
                        color: Colors.grey[100],
                      ),
                    ],
                  ),
                  SizeBoxH(Responsive.height * .5),
                ],
              ),
            ),
            SizeBoxV(Responsive.width * 3),
          ],
        ),
      ),
    );
  }
}

class CardShimmers extends StatelessWidget {
  const CardShimmers({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppConstants.drawerBgColor,
      highlightColor: AppConstants.drawerBgColor,
      period: const Duration(milliseconds: 800),
      child: Container(
        height: Responsive.height * 17,
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppConstants.drawerBgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              Container(
                height: Responsive.height * 12,
                width: Responsive.width * 24,
                color: Colors.white, // Use white color as placeholder
              ),
              SizeBoxV(Responsive.width * 4),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Responsive.height * 2, // Adjust height as needed
                      color: Colors.white, // Use white color as placeholder
                    ),
                    Container(
                      height: Responsive.height * 2, // Adjust height as needed
                      color: Colors.white, // Use white color as placeholder
                    ),
                    Container(
                      height: Responsive.height * 2, // Adjust height as needed
                      color: Colors.white, // Use white color as placeholder
                    ),
                    Container(
                      height: Responsive.height * 2, // Adjust height as needed
                      color: Colors.white, // Use white color as placeholder
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
