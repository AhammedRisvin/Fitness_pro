import 'package:flutter/material.dart';
import 'package:olympic/app/core/string_const.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/enums.dart';
import '../../../utils/shimmers.dart';
import '../view model/facility_rental_provider.dart';
import '../widget/facilityrental_listing_container.dart';
import 'facility_details_screen.dart';

class FacilityRentalHomeScreen extends StatefulWidget {
  const FacilityRentalHomeScreen({super.key});

  @override
  State<FacilityRentalHomeScreen> createState() =>
      _FacilityRentalHomeScreenState();
}

class _FacilityRentalHomeScreenState extends State<FacilityRentalHomeScreen> {
  FacilityRentalProvider? facilityRentalProvider;
  @override
  void initState() {
    super.initState();
    facilityRentalProvider = context.read<FacilityRentalProvider>();
    facilityRentalProvider?.getFacilityListFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
          backgroundColor: AppConstants.black,
          title: const commonTextWidget(
            color: AppConstants.white,
            text: "FACILITY RENTAL",
            fontSize: 18,
          ),
          centerTitle: true,
          leading: const SizedBox.shrink(),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: Container(
                        height: Responsive.height * 30,
                        width: Responsive.width * 90,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppConstants.black,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppConstants.drawerBgColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const commonTextWidget(
                              text: "LOGOUT",
                              color: AppConstants.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                            const commonTextWidget(
                              text: "Are you sure you want to logout ?",
                              color: AppConstants.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              align: TextAlign.center,
                              letterSpacing: 1.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AlertDialogButtonWidget(
                                  onTap: () {
                                    Routes.back();
                                  },
                                  text: "No",
                                  buttonBgColor: AppConstants.black,
                                  buttonBorderColor:
                                      AppConstants.appPrimaryColor,
                                  textColor: AppConstants.appPrimaryColor,
                                ),
                                AlertDialogButtonWidget(
                                  onTap: () {
                                    StringConst.logout();
                                  },
                                  text: "Yes",
                                  buttonBgColor: AppConstants.appPrimaryColor,
                                  buttonBorderColor: AppConstants.black,
                                  textColor: AppConstants.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.logout,
                color: AppConstants.white,
                size: 20,
              ),
            ),
            const SizeBoxV(8)
          ]),
      body: Consumer<FacilityRentalProvider>(builder: (context, value, child) {
        return Container(
          height: Responsive.height * 100,
          width: Responsive.width * 100,
          padding: const EdgeInsets.all(15),
          child: value.getAllFacilityStatus == GetAllFacilityStatus.loading
              ? const Column(
                  children: [
                    FacilityRentalShimmerContainer(),
                  ],
                )
              : value.getAllFacilityStatus == GetAllFacilityStatus.loaded
                  ? value.facilityDataList.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor:
                                  AppConstants.appPrimaryColor.withOpacity(0.2),
                              child: const Icon(
                                Icons.apartment,
                                color: AppConstants.white,
                                size: 30,
                              ),
                            ),
                            SizeBoxH(Responsive.height * 3),
                            const Center(
                              child: Text(
                                "No items in Rentals",
                                style: TextStyle(
                                    color: AppConstants.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      : FutureBuilder(
                          future: facilityRentalProvider?.getFacilityListFn(),
                          builder: (context, snapshot) {
                            return ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final data = snapshot.data?.sloteDatas?[
                                    (snapshot.data?.sloteDatas?.length ?? 0) -
                                        1 -
                                        index];

                                return FacilityRentalListingContainer(
                                  facilityData: data,
                                  onTap: () {
                                    facilityRentalProvider?.today =
                                        facilityRentalProvider!
                                            .formatDateTimeToString(
                                                DateTime.now());
                                    facilityRentalProvider
                                        ?.getSingleFacility(data);
                                    facilityRentalProvider?.facilityGetSlotFn();

                                    Routes.push(
                                      screen: const FacilityDetailsScreen(),
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizeBoxH(Responsive.height * 2);
                              },
                              itemCount: snapshot.data?.sloteDatas?.length ?? 0,
                            );
                          },
                        )
                  : const SizedBox.shrink(),
        );
      }),
    );
  }
}

class AlertDialogButtonWidget extends StatelessWidget {
  final void Function() onTap;
  final Color buttonBgColor;
  final Color buttonBorderColor;
  final Color textColor;
  final String text;
  const AlertDialogButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonBgColor,
    required this.buttonBorderColor,
    required this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        height: Responsive.height * 6,
        width: Responsive.width * 30,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: buttonBgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: buttonBorderColor,
            width: 1,
          ),
        ),
        child: Center(
          child: commonTextWidget(
            color: textColor,
            text: text,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
