import 'package:flutter/material.dart';
import 'package:olympic/app/modules/telemedicine/view_model/tele_medicine_provider.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';

class TeleMedicineRadioTileWidget extends StatelessWidget {
  final bool isGender;
  final bool isMale;

  final String text;
  const TeleMedicineRadioTileWidget(
      {super.key,
      required this.text,
      this.isGender = false,
      this.isMale = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<TelemedicineProvider>(
        // selector: (p0, p1) => p1.selectedFilter,
        builder: (context, value, child) {
      return CommonInkwell(
        onTap: () {
          if (isGender == false) {
            //  controller.selectTimeForSort(value!.toLowerCase());
          } else {}
        },
        child: SizedBox(
          // height: 35,
          child: Column(
            children: [
              isGender == false
                  ? RadioListTile(
                      activeColor: AppConstants.appPrimaryColor,
                      controlAffinity: ListTileControlAffinity.trailing,
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      title: Text(
                        text,
                        style: const TextStyle(
                          color: AppConstants.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.09,
                        ),
                      ),
                      value: text.toLowerCase(),
                      groupValue: value.selectedFilter,
                      onChanged: (value) {
                        context
                            .read<TelemedicineProvider>()
                            .selectTimeForSort(value!.toLowerCase());
                      },
                    )
                  : CheckboxListTile(
                      activeColor: AppConstants.transparent,
                      controlAffinity: ListTileControlAffinity.trailing,
                      contentPadding: const EdgeInsets.all(0),
                      checkColor: AppConstants.appPrimaryColor,
                      dense: true,
                      title: Text(
                        text,
                        style: const TextStyle(
                          color: AppConstants.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.09,
                        ),
                      ),
                      value: isMale == true
                          ? context.read<TelemedicineProvider>().selectedMale
                          : context.read<TelemedicineProvider>().selectedFemale,
                      onChanged: (value) {
                        isMale == true
                            ? context
                                .read<TelemedicineProvider>()
                                .selectMaleGender()
                            : context
                                .read<TelemedicineProvider>()
                                .selectFemaleGender();
                      },
                    )
            ],
          ),
        ),
      );
    });
  }
}
