import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/pharmacy/widgets/subcatgegoryWidgets.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../widgets/productcard.dart';
import '../view_model/pharmacy_provider.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonTextWidget(
              color: AppConstants.white,
              text: "Medicines",
              fontSize: 18,
            ),
            Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: AppConstants.white,
                ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 1),
            SizedBox(
              height: Responsive.height * 5,
              child: Consumer<PharmacyProvider>(builder: (context, obj, _) {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CommonInkwell(
                        onTap: () {
                          obj.currentIndexFnc(index: index);
                        },
                        child: SubCategoryWidget(
                          index: index,
                          text: 'aaaaaaaaaaaaaa',
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizeBoxV(Responsive.width * 2),
                    itemCount: 4);
              }),
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
                return const CardContainer();
              },
            )
          ],
        ),
      ),
    );
  }
}
