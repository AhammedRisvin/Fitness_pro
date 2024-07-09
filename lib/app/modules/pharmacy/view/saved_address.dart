import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../widgets/saved_address_widgets.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        centerTitle: true,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: 'Address',
          fontSize: 18,
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
            const commonTextWidget(
              color: AppConstants.white,
              text: 'Saved Address',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SizeBoxH(Responsive.height * 2),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const SavaedAddressWidgets();
                },
                separatorBuilder: (context, index) =>
                    SizeBoxH(Responsive.height * 5),
                itemCount: 3),
            SizeBoxH(Responsive.height * 2),
            const SavedAddressButton()
          ],
        ),
      ),
    );
  }
}
