import 'package:flutter/material.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';

class OnBoardingProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<Widget> buildIndicators(int length, int currentIndex) {
    List<Widget> indicators = [];
    for (int i = 0; i < length; i++) {
      indicators.add(
        Container(
          width: currentIndex == i ? 30.0 : 5.0,
          height: 5.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: currentIndex == i
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppConstants.appPrimaryColor)
              : const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConstants.subTextGrey,
                ),
        ),
      );
    }
    return indicators;
  }

  List<OnboardingScreen> screens = [
    OnboardingScreen(
      imagePath: AppImages.onboard01,
      text: 'FOCUS',
      subtext: 'Where focus meets power',
    ),
    OnboardingScreen(
      imagePath: AppImages.onboard02,
      text: 'OLYMPIC CHARACTER',
      subtext: 'Train like an olympian',
    ),
    OnboardingScreen(
      imagePath: AppImages.onboard03,
      text: 'CONFIDENCE',
      subtext: 'Unleash your inner warrior',
    ),
    OnboardingScreen(
      imagePath: AppImages.onboard04,
      text: 'UNITY',
      subtext: 'Train together,triumph together',
    ),
    OnboardingScreen(
      imagePath: AppImages.onboard05,
      text: 'SOCIAL BEHAVIOR',
      subtext: 'Learn the power off respect',
    ),
  ];
}

class OnboardingScreen {
  final String imagePath;
  final String text;
  final String subtext;

  OnboardingScreen({
    required this.imagePath,
    required this.text,
    required this.subtext,
  });
}
