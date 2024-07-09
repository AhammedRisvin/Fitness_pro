import 'package:flutter/material.dart';
import 'package:olympic/app/modules/telemedicine/view_model/tele_medicine_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/extensions.dart';
import '../../widgets/doct_widget_without_img.dart';
import 'select_payment.dart';

class AddDetailsScreen extends StatelessWidget {
  const AddDetailsScreen({super.key});

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
                      const commonTextWidget(
                        text: 'Write your issue',
                        color: AppConstants.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      SizeBoxH(Responsive.height * 2),
                      Container(
                        decoration: BoxDecoration(
                            color: AppConstants.teleContainerBg,
                            borderRadius: BorderRadius.circular(10)),
                        width: Responsive.width * 100,
                        child: CommonTextFormField(
                            bgColor: AppConstants.teleContainerBg,
                            hintText: "Write here...",
                            maxLines: 7,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.none,
                            controller: TextEditingController()),
                      ),
                      SizeBoxH(Responsive.height * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AddPriscriptionWidget(
                            onTap: () {
                              context
                                  .read<TelemedicineProvider>()
                                  .addPatientPrescription(true);
                            },
                            icon: AppImages.teleUploadImage,
                            platForm: 'Upload image',
                          ),
                          const SizeBoxV(30),
                          AddPriscriptionWidget(
                            onTap: () {
                              context
                                  .read<TelemedicineProvider>()
                                  .addPatientPrescription(false);
                            },
                            icon: AppImages.openCamera,
                            platForm: 'Open camera',
                          ),
                        ],
                      ),
                      SizeBoxH(Responsive.height * 3),
                      CommonButton(
                          onTap: () {
                            Routes.push(screen: const BookingPaymentScreen());
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

class AddPriscriptionWidget extends StatelessWidget {
  final String platForm;
  final String icon;

  final void Function()? onTap;
  const AddPriscriptionWidget(
      {super.key,
      required this.platForm,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: ShapeDecoration(
          color: AppConstants.teleContainerBg,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFECE9E9)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: context.read<TelemedicineProvider>().thumbnailImage != null
            ? Image.file(
                context.read<TelemedicineProvider>().thumbnailImage!,
                fit: BoxFit.cover,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    height: 26,
                    width: 31,
                    fit: BoxFit.fill,
                  ),
                  const SizeBoxH(10),
                  Text(
                    platForm,
                    style: const TextStyle(
                      color: AppConstants.white,
                      fontSize: 13,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
