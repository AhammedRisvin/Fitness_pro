import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/pharmacy/view/cart_page.dart';
import 'package:olympic/app/modules/pharmacy/view/favorites_page.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../estore/view model/estore_provider.dart';
import '../widgets/productCard.dart';
import 'medicines/medicine_page.dart';
import 'product_detail.dart';

class PharmacyScren extends StatelessWidget {
  const PharmacyScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const commonTextWidget(
              color: AppConstants.white,
              text: "My Bookings",
              fontSize: 18,
            ),
            Row(
              children: [
                CommonInkwell(
                  onTap: () {
                    Routes.push(screen: const FavoritesScreen());
                  },
                  child: const Icon(
                    Icons.favorite_border,
                    color: AppConstants.white,
                  ),
                ),
                SizeBoxV(Responsive.width * 2),
                CommonInkwell(
                  onTap: () {
                    Routes.push(screen: const CartScreen());
                  },
                  child: const Icon(
                    Icons.local_mall_outlined,
                    color: AppConstants.white,
                  ),
                )
              ],
            )
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeBoxH(Responsive.height * 1),
            TextField(
              controller: context.read<EstoreProvider>().serchingController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onChanged: (query) {
                context.read<EstoreProvider>().setSearchQuery(query);
                context.read<EstoreProvider>().eStoreSerchingFnc(query: query);
              },

              style: const TextStyle(
                color: AppConstants.white,
              ), // Customize text color
              decoration: InputDecoration(
                filled: true, //<-- SEE HERE
                fillColor: AppConstants.searchColor, //<-
                hintText: 'Search...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintStyle: const TextStyle(
                  color: AppConstants.white,
                ), // Customize hint text color
                prefixIcon: const Icon(
                  IconlyLight.search,
                  color: Colors.white,
                ), // Customize prefix icon

                suffixIcon: const Icon(Icons.mic_none_outlined,
                    color: AppConstants.white),

                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppConstants.searchColor,
                  ), // Customize border color
                  borderRadius:
                      BorderRadius.circular(10.0), // Customize border radius
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
            ),
            SizeBoxH(Responsive.height * 3),
            const commonTextWidget(
              color: AppConstants.white,
              text: 'Popular Categories',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SizeBoxH(Responsive.height * 3),
            SizedBox(
              height: Responsive.height * 13,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CommonInkwell(
                      onTap: () {
                        Routes.push(screen: const MedicineScreen());
                      },
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            child: commonNetworkImage(
                                url: '', height: 70, width: 70),
                          ),
                          SizeBoxH(Responsive.height * 1),
                          const commonTextWidget(
                            color: AppConstants.white,
                            text: 'Medicines',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizeBoxV(Responsive.width * 3),
                  itemCount: 4),
            ),
            SizeBoxH(Responsive.height * 3),
            const commonTextWidget(
              color: AppConstants.white,
              text: 'Popular Categories',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SizeBoxH(Responsive.height * 3),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 4.6,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return CommonInkwell(
                    onTap: () {
                      Routes.push(screen: const PrdoductDetailsScreen());
                    },
                    child: const CardContainer());
              },
            )
          ],
        ),
      ),
    );
  }
}
