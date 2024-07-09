import 'package:flutter/material.dart';
import 'package:olympic/app/modules/auth/view/facility_rental_login_screen.dart';
import 'package:olympic/app/modules/auth/view/login_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_images.dart';
import '../../home/view model/home_provider.dart';
import '../widget/login_choosing_container.dart';

class LoginChoosingScreen extends StatefulWidget {
  const LoginChoosingScreen({super.key});

  @override
  State<LoginChoosingScreen> createState() => _LoginChoosingScreenState();
}

class _LoginChoosingScreenState extends State<LoginChoosingScreen> {
  HomeProvider? homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = context.read<HomeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151515),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.olympicCombatAuthBgGif,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.onboardingLogo,
                      height: 70,
                      width: 70,
                    ),
                    const commonTextWidget(
                      text: "OLYMPIC COMBAT",
                      color: AppConstants.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonInkwell(
                        onTap: () {
                          showModalBottomSheet(
                            enableDrag: false,
                            isDismissible: false,
                            backgroundColor: AppConstants.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return const LoginScreen();
                            },
                          );
                        },
                        child: LoginMethodChoosingContainer(
                          title: "Member\nLogin",
                          icon: AppImages.loginUserIcon,
                          bgColor: AppConstants.appPrimaryColor,
                          borderColor: Colors.transparent,
                          titleColor: AppConstants.black,
                        ),
                      ),
                      CommonInkwell(
                        onTap: () {
                          showModalBottomSheet(
                              enableDrag: false,
                              isDismissible: false,
                              backgroundColor: AppConstants.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return const FacilityRentalLoginScreen();
                              });
                        },
                        child: LoginMethodChoosingContainer(
                          title: "Rental\nFacility",
                          icon: AppImages.facilityRentIcon,
                          bgColor: Colors.black,
                          borderColor: AppConstants.appPrimaryColor,
                          titleColor: AppConstants.appPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.height * 2),
                  CommonButton(
                    width: Responsive.width * 100,
                    height: Responsive.height * 6.5,
                    onTap: () {
                      homeProvider?.launchUrl(
                          "https://www.olympiccombat.io/book-free-trial/client-info");
                    },
                    text: "BOOK FREE TRIAL",
                    bgColor: AppConstants.drawerBgColor,
                    textColor: AppConstants.white,
                  ),
                  SizedBox(height: Responsive.height * 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
