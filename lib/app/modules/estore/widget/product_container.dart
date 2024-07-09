import 'package:flutter/material.dart';
import 'package:olympic/app/modules/estore/view%20model/estore_provider.dart';
import 'package:olympic/app/modules/estore/view/product_details_screen.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class ProductContainerUsedINGridview extends StatelessWidget {
  final bool isFromWishlist;
  final bool isFromHome;
  final int index;
  final String productId;
  final String image;
  final String productName;
  final String productBrand;
  final String productPrize;
  final void Function() onTap;
  final bool? isIconNeeded;
  const ProductContainerUsedINGridview({
    super.key,
    required this.index,
    required this.image,
    required this.productBrand,
    required this.productName,
    required this.productPrize,
    required this.onTap,
    required this.productId,
    required this.isFromHome,
    this.isFromWishlist = false,
    this.isIconNeeded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<EstoreProvider>(builder: (context, value, _) {
      return CommonInkwell(
        onTap: () {
          context
              .read<EstoreProvider>()
              .getEstoreProductsDetailFn(id: productId.toString());
          context.read<EstoreProvider>().changeIsCartedStatus();
          Routes.push(
              screen: ProductDetailsScreen(
            isFromHome: isFromHome,
            isFromCart: false,
          ));
        },
        child: Container(
          padding: EdgeInsets.only(bottom: Responsive.height * 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppConstants.drawerBgColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  estoreCommonNetworkImage(
                    url: image,
                    height: Responsive.height * 14.5,
                    width: Responsive.width * 100,
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: isIconNeeded == false
                        ? const SizedBox.shrink()
                        : CommonInkwell(
                            onTap: onTap,
                            child: CircleAvatar(
                              backgroundColor: AppConstants.textFieldTextColor,
                              radius: 18,
                              child: isFromWishlist
                                  ? Image.asset(
                                      AppImages.wishlistedHeart,
                                      height: 16,
                                    )
                                  : Image.asset(
                                      AppImages.normalHeart,
                                      height: 16,
                                    ),
                            ),
                          ),
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 0.2),
              Padding(
                padding: EdgeInsets.only(
                  left: Responsive.width * 2,
                ),
                child: commonTextWidget(
                  color: AppConstants.subTextGrey,
                  text: productName,
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Responsive.width * 2),
                child: commonTextWidget(
                  color: AppConstants.white,
                  text: productBrand,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Responsive.width * 2),
                child: commonTextWidget(
                  color: AppConstants.white,
                  text: "$productPrize AED",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ProductContainerUsedDetails extends StatelessWidget {
  final bool isFromWishlist;
  final int index;
  final String productId;
  final String image;
  final String productName;
  final String productBrand;
  final String productPrize;
  final void Function() onTap;
  final bool? isIconNeeded;
  const ProductContainerUsedDetails({
    super.key,
    required this.index,
    required this.image,
    required this.productBrand,
    required this.productName,
    required this.productPrize,
    required this.onTap,
    required this.productId,
    this.isFromWishlist = false,
    this.isIconNeeded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<EstoreProvider>(builder: (context, value, _) {
      return CommonInkwell(
        onTap: () {
          context
              .read<EstoreProvider>()
              .getEstoreProductsDetailFn(id: productId.toString());
          Routes.push(
              screen: const ProductDetailsScreen(
            isFromHome: false,
            isFromCart: false,
          ));
        },
        child: Container(
          padding: EdgeInsets.only(bottom: Responsive.height * 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppConstants.drawerBgColor,
          ),
          child: estoreCommonNetworkImage(
            url: image,
            height: Responsive.height * 14.5,
            width: Responsive.width * 100,
          ),
        ),
      );
    });
  }
}
