import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:olympic/app/modules/estore/view/cart_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../view model/estore_provider.dart';

// ignore: use_key_in_widget_constructors
class EstoreBottomNav extends StatefulWidget {
  @override
  State<EstoreBottomNav> createState() => _EstoreBottomNavState();
}

class _EstoreBottomNavState extends State<EstoreBottomNav> {
  EstoreProvider? eStoreProvider;

  @override
  void initState() {
    super.initState();
    eStoreProvider = context.read<EstoreProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.black,
      body: Stack(
        children: [
          Center(
            child: Selector<EstoreProvider, Widget>(
              selector: (context, model) =>
                  model.screens.elementAt(model.selectedIndex),
              builder: (context, screen, child) {
                return screen;
              },
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Selector<EstoreProvider, int>(
                selector: (context, model) => model.selectedIndex,
                builder: (context, selectedIndex, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppConstants.drawerBgColor,
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: Responsive.width * 5,
                        vertical: Responsive.height * 3),
                    padding: EdgeInsets.symmetric(
                        horizontal: Responsive.width * 4,
                        vertical: Responsive.height * 1),
                    child: GNav(
                      rippleColor: AppConstants.appPrimaryColor,
                      hoverColor: AppConstants.appPrimaryColor,
                      gap: 5,
                      activeColor: AppConstants.black,
                      iconSize: 20,
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width * 5,
                          vertical: Responsive.height * 1.5),
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
                              ? IconlyBold.search
                              : IconlyLight.search,
                          text: 'Search',
                        ),
                        GButton(
                          icon: selectedIndex == 2
                              ? IconlyBold.heart
                              : IconlyLight.heart,
                          text: 'Wishlist',
                        ),
                        GButton(
                          icon: selectedIndex == 3
                              ? IconlyBold.bag
                              : IconlyLight.bag,
                          text: 'Cart',
                        ),
                      ],
                      selectedIndex: selectedIndex,
                      onTabChange: (index) {
                        context
                            .read<EstoreProvider>()
                            .serchingProductList
                            .clear();
                        if (index == 3) {
                          Routes.push(screen: const EstoreCartScreen());

                          Provider.of<EstoreProvider>(context, listen: false)
                              .setSelectedIndex(index);
                        } else {
                          Provider.of<EstoreProvider>(context, listen: false)
                              .setSelectedIndex(index);
                        }
                      },
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
