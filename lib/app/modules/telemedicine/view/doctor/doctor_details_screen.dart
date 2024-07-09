import 'package:flutter/material.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/extensions.dart';
import '../../widgets/doct_widget_without_img.dart';
import '../../widgets/select_slot_bottom_sheet.dart';
import '../booking/add_details.dart';

class DocDetailsScreen extends StatelessWidget {
  const DocDetailsScreen({super.key});

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
                        text: "Doctor detials",
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
                        text: 'About doctor',
                        color: AppConstants.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      SizeBoxH(Responsive.height * 2),
                      Container(
                        decoration: BoxDecoration(
                            color: AppConstants.teleContainerBg,
                            borderRadius: BorderRadius.circular(20)),
                        width: Responsive.width * 100,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: commonTextWidget(
                            text:
                                'Lorem ipsum dolor sit amet consectetur. Odio sit quis vulputate sagittis sit eu mattis vitae rhoncus. Id morbi posuere lacus nam egestas. Eu tellus dui eu enim euismod augue pellentesque nulla. Quis ornare ac volutpat scelerisque.',
                            color: AppConstants.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            align: TextAlign.justify,
                          ),
                        ),
                      ),
                      SizeBoxH(Responsive.height * 2),
                      const commonTextWidget(
                        text: 'Today 13, December 2003',
                        color: AppConstants.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 40,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                      color: AppConstants.teleContainerBg,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 40,
                                  width: 78,
                                  child: const Center(
                                    child: commonTextWidget(
                                      text: '09:20 PM',
                                      color: AppConstants.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizeBoxV(10),
                            itemCount: 3),
                      ),
                      TextButton(
                        onPressed: () {
                          selectYourSlotBottomSheet(
                            context,
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            commonTextWidget(
                              text: 'View more Available Slots',
                              color: AppConstants.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            SizeBoxV(10),
                            Icon(
                              Icons.arrow_forward,
                              color: AppConstants.white,
                            ),
                          ],
                        ),
                      ),
                      SizeBoxH(Responsive.height * 4),
                      BookNowWidget(
                        onTap: () {
                          Routes.push(screen: const AddDetailsScreen());
                        },
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

class BookNowWidget extends StatelessWidget {
  final void Function() onTap;
  const BookNowWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      height: 73,
      color: AppConstants.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.width * 46,
              height: 75,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 135,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "AED 100",
                            style: TextStyle(
                              color: AppConstants.appPrimaryColor,
                              fontSize: 14,
                              fontFamily: 'Roboto Flex',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                          TextSpan(
                            text: '${"  Consultation"} ${"Fees"}',
                            style: TextStyle(
                              color: AppConstants.white,
                              fontSize: 14,
                              fontFamily: 'Roboto Flex',
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizeBoxH(5),
                  Row(
                    children: [
                      Icon(
                        Icons.videocam_rounded,
                        color: AppConstants.white,
                      ),
                      SizeBoxV(5),
                      Text(
                        'Video',
                        style: TextStyle(
                          color: AppConstants.white,
                          fontSize: 12,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: -0.30,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: CommonButton(
                  onTap: onTap,
                  text: 'Book Now',
                  width: Responsive.width * 38,
                  height: 50),
            )
          ],
        ),
      ),
    );
  }
}
