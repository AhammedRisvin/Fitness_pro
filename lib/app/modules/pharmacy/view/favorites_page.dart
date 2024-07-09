import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../widgets/favandcartcard.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        centerTitle: true,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "Favorites",
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
            separatorBuilder: (context, index) =>
                SizeBoxH(Responsive.height * 2),
            itemCount: 5,
            itemBuilder: (context, index) => const FavAndCartWidgets()),
      ),
    );
  }
}
