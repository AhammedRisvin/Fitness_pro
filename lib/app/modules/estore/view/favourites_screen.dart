import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/modules/estore/view%20model/estore_provider.dart';
import 'package:olympic/app/modules/estore/view/cart_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/enums.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/extensions.dart';
import '../widget/product_container.dart';

class EstoreFavouritesScreen extends StatefulWidget {
  const EstoreFavouritesScreen({super.key});

  @override
  State<EstoreFavouritesScreen> createState() => _EstoreFavouritesScreenState();
}

class _EstoreFavouritesScreenState extends State<EstoreFavouritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EstoreProvider>().getEstoreWishListFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.black,
        appBar: AppBar(
          backgroundColor: AppConstants.black,
          title: const commonTextWidget(
            color: AppConstants.white,
            text: "Wishlist",
            fontSize: 18,
          ),
          centerTitle: true,
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
        body: Consumer<EstoreProvider>(builder: (context, value, _) {
          return value.getProductsWishListStatus ==
                  GetProductsWishListStatus.loading
              ? const CircularLoader()
              : value.estoreWishList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              AppConstants.appPrimaryColor.withOpacity(0.2),
                          child: const Icon(
                            Icons.favorite_border,
                            color: AppConstants.white,
                            size: 30,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 3),
                        const Center(
                          child: Text(
                            "No items in wishlist",
                            style: TextStyle(
                                color: AppConstants.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.all(15),
                      child: GridView.builder(
                        itemCount: value.estoreWishList.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: Responsive.width * 4,
                          mainAxisSpacing: Responsive.width * 4,
                          childAspectRatio: .8,
                        ),
                        itemBuilder: (context, index) {
                          final newData = value.estoreWishList[index].product;
                          return ProductContainerUsedINGridview(
                            isFromHome: false,
                            onTap: () => context
                                .read<EstoreProvider>()
                                .removeFromEstoreWishListFn(
                                  isFromHome: false,
                                  context: context,
                                  productId: "${newData?.id}",
                                  isFrom: 'wishlist',
                                  index: index,
                                ),
                            index: index,
                            isFromWishlist: true,
                            productId: value.estoreWishList[index].product?.id
                                    .toString() ??
                                '',
                            image: value.estoreWishList[index].product?.images
                                        ?.isEmpty ==
                                    true
                                ? ""
                                : value.estoreWishList[index].product
                                        ?.images?[0]
                                        .toString() ??
                                    '',
                            productBrand: value
                                    .estoreWishList[index].product?.brand
                                    .toString() ??
                                '',
                            productName: value
                                    .estoreWishList[index].product?.productName
                                    .toString() ??
                                '',
                            productPrize: value.estoreWishList[index].product
                                    ?.details?[0].price
                                    .toString() ??
                                '',
                          );
                        },
                      ),
                    );
        }));
  }
}
