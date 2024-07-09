import 'package:flutter/material.dart';
import 'package:olympic/app/utils/enums.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/shimmers.dart';
import '../view model/facility_rental_provider.dart';
import '../widget/facilityrental_listing_container.dart';

class FacilityRentalBookingsScreen extends StatefulWidget {
  const FacilityRentalBookingsScreen({super.key});

  @override
  State<FacilityRentalBookingsScreen> createState() =>
      _FacilityRentalBookingsScreenState();
}

class _FacilityRentalBookingsScreenState
    extends State<FacilityRentalBookingsScreen> {
  FacilityRentalProvider? facilityRentalProvider;

  @override
  void initState() {
    super.initState();
    facilityRentalProvider = context.read<FacilityRentalProvider>();
    facilityRentalProvider?.getBookedFacilityListFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppConstants.black,
        title: const Text(
          "BOOKINGS",
          style: TextStyle(
            color: AppConstants.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<FacilityRentalProvider>(
        builder: (context, value, child) {
          return Container(
              height: Responsive.height * 100,
              width: Responsive.width * 100,
              padding: const EdgeInsets.all(15),
              child: value.getAllBookedFacilityStatus ==
                      GetAllBookedFacilityStatus.loading
                  ? const Column(
                      children: [
                        FacilityRentalShimmerContainer(),
                      ],
                    )
                  : value.getAllBookedFacilityStatus ==
                          GetAllBookedFacilityStatus.loaded
                      ? value.bookedFacilityList.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: AppConstants.appPrimaryColor
                                      .withOpacity(0.2),
                                  child: const Icon(
                                    Icons.apartment,
                                    color: AppConstants.white,
                                    size: 30,
                                  ),
                                ),
                                SizeBoxH(Responsive.height * 3),
                                const Center(
                                  child: Text(
                                    "No items in Bookings",
                                    style: TextStyle(
                                        color: AppConstants.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )
                          : FutureBuilder(
                              future: facilityRentalProvider
                                  ?.getBookedFacilityListFn(),
                              builder: (context, snapshot) {
                                return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizeBoxH(10),
                                  itemBuilder: (context, index) {
                                    final data = snapshot
                                        .data?.slotesWithBookings?[index];

                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const SizeBoxH(10),
                                      itemCount: data?.bookings?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final bookings = data?.bookings?[index];
                                        return FacilityRentalListingContainer(
                                          bookedFacilityData: data,
                                          facilityRentalProvider:
                                              facilityRentalProvider,
                                          bookings: bookings,
                                          isFromBookings: true,
                                          onTap: () {},
                                        );
                                      },
                                    );
                                  },
                                  itemCount: snapshot
                                          .data?.slotesWithBookings?.length ??
                                      0,
                                );
                              },
                            )
                      : const SizedBox.shrink());
        },
      ),
    );
  }
}
