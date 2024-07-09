import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../view model/facility_rental_provider.dart';

// ignore: use_key_in_widget_constructors
class FacilityRentalBottomNav extends StatefulWidget {
  @override
  State<FacilityRentalBottomNav> createState() =>
      _FacilityRentalBottomNavState();
}

class _FacilityRentalBottomNavState extends State<FacilityRentalBottomNav> {
  FacilityRentalProvider? facilityRentalProvider;

  @override
  void initState() {
    super.initState();
    facilityRentalProvider = context.read<FacilityRentalProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: Stack(
        children: [
          Center(
            child: Selector<FacilityRentalProvider, Widget>(
              selector: (context, model) =>
                  model.screens.elementAt(model.selectedIndex),
              builder: (context, screen, child) {
                return screen;
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Selector<FacilityRentalProvider, int>(
              selector: (context, model) => model.selectedIndex,
              builder: (context, selectedIndex, child) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppConstants.drawerBgColor,
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: Responsive.width * 4.5, vertical: 30),
                  padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width * 4, vertical: 8),
                  child: GNav(
                    rippleColor: AppConstants.appPrimaryColor,
                    hoverColor: AppConstants.appPrimaryColor,
                    gap: 8,
                    activeColor: AppConstants.black,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width * 12,
                      vertical: Responsive.height * 2,
                    ),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: AppConstants.appPrimaryColor,
                    color: AppConstants.white,
                    tabs: [
                      GButton(
                        icon: selectedIndex == 0
                            ? IconlyBold.home
                            : IconlyLight.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: selectedIndex == 1
                            ? IconlyBold.bag
                            : IconlyLight.bag,
                        text: 'Bookings',
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onTabChange: (index) {
                      Provider.of<FacilityRentalProvider>(context,
                              listen: false)
                          .setSelectedIndex(index);
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
