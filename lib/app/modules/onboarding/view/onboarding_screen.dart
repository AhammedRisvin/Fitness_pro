import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/auth/view/login_choosing_screen.dart';
import 'package:olympic/app/modules/onboarding/view%20model/onboarding_provider.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => OnBoardingProvider(),
        child: const OnboardingPage(),
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnBoardingProvider>(context);
    final screens = provider.screens;
    final isLastScreen = provider.currentIndex == screens.length - 1;
    final currentScreen = screens[provider.currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xff151515),
      body: Stack(
        children: [
          PageView.builder(
            itemCount: screens.length,
            controller: controller,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(screens[index].imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            onPageChanged: (index) {
              this.index = index;
              provider.setCurrentIndex(index);
            },
          ),
          // Positioned(
          //   top: 40.0,
          //   right: 15.0,
          //   child: TextButton(
          //     onPressed: () => throw Exception(),
          //     child: const Text("Throw Test Exception"),
          //   ),
          // ),
          if (!isLastScreen)
            Positioned(
              top: 40.0,
              right: 15.0,
              child: TextButton(
                onPressed: () {
                  Routes.push(screen: const LoginChoosingScreen());
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: AppConstants.white,
                    fontSize: 18.0,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              ),
            ),
          Positioned(
            left: 30,
            top: 38,
            child: SizedBox(
              height: 50,
              width: 300,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.onboardingLogo,
                    height: 50,
                    width: 50,
                  ),
                  const SizeBoxV(20),
                  Text(
                    "Olympic Combat",
                    style: TextStyle(
                      color: AppConstants.white,
                      fontSize: 18,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 65.0,
            left: 30.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: currentScreen.text.substring(0, 1),
                        style: TextStyle(
                          color: AppConstants.appPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                      TextSpan(
                        text: currentScreen.text.substring(1),
                        style: TextStyle(
                          color: AppConstants.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizeBoxH(10),
                Text(
                  currentScreen.subtext,
                  style: const TextStyle(
                    color: AppConstants.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40.0,
            left: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: provider.buildIndicators(
                  screens.length, provider.currentIndex),
            ),
          ),
          Positioned(
            bottom: 60.0,
            right: 30.0,
            child: CommonInkwell(
              onTap: () {
                if (index < 4) {
                  controller.animateToPage(index + 1,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                } else {
                  Routes.push(screen: const LoginChoosingScreen());
                }
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
