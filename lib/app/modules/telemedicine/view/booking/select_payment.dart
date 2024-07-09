import 'package:flutter/material.dart';
import 'package:olympic/app/modules/telemedicine/view/appointments/tele_appointment_screen.dart';
import 'package:olympic/app/utils/app_images.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/extensions.dart';
import '../../widgets/doct_widget_without_img.dart';
import '../../widgets/key_value_row_widget.dart';
import '../../widgets/payment_method_widget.dart';

class BookingPaymentScreen extends StatelessWidget {
  const BookingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Stack(
          children: [
            Container(
              height: Responsive.height * 45,
              width: Responsive.width * 100,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      onError: (exception, stackTrace) => const SizedBox(
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey,
                          )),
                      fit: BoxFit.cover,
                      image: const NetworkImage(
                          'https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg'))),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Routes.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 15,
                            color: AppConstants.white,
                          ),
                        ),
                      ),
                    ),
                    const SizeBoxV(10),
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0, left: 100),
                      child: commonTextWidget(
                        text: "Booking",
                        color: AppConstants.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                height: Responsive.height * 60,
                width: Responsive.width * 100,
                decoration: const BoxDecoration(
                  color: AppConstants.black,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(30),
                    topStart: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DoctorWidgetWithoutImage(),
                      // SizeBoxH(Responsive.height * 2),
                      const KeyValueRowWidget(
                        keyValue: 'Date & Hour',
                        value: 'Aug 24, 2023 10:00 AM',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const KeyValueRowWidget(
                        keyValue: 'Duration ',
                        value: '30 mins',
                      ),

                      SizeBoxH(Responsive.height * 4),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonTextWidget(
                            text: 'Payment method ',
                            color: AppConstants.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          commonTextWidget(
                            text: 'AED 100',
                            color: AppConstants.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizeBoxH(Responsive.height * 3),
                      PaymentMethodWidget(
                        img: AppImages.profilePic,
                        paymentName: 'Stripe',
                      ),

                      SizeBoxH(Responsive.height * 1),
                      PaymentMethodWidget(
                        img: AppImages.facebook,
                        paymentName: 'Paypal',
                      ),
                      SizeBoxH(Responsive.height * 5),
                      CommonButton(
                          onTap: () {
                            Routes.push(screen: const TeleAppointmentScreen());
                          },
                          text: 'Next',
                          width: Responsive.width * 90,
                          height: 50),
                      SizeBoxH(Responsive.height * 3),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
