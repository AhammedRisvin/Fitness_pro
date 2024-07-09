import 'package:flutter/material.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
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
            Routes.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppConstants.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
