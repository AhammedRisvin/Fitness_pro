// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/estore/view%20model/estore_provider.dart';
import 'package:olympic/app/modules/estore/view/product_details_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/enums.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../widget/cart_price_row.dart';

class EstoreCartScreen extends StatefulWidget {
  const EstoreCartScreen({super.key});

  @override
  State<EstoreCartScreen> createState() => _EstoreCartScreenState();
}

class _EstoreCartScreenState extends State<EstoreCartScreen> {
  @override
  void initState() {
    context.read<EstoreProvider>().getEstoreCartFn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "Cart",
          fontSize: 18,
          // fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.read<EstoreProvider>().setSelectedIndex(0);
            context.read<EstoreProvider>().updateIndex(0);
            Routes.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppConstants.white,
            size: 20,
          ),
        ),
      ),
      body: Consumer<EstoreProvider>(
        builder: (context, value, _) {
          return value.getProductsCartStatus == GetProductsCartStatus.loading
              ? const CircularLoader()
              : value.eStoreCart.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              AppConstants.appPrimaryColor.withOpacity(0.2),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: AppConstants.white,
                            size: 30,
                          ),
                        ),
                        SizeBoxH(Responsive.height * 3),
                        const Center(
                          child: Text(
                            "No items in cart",
                            style: TextStyle(
                                color: AppConstants.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (Context, index) {
                        return CartContainer(
                          index: index,
                        );
                      },
                      separatorBuilder: (Context, index) {
                        return SizeBoxH(Responsive.height * 1);
                      },
                      itemCount: value.eStoreCart.length,
                    );
        },
      ),
      bottomNavigationBar:
          Consumer<EstoreProvider>(builder: (context, value, _) {
        return value.getProductsCartStatus == GetProductsCartStatus.loading
            ? const SizedBox.shrink()
            : value.eStoreCart.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    height: Responsive.height * 15,
                    width: Responsive.width * 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppConstants.drawerBgColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const CartPriceRowWidget(title: "Sub Total", price: "AED 950"),
                        // const CartPriceRowWidget(title: "Delivery Charge", price: "AED 50"),
                        // const CartPriceRowWidget(title: "Discount", price: "AED 00.0"),
                        CartPriceRowWidget(
                            title: "Total",
                            price: "${value.totalPrice} AED",
                            priceSize: 20,
                            titleSize: 20,
                            priceWeight: FontWeight.w700,
                            titleWeight: FontWeight.w700),
                        CommonButton(
                          onTap: () {
                            context
                                .read<EstoreProvider>()
                                .stripeFn(context: context);
                          },
                          text: "Place your Order",
                          width: Responsive.width * 100,
                          height: Responsive.height * 6.5,
                        )
                      ],
                    ),
                  );
      }),
    );
  }
}

class CircularLoader extends StatelessWidget {
  const CircularLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height * 100,
      width: Responsive.width * 100,
      child: const SizedBox(
        height: 60,
        width: 80,
        child: Center(
          child: CircularProgressIndicator(
            color: AppConstants.appPrimaryColor,
          ),
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height * 100,
      width: Responsive.width * 100,
      child: const SizedBox(
        height: 60,
        width: 80,
        child: Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}

class CartContainer extends StatefulWidget {
  final int index;
  const CartContainer({super.key, required this.index});

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  EstoreProvider? estoreProvider;

  @override
  void initState() {
    super.initState();
    estoreProvider = context.read<EstoreProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EstoreProvider>(builder: (context, value, _) {
      return CommonInkwell(
        onTap: () {
          estoreProvider!.getEstoreProductsDetailFn(
              id: value.eStoreCart[widget.index].product!.id.toString());
          context.read<EstoreProvider>().changeIsCartedStatus();
          Routes.push(
              screen: const ProductDetailsScreen(
            isFromHome: false,
            isFromCart: true,
          ));
        },
        child: Container(
          height: Responsive.height * 14,
          width: Responsive.width * 100,
          decoration: BoxDecoration(
            color: AppConstants.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              SizeBoxV(Responsive.width * 3),
              // Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       fit: BoxFit.cover,
              //       image: NetworkImage(value
              //           .eStoreCart[widget.index].product!.images![0]
              //           .toString()),
              //     ),
              //     borderRadius: BorderRadius.circular(15),
              //     color: Colors.amber,
              //   ),
              // ),
              estoreCommonNetworkImage(
                url: value.eStoreCart[widget.index].product?.images?.isEmpty ==
                        true
                    ? ""
                    : value.eStoreCart[widget.index].product?.images?[0]
                            .toString() ??
                        "",
                height: Responsive.height * 10,
                width: Responsive.width * 24,
              ),
              SizeBoxV(Responsive.width * 4),
              SizedBox(
                width: Responsive.width * 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizeBoxH(Responsive.height * 2),
                    commonTextWidget(
                      overFlow: TextOverflow.ellipsis,
                      color: AppConstants.white,
                      text:
                          "${value.eStoreCart[widget.index].product?.productName} "
                              .toString(),
                      fontWeight: FontWeight.w600,
                    ),
                    commonTextWidget(
                      overFlow: TextOverflow.ellipsis,
                      color: AppConstants.subTextGrey,
                      text: value.eStoreCart[widget.index].product!.brand! +
                          value.eStoreCart[widget.index].size.toString(),
                      fontSize: 16,
                      // fontWeight: FontWeight.w600,
                    ),
                    commonTextWidget(
                      overFlow: TextOverflow.ellipsis,
                      color: AppConstants.white,
                      text:
                          "${value.eStoreCart[widget.index].product?.prize.toString() ?? 0} AED",
                      fontSize: 18,
                      // fontWeight: FontWeight.w600,
                    ),
                    SizeBoxH(Responsive.height * 2),
                  ],
                ),
              ),
              SizeBoxV(Responsive.width * 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonInkwell(
                          onTap: () {
                            estoreProvider!.changeItemSize(
                                tempItemSize: value.toString(), tempPrize: 0);
                            estoreProvider!.removeFromEstoreCartFn(
                                context: context,
                                cartId: value.eStoreCart[widget.index].id
                                    .toString(),
                                isFrom: 'cart',
                                index: widget.index);
                          },
                          child: Container(
                            height: Responsive.height * 5,
                            width: Responsive.width * 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  AppImages.minusButton,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Selector<EstoreProvider, int>(
                            selector: (_, provider) =>
                                value.eStoreCart[widget.index].count!,
                            builder: (context, noOfItems, child) {
                              return commonTextWidget(
                                color: AppConstants.white,
                                text: value.eStoreCart[widget.index].count!
                                    .toString(),
                                fontSize: 16,
                              );
                            },
                          ),
                        ),
                        CommonInkwell(
                          onTap: () {
                            estoreProvider!.changeItemSize(
                                tempItemSize: value
                                    .eStoreCart[widget.index].size
                                    .toString(),
                                tempPrize: 0);
                            estoreProvider!.addToEstoreCartFn(
                                context: context,
                                productId: value
                                    .eStoreCart[widget.index].product!.id
                                    .toString(),
                                isFrom: 'cart',
                                index: widget.index);
                          },
                          child: Container(
                            height: Responsive.height * 5,
                            width: Responsive.width * 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  AppImages.addButton,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
