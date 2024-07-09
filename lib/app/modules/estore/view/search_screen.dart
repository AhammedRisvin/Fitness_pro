import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:olympic/app/modules/estore/view%20model/estore_provider.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
import 'cart_screen.dart';
import 'product_details_screen.dart';

class EstoreSearchScreen extends StatefulWidget {
  const EstoreSearchScreen({super.key});

  @override
  State<EstoreSearchScreen> createState() => _EstoreSearchScreenState();
}

class _EstoreSearchScreenState extends State<EstoreSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          children: [
            Selector<EstoreProvider, String>(
              selector: (context, provider) => provider.searchQuery,
              builder: (context, query, child) {
                return TextField(
                  controller: context.read<EstoreProvider>().serchingController,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onChanged: (query) {
                    context.read<EstoreProvider>().setSearchQuery(query);
                    context
                        .read<EstoreProvider>()
                        .eStoreSerchingFnc(query: query);
                  },

                  style: const TextStyle(
                    color: AppConstants.white,
                  ), // Customize text color
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: const TextStyle(
                      color: AppConstants.subTextGrey,
                    ), // Customize hint text color
                    prefixIcon: const Icon(
                      IconlyLight.search,
                      color: Colors.white,
                    ), // Customize prefix icon

                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppConstants.white,
                      ), // Customize border color
                      borderRadius: BorderRadius.circular(
                          10.0), // Customize border radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppConstants.appPrimaryColor,
                      ), // Customize focused border color
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ), // Customize border radius
                    ),
                  ),
                );
              },
            ),
            Consumer<EstoreProvider>(builder: (context, obj, _) {
              return obj.eStoreSerchingStatus == EStoreSerchingStatus.loading
                  ? const CircularLoader()
                  : context
                          .read<EstoreProvider>()
                          .serchingController
                          .text
                          .isEmpty
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: AppConstants.appPrimaryColor
                                      .withOpacity(0.2),
                                  child: const Icon(
                                    Icons.search,
                                    color: AppConstants.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              SizeBoxH(Responsive.height * 3),
                              const Center(
                                child: Text(
                                  "Search Your Keywords",
                                  style: TextStyle(
                                      color: AppConstants.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        )
                      : obj.serchingProductList.isEmpty &&
                              context
                                  .read<EstoreProvider>()
                                  .serchingController
                                  .text
                                  .isNotEmpty
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundColor: AppConstants
                                          .appPrimaryColor
                                          .withOpacity(0.2),
                                      child: const Icon(
                                        Icons.hourglass_empty,
                                        color: AppConstants.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  SizeBoxH(Responsive.height * 3),
                                  const Center(
                                    child: Text(
                                      "Products Not Found",
                                      style: TextStyle(
                                          color: AppConstants.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(15),
                              child: GridView.builder(
                                itemCount: obj.serchingProductList.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: Responsive.width * 4,
                                  mainAxisSpacing: Responsive.width * 4,
                                  childAspectRatio: .8,
                                ),
                                itemBuilder: (context, index) {
                                  final items = obj.serchingProductList[index];
                                  return CommonInkwell(
                                    onTap: () {
                                      context
                                          .read<EstoreProvider>()
                                          .changeIsCartedStatus();
                                      Routes.push(
                                          screen: const ProductDetailsScreen(
                                        isFromHome: false,
                                        isFromCart: false,
                                      ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: Responsive.height * 1),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppConstants.drawerBgColor,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Container(
                                          //   height: Responsive.height * 14.5,
                                          //   width: Responsive.width * 100,
                                          //   decoration: const BoxDecoration(
                                          //     borderRadius: BorderRadius.only(
                                          //       topLeft: Radius.circular(15),
                                          //       topRight: Radius.circular(15),
                                          //     ),
                                          //     image: DecorationImage(
                                          //       fit: BoxFit.fill,
                                          //       image: AssetImage("assets/images/shoeJpg.jpg"),
                                          //     ),
                                          //   ),
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(right: 8.0, top: 8),
                                          //     child: Row(
                                          //       mainAxisAlignment: MainAxisAlignment.end,
                                          //       crossAxisAlignment: CrossAxisAlignment.start,
                                          //       children: [
                                          //         CircleAvatar(
                                          //           backgroundColor: AppConstants.textFieldTextColor,
                                          //           radius: 18,
                                          //           child: isFromWishlist
                                          //               ? Image.asset(
                                          //                   AppImages.wishlistedHeart,
                                          //                   height: 16,
                                          //                 )
                                          //               : Image.asset(
                                          //                   AppImages.normalHeart,
                                          //                   height: 16,
                                          //                 ),
                                          //         )
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          estoreCommonNetworkImage(
                                            url: '${items.images?[0]}',
                                            height: Responsive.height * 14.5,
                                            width: Responsive.width * 100,
                                          ),
                                          SizeBoxH(Responsive.height * 0.2),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: Responsive.width * 2,
                                              // top: Responsive.height * 1,
                                            ),
                                            child: commonTextWidget(
                                              color: AppConstants.subTextGrey,
                                              text: '${items.brand}',
                                              fontSize: 14,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Responsive.width * 2),
                                            child: commonTextWidget(
                                              color: AppConstants.white,
                                              text: '${items.productName}',
                                              fontSize: 16,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Responsive.width * 2),
                                            child: commonTextWidget(
                                              color: AppConstants.white,
                                              text:
                                                  '${items.details?[0].price}',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
            }),
          ],
        ),
      ),
    );
  }
}
