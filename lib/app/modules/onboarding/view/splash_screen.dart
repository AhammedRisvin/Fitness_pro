import 'package:flutter/material.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../core/string_const.dart';
import '../../home/view model/home_provider.dart';
import '../../pharmacy/view/pharmacy_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
    Provider.of<HomeProvider>(context, listen: false).initializeVideoPlayer(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
  }

  Future<void> initialize() async {
    String userToken = await StringConst.getUserToken();
    String isFromMemberLogin = await StringConst.getIsFromMemberLogin();

    Future.delayed(
      const Duration(milliseconds: 4800),
      () {
        if (isFromMemberLogin.toLowerCase() == "false" &&
            userToken.isNotEmpty) {
          // Routes.pushRemoveUntil(screen: FacilityRentalBottomNav());
          Routes.pushRemoveUntil(screen: const PharmacyScren());
        } else if (isFromMemberLogin.toLowerCase() == "true" &&
            userToken.isNotEmpty) {
          // Routes.pushRemoveUntil(screen: const HomeScreen());
          Routes.pushRemoveUntil(screen: const PharmacyScren());
        } else {
          // Routes.pushRemoveUntil(screen: const OnboardingScreen());
          Routes.pushRemoveUntil(screen: const PharmacyScren());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Image.asset(
          "assets/images/splashScreenGif.gif",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
