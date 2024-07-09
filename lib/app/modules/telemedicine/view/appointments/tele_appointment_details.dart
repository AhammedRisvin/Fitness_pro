import 'package:flutter/material.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/extensions.dart';
import '../../widgets/doct_widget_without_img.dart';
import '../../widgets/key_value_row_widget.dart';
import 'add_rate_screen.dart';

class TeleAppointmentDetailsScreen extends StatelessWidget {
  const TeleAppointmentDetailsScreen({super.key});

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
                padding: const EdgeInsets.only(top: 25.0, left: 15),
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
                            size: 20,
                            color: AppConstants.white,
                          ),
                        ),
                      ),
                    ),
                    const SizeBoxV(10),
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0, left: 100),
                      child: commonTextWidget(
                        text: "Booking detials",
                        color: AppConstants.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
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
                      SizeBoxH(Responsive.height * 1),
                      const KeyValueRowWidget(
                        keyValue: 'Booking ID',
                        value: '#12345678',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const KeyValueRowWidget(
                        keyValue: 'Amount',
                        value: 'AED 100',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const Divider(
                        thickness: 1,
                        color: AppConstants.teleContainerBg,
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const KeyValueRowWidget(
                        keyValue: 'Patient Info',
                        value: 'Saheer',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const KeyValueRowWidget(
                        keyValue: 'Gender',
                        value: 'Male',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const KeyValueRowWidget(
                        keyValue: 'Age',
                        value: '10',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const commonTextWidget(
                        text: "Problem",
                        color: AppConstants.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const commonTextWidget(
                        align: TextAlign.justify,
                        text:
                            "ajfgdsggjgh;jgh;adshblfdbhjadflkhbldfknbnldaknbnldnfnldaalj.hbjjdfkhbjfdbhdfkmbcx,m kfkjglsdkg;lsdvlmscv,cmlsdkfkdslfpdsog;dslgds;flspdl",
                        color: AppConstants.white,
                        overFlow: TextOverflow.clip,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      SizeBoxH(Responsive.height * 1),
                      Padding(
                        padding: EdgeInsets.only(left: Responsive.width * 10.0),
                        child: CommonButton(
                            onTap: () {
                              Routes.push(screen: const TeleAddRateScreen());
                            },
                            text: 'Rate your experience',
                            width: Responsive.width * 75,
                            radius: 10,
                            size: 14,
                            height: 40),
                      ),
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
