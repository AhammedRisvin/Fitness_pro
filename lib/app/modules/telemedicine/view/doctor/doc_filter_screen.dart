import 'package:flutter/material.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../view_model/tele_medicine_provider.dart';
import '../../widgets/radio_list_tile_widget.dart';

class DocFilterScreen extends StatelessWidget {
  const DocFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          text: 'Sort & Filters',
          color: AppConstants.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {
            Routes.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppConstants.white,
            size: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Apply",
              style: TextStyle(
                color: AppConstants.appPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: Responsive.height * 100,
        color: AppConstants.black,
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizeBoxH(10),
              const Text(
                'Sort By',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizeBoxH(20),
              const Text(
                'Patient Recommendations',
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 18,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.09,
                ),
              ),
              const SizeBoxH(10),
              const Text(
                'Find the doctors, most recommended by verified Patients',
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 13,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.07,
                ),
              ),
              const SizeBoxH(20),
              const Text(
                'Earliest Available',
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 18,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.09,
                ),
              ),
              const SizeBoxH(10),
              const Text(
                'Find the doctors, most recommended by verified Patients',
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 13,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.07,
                ),
              ),
              const SizeBoxH(20),
              const Divider(
                color: Color(0xffEDEDED),
                thickness: 1.5,
              ),
              const SizeBoxH(20),
              const Text(
                'Filter By',
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 20,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: 0.10,
                ),
              ),
              const SizeBoxH(15),
              const Text(
                'Now or Later',
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 18,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.09,
                ),
              ),
              const SizeBoxH(10),
              const TeleMedicineRadioTileWidget(
                text: 'Anytime',
              ),
              const TeleMedicineRadioTileWidget(
                text: 'Next 2 Hours',
              ),
              const TeleMedicineRadioTileWidget(
                text: 'Today',
              ),
              const TeleMedicineRadioTileWidget(
                text: 'Tomorrow',
              ),
              const SizeBoxH(15),
              const Divider(
                color: Color(0xffEDEDED),
                thickness: 1.5,
              ),
              const SizeBoxH(15),
              const Text(
                'Gender',
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 20,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: 0.10,
                ),
              ),
              const SizeBoxH(15),
              const TeleMedicineRadioTileWidget(
                isMale: false,
                isGender: true,
                text: 'Female',
              ),
              const TeleMedicineRadioTileWidget(
                isMale: true,
                isGender: true,
                text: 'Male',
              ),
              const SizeBoxH(20),
              const Text(
                "Years of Experience",
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 20,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: 0.10,
                ),
              ),
              const SizeBoxH(10),
              Consumer<TelemedicineProvider>(
                builder: (context, value, child) => SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${context.read<TelemedicineProvider>().startExperience.toString()} Years - ${context.read<TelemedicineProvider>().endExperience.toString()} Years",
                        style: const TextStyle(
                          color: AppConstants.white,
                          fontSize: 16,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.08,
                        ),
                      ),
                      const SizeBoxH(20),
                      SizedBox(
                        width: Responsive.width * 100,
                        child: RangeSlider(
                          inactiveColor: const Color(0xFFD9D9D9),
                          activeColor: const Color(0xFFC1AE97),
                          labels: RangeLabels(value.startExperience.toString(),
                              value.endExperience.toString()),
                          values: RangeValues(
                              value.startExperience, value.endExperience),
                          min: 0,
                          max: 100,
                          onChanged: (RangeValues values) {
                            value.selectExperienceRange(values);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizeBoxH(20),
            ],
          ),
        ),
      ),
    );
  }
}
