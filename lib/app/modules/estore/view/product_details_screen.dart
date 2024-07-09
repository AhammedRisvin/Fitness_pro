import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/estore/view/cart_screen.dart';
import 'package:olympic/app/modules/estore/widget/product_container.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/enums.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../view model/estore_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final bool isFromHome;
  final bool isFromCart;
  const ProductDetailsScreen(
      {super.key, required this.isFromHome, required this.isFromCart});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final estoreProviderVar = Provider.of<EstoreProvider>(context);

    return Consumer<EstoreProvider>(builder: (context, estoreProvider, _) {
      return Scaffold(
        backgroundColor: AppConstants.black,
        appBar: AppBar(
          backgroundColor: AppConstants.black,
          title: const commonTextWidget(
            text: 'Product Details',
            color: AppConstants.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
          actions: [
            estoreProvider.getProductsDetailStatus ==
                    GetProductsDetailStatus.loading
                ? const SizedBox.shrink()
                : estoreProvider.getProductsDetailStatus ==
                        GetProductsDetailStatus.error
                    ? const SizedBox.shrink()
                    : CommonInkwell(
                        onTap: () =>
                            estoreProvider.estoreProductDetail.wishlist == true
                                ? estoreProviderVar.removeFromEstoreWishListFn(
                                    context: context,
                                    productId: estoreProvider
                                        .estoreProductDetail.id
                                        .toString(),
                                    isFrom: 'details',
                                    isFromHome: widget.isFromHome)
                                : estoreProviderVar.addToEstoreWishListFn(
                                    context: context,
                                    productId: estoreProvider
                                        .estoreProductDetail.id
                                        .toString(),
                                    isFrom: 'details',
                                    isFromHome: widget.isFromHome),
                        child: CircleAvatar(
                          backgroundColor: AppConstants.transparent,
                          radius: 18,
                          child: estoreProvider.estoreProductDetail.wishlist ==
                                  true
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
            const SizeBoxV(10),
          ],
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: estoreProvider.getProductsDetailStatus ==
                  GetProductsDetailStatus.loading
              ? const CircularLoader()
              : estoreProvider.getProductsDetailStatus ==
                      GetProductsDetailStatus.error
                  ? const ErrorScreen()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Responsive.height * 25,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              PageView.builder(
                                itemCount: estoreProvider
                                        .estoreProductDetail.images?.length ??
                                    0,
                                onPageChanged: (index) {
                                  estoreProvider.updateIndex(index);
                                },
                                itemBuilder: (context, index) {
                                  // return Container(
                                  //   width: Responsive.width * 100,
                                  //   height: Responsive.height * 30,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(15),
                                  //     image: DecorationImage(
                                  //       image: AssetImage(estoreProvider.images[index]),
                                  //       fit: BoxFit.cover,
                                  //     ),
                                  //   ),
                                  // );
                                  return estoreCommonNetworkImage(
                                    url: estoreProvider.estoreProductDetail
                                                .images?.isEmpty ==
                                            true
                                        ? ""
                                        : estoreProvider.estoreProductDetail
                                                .images?[index]
                                                .toString() ??
                                            "",
                                    height: Responsive.height * 30,
                                    width: Responsive.width * 100,
                                    isTopCurved: false,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    estoreProvider.estoreProductDetail.images
                                            ?.length ??
                                        0,
                                    (index) => estoreProvider
                                                .estoreProductDetail
                                                .images
                                                ?.length ==
                                            1
                                        ? const SizedBox.shrink()
                                        : Container(
                                            width: 8,
                                            height: 8,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color:
                                                  estoreProvider.currentIndex ==
                                                          index
                                                      ? AppConstants.white
                                                      : Colors.grey
                                                          .withOpacity(0.4),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizeBoxH(Responsive.height * 4),
                              commonTextWidget(
                                color: AppConstants.white,
                                text: estoreProvider
                                    .estoreProductDetail.productName
                                    .toString(),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              SizeBoxH(Responsive.height * 1),
                              commonTextWidget(
                                color: AppConstants.subTextGrey,
                                text: estoreProvider.estoreProductDetail.brand
                                    .toString(),
                                fontSize: 18,
                                // fontWeight: FontWeight.w600,
                              ),
                              SizeBoxH(Responsive.height * 3),
                              const commonTextWidget(
                                color: AppConstants.white,
                                text: "Description",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              SizeBoxH(Responsive.height * 2),
                              commonTextWidget(
                                color: AppConstants.subTextGrey,
                                text: estoreProvider
                                    .estoreProductDetail.description
                                    .toString(),
                                fontSize: 14,
                                align: TextAlign.start,
                                // fontWeight: FontWeight.w600,
                              ),
                              estoreProvider.estoreProductDetail
                                              .relatedProducts ==
                                          null ||
                                      estoreProvider.estoreProductDetail
                                              .relatedProducts?.isEmpty ==
                                          true
                                  ? const SizedBox.shrink()
                                  : SizeBoxH(Responsive.height * 3),
                              estoreProvider.estoreProductDetail
                                              .relatedProducts ==
                                          null ||
                                      estoreProvider.estoreProductDetail
                                              .relatedProducts?.isEmpty ==
                                          true
                                  ? const SizedBox.shrink()
                                  : const commonTextWidget(
                                      color: AppConstants.white,
                                      text: "Variants",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                              estoreProvider.estoreProductDetail
                                              .relatedProducts ==
                                          null ||
                                      estoreProvider.estoreProductDetail
                                              .relatedProducts?.isEmpty ==
                                          true
                                  ? const SizedBox.shrink()
                                  : SizeBoxH(Responsive.height * 2),
                              estoreProvider.estoreProductDetail
                                              .relatedProducts ==
                                          null ||
                                      estoreProvider.estoreProductDetail
                                              .relatedProducts?.isEmpty ==
                                          true
                                  ? const SizedBox.shrink()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.generate(
                                        estoreProvider.estoreProductDetail
                                                .relatedProducts?.length ??
                                            0,
                                        (indesx) {
                                          return SizedBox(
                                            width: Responsive.width * 40,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child:
                                                  ProductContainerUsedDetails(
                                                productId: estoreProvider
                                                        .estoreProductDetail
                                                        .relatedProducts?[0]
                                                        .id
                                                        .toString() ??
                                                    "",
                                                isIconNeeded: false,
                                                onTap: () {},
                                                isFromWishlist: false,
                                                index: 0,
                                                image: estoreProvider
                                                            .estoreProductDetail
                                                            .images
                                                            ?.isEmpty ==
                                                        true
                                                    ? ""
                                                    : estoreProvider
                                                            .estoreProductDetail
                                                            .relatedProducts?[0]
                                                            .images?[0]
                                                            .toString() ??
                                                        "",
                                                productBrand: estoreProvider
                                                        .estoreProductDetail
                                                        .relatedProducts?[0]
                                                        .brand
                                                        .toString() ??
                                                    "",
                                                productName: estoreProvider
                                                        .estoreProductDetail
                                                        .relatedProducts?[0]
                                                        .productName
                                                        .toString() ??
                                                    "",
                                                productPrize: estoreProvider
                                                            .estoreProductDetail
                                                            .details
                                                            ?.isEmpty ==
                                                        true
                                                    ? "0.0"
                                                    : estoreProvider
                                                            .estoreProductDetail
                                                            .relatedProducts?[0]
                                                            .details?[0]
                                                            .price
                                                            .toString() ??
                                                        "",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              SizeBoxH(Responsive.height * 3),
                              const commonTextWidget(
                                color: AppConstants.white,
                                text: "Size",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              SizeBoxH(Responsive.height * 2),
                              Row(
                                children: List.generate(
                                  estoreProvider.estoreProductDetail.details
                                          ?.length ??
                                      0,
                                  (index) {
                                    var size = estoreProvider
                                        .estoreProductDetail.details?[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: CommonInkwell(
                                        onTap: () =>
                                            estoreProviderVar.changeItemSize(
                                                tempPrize: int.parse(
                                                    size?.price?.toString() ??
                                                        "0"),
                                                tempItemSize:
                                                    size?.size?.toString() ??
                                                        ""),
                                        child: Container(
                                          height: Responsive.height * 5,
                                          width: Responsive.width * 10,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: estoreProvider.itemSize
                                                        .toString()
                                                        .toUpperCase() ==
                                                    size?.size?.toUpperCase()
                                                ? AppConstants.appPrimaryColor
                                                : AppConstants.black,
                                            border: Border.all(
                                              color: estoreProvider.itemSize
                                                          .toString()
                                                          .toUpperCase() ==
                                                      size?.size
                                                          .toString()
                                                          .toUpperCase()
                                                  ? AppConstants.black
                                                  : AppConstants.white,
                                            ),
                                          ),
                                          child: Center(
                                            child: commonTextWidget(
                                              color: estoreProvider.itemSize
                                                          .toString()
                                                          .toUpperCase() ==
                                                      size?.size
                                                          .toString()
                                                          .toUpperCase()
                                                  ? AppConstants.black
                                                  : AppConstants.white,
                                              text: size?.size
                                                      ?.toString()
                                                      .toUpperCase() ??
                                                  "",
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
        ),
        bottomNavigationBar: SizedBox(
          height: Responsive.height * 9,
          // color: Colors.amber,
          child: estoreProvider.getProductsDetailStatus ==
                  GetProductsDetailStatus.loading
              ? const SizedBox.shrink()
              : estoreProvider.getProductsDetailStatus ==
                      GetProductsDetailStatus.error
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        commonTextWidget(
                          color: AppConstants.appPrimaryColor,
                          text: " ${estoreProvider.productPrice} AED",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        CommonButton(
                          onTap: estoreProvider.isCarted
                              ? widget.isFromCart
                                  ? () {
                                      Routes.back();
                                      estoreProvider.getEstoreCartFn();
                                    }
                                  : () {
                                      Routes.push(
                                          screen: const EstoreCartScreen());
                                    }
                              : () {
                                  estoreProviderVar.addToEstoreCartFn(
                                      context: context,
                                      productId: estoreProvider
                                          .estoreProductDetail.id
                                          .toString(),
                                      isFrom: 'details');
                                },
                          text: estoreProvider.isCarted
                              ? "View Cart"
                              : "Add to Cart",
                          width: Responsive.width * 50,
                          height: Responsive.height * 6.5,
                        ),
                      ],
                    ),
        ),
      );
    });
  }
}
