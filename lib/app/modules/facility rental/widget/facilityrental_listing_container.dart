import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../model/get_all_facility_model.dart';
import '../model/get_booked_facility_model.dart';
import '../view model/facility_rental_provider.dart';

class FacilityRentalListingContainer extends StatelessWidget {
  final bool isFromBookings;
  final void Function() onTap;
  final SloteData? facilityData;
  final SlotesWithBooking? bookedFacilityData;
  final Booking? bookings;
  final FacilityRentalProvider? facilityRentalProvider;
  const FacilityRentalListingContainer({
    super.key,
    this.isFromBookings = false,
    required this.onTap,
    this.facilityData,
    this.bookedFacilityData,
    this.bookings,
    this.facilityRentalProvider,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        height: Responsive.height * 16,
        width: Responsive.width * 100,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppConstants.drawerBgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              commonNetworkImage(
                height: Responsive.height * 13,
                width: Responsive.width * 26,
                url: isFromBookings
                    ? bookedFacilityData?.image?.url ?? ""
                    : facilityData?.image?.url ?? "",
              ),
              SizeBoxV(Responsive.width * 4),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonTextWidget(
                      align: TextAlign.start,
                      maxLines: 2,
                      overFlow: TextOverflow.ellipsis,
                      color: AppConstants.white,
                      text: isFromBookings
                          ? bookedFacilityData?.facility ?? "Facility name"
                          : facilityData?.name ?? "Facility name",
                      fontSize: Responsive.height * 2.5,
                      fontWeight: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonTextWidget(
                          color: isFromBookings
                              ? AppConstants.subTextGrey
                              : AppConstants.white,
                          text: isFromBookings
                              ? "ID : ${bookings?.id?.substring(17).toUpperCase()}"
                              : facilityData?.branch?.branchName ?? '',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        isFromBookings
                            ? commonTextWidget(
                                color: isFromBookings
                                    ? AppConstants.subTextGrey
                                    : AppConstants.white,
                                text: isFromBookings
                                    ? bookings?.bookingStatus ?? ""
                                    : "",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonTextWidget(
                          color: AppConstants.white,
                          text: isFromBookings
                              ? "${bookedFacilityData?.sloteFees?.currency} ${bookedFacilityData?.sloteFees?.amount} "
                              : "${facilityData?.slotes?.isNotEmpty == true ? facilityData?.slotes?.first.fees?.amount : 0.00} ${facilityData?.slotes?.isNotEmpty == true ? facilityData?.slotes?.first.fees?.currency : ""}",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        isFromBookings
                            ? commonTextWidget(
                                color: AppConstants.subTextGrey,
                                text:
                                    " ${facilityRentalProvider?.formatTime(bookings?.dateForSlot.toString() ?? "") ?? ''} ${facilityRentalProvider?.convertUtcToLocalTime(bookedFacilityData?.sloteTime?.startTime ?? '')} ",
                                // text: DateFormat("MMM-d-yy").format(
                                //     bookings?.dateForSlot ?? DateTime.now()),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
