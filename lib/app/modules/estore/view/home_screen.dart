import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/estore/view/cart_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/enums.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_images.dart';
import '../view model/estore_provider.dart';
import '../widget/product_container.dart';

class EstoreHomeScreen extends StatefulWidget {
  const EstoreHomeScreen({super.key});

  @override
  State<EstoreHomeScreen> createState() => _EstoreHomeScreenState();
}

class _EstoreHomeScreenState extends State<EstoreHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EstoreProvider>().getEstoreProductsFn();
    context.read<EstoreProvider>().getEstoreCategoryFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstants.black,
        title: Row(
          children: [
            const SizeBoxV(30),
            Image.asset(
              AppImages.onboardingLogo,
              height: 60,
              width: 60,
            ),
            const commonTextWidget(
              text: "Olympic Combat",
              color: AppConstants.white,
              fontSize: 18,
            ),
          ],
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
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        width: Responsive.width * 100,
        height: Responsive.height * 100,
        child: Column(
          children: [
            Consumer<EstoreProvider>(builder: (context, value, _) {
              return SizedBox(
                  height: Responsive.height * 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      value.getProductsCategoryStatus ==
                              GetProductsCategoryStatus.loading
                          ? 0
                          : value.estoreProductCategoryList.length,
                      (index) => CommonInkwell(
                        onTap: value.estoreProductCategoryList[index].name ==
                                'All Products'
                            ? () => context
                                .read<EstoreProvider>()
                                .getEstoreProductsFn()
                            : () => context
                                .read<EstoreProvider>()
                                .getEstoreProductsByCategoryFn(
                                    categoryName: value
                                        .estoreProductCategoryList[index].name
                                        .toString()),
                        child: EStoreCategoryContainer(
                            isAsset:
                                value.estoreProductCategoryList[index].name ==
                                        'All Products'
                                    ? true
                                    : false,
                            image: value.estoreProductCategoryList[index]
                                        .name ==
                                    'All Products'
                                ? AppImages.estoreCategory1
                                : value.estoreProductCategoryList[index].image
                                    .toString()),
                      ),
                    ),
                  ));
            }),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     EStoreCategoryContainer(image: AppImages.estoreCategory1),
            //     EStoreCategoryContainer(image: AppImages.estoreCategory2),
            //     EStoreCategoryContainer(image: AppImages.estoreCategory3),
            //     EStoreCategoryContainer(image: AppImages.estoreCategory4),
            //   ],
            // ),
            SizeBoxH(Responsive.height * 4),
            Expanded(
              child: Consumer<EstoreProvider>(builder: (context, value, _) {
                return value.getProductsStatus == GetProductsStatus.loading
                    ? const CircularLoader()
                    : value.estoreProductsList.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: AppConstants.appPrimaryColor
                                    .withOpacity(0.2),
                                child: const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: AppConstants.white,
                                  size: 30,
                                ),
                              ),
                              SizeBoxH(Responsive.height * 3),
                              const Center(
                                child: Text(
                                  "No Products Found!",
                                  style: TextStyle(
                                      color: AppConstants.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          )
                        : GridView.builder(
                            itemCount: value.estoreProductsList.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: Responsive.width * 3,
                              mainAxisSpacing: Responsive.width * 2,
                              childAspectRatio: .84,
                            ),
                            padding: const EdgeInsets.only(bottom: 90),
                            itemBuilder: (context, index) {
                              return ProductContainerUsedINGridview(
                                isFromHome: true,
                                onTap: () => value.estoreProductsList[index]
                                            .wishlist ==
                                        true
                                    ? context
                                        .read<EstoreProvider>()
                                        .removeFromEstoreWishListFn(
                                            context: context,
                                            productId: value
                                                .estoreProductsList[index].id
                                                .toString(),
                                            isFrom: 'home',
                                            isFromHome: true,
                                            index: index)
                                    : context
                                        .read<EstoreProvider>()
                                        .addToEstoreWishListFn(
                                            context: context,
                                            productId: value
                                                .estoreProductsList[index].id
                                                .toString(),
                                            isFrom: 'home',
                                            isFromHome: true,
                                            index: index),
                                productId: value.estoreProductsList[index].id
                                    .toString(),
                                isFromWishlist:
                                    value.estoreProductsList[index].wishlist ??
                                        false,
                                index: index,
                                image: value.estoreProductsList[index].images
                                            ?.isEmpty ==
                                        true
                                    ? ""
                                    : value.estoreProductsList[index].images?[0]
                                            .toString() ??
                                        "",
                                productBrand: value
                                    .estoreProductsList[index].brand
                                    .toString(),
                                productName: value
                                    .estoreProductsList[index].productName
                                    .toString(),
                                productPrize: value.estoreProductsList[index]
                                            .details?.isEmpty ==
                                        true
                                    ? "0"
                                    : value.estoreProductsList[index]
                                            .details?[0].price
                                            .toString() ??
                                        "0",
                              );
                            },
                          );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class EStoreCategoryContainer extends StatelessWidget {
  final String image;
  final bool isAsset;
  const EStoreCategoryContainer({
    super.key,
    required this.image,
    required this.isAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 8,
      width: Responsive.width * 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppConstants.drawerBgColor,
      ),
      child: Center(
        child: isAsset
            ? Image.asset(
                image,
                height: 25,
              )
            : estoreCommonNetworkImage(
                url: image,
                height: 25,
                width: 25,
              ),
      ),
    );
  }
}
