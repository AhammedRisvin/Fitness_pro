import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/auth/view%20model/auth_provider.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';

class FacilityRentalLoginScreen extends StatefulWidget {
  const FacilityRentalLoginScreen({super.key});

  @override
  State<FacilityRentalLoginScreen> createState() =>
      _FacilityRentalLoginScreenState();
}

class _FacilityRentalLoginScreenState extends State<FacilityRentalLoginScreen> {
  AuthProvider? authProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GlassContainer(
        height: Responsive.height * 48,
        width: Responsive.width * 100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.1),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(1.0),
            Colors.black.withOpacity(1.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.60),
            Colors.black.withOpacity(0.10),
            Colors.black.withOpacity(0.05),
            Colors.black.withOpacity(0.6)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.39, 0.40, 1.0],
        ),
        blur: 5.0,
        elevation: 3.0,
        isFrostedGlass: true,
        frostedOpacity: 0.12,
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizeBoxH(Responsive.height * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizeBoxV(10),
                    const commonTextWidget(
                      color: AppConstants.white,
                      text: "Facility Rental",
                    ),
                    CommonInkwell(
                      onTap: () {
                        Routes.back();
                      },
                      child: Image.asset(
                        "assets/images/cancelVector.png",
                        height: 13,
                        width: 13,
                      ),
                    ),
                  ],
                ),
                SizeBoxH(Responsive.height * 2),
                CommonTextFormField(
                  controller: authProvider?.fullNameController,
                  bgColor: AppConstants.drawerBgColor,
                  hintText: 'Enter Name',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      return null;
                    }
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppConstants.drawerBgColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      CountryCodePicker(
                        onChanged: (CountryCode countryCode) {
                          authProvider
                              ?.updateCountryCode(countryCode.dialCode ?? '');
                          log("codeeeeeeeeeeeeeeee${countryCode.dialCode}");
                        },
                        initialSelection: 'AE',
                        favorite: const ['+971', 'AE'],
                        backgroundColor: AppConstants.drawerBgColor,
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        hideSearch: false,
                        textStyle: const TextStyle(color: AppConstants.white),
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        showFlag: true,
                        flagWidth: Responsive.width * 6,
                        showFlagMain: false,
                        alignLeft: false,
                        textOverflow: TextOverflow.ellipsis,
                        showDropDownButton: true,
                        barrierColor: AppConstants.drawerBgColor,
                        dialogBackgroundColor: AppConstants.drawerBgColor,
                        padding: EdgeInsets.zero,
                      ),
                      Selector<AuthProvider, int>(
                        selector: (context, authProvider) =>
                            authProvider.maxLength,
                        builder: (context, maxLength, _) {
                          return Expanded(
                            child: CommonTextFormField(
                              bgColor: AppConstants.drawerBgColor,
                              hintText: 'Phone Number',
                              // isPassword: false,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller: authProvider?.phoneNumberController,
                              maxLength: maxLength,
                              contentPadding: EdgeInsets.zero,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Phone Number';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.white,
                  text: "We will send you an OTP when you\n click next",
                  fontSize: 16,
                ),
                SizeBoxH(Responsive.height * 2),
                CommonButton(
                  width: Responsive.width * 100,
                  height: Responsive.height * 6.5,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authProvider?.facilityRentalLoginFn(context: context);
                    }
                  },
                  text: "Next",
                ),
                SizeBoxH(Responsive.height * 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
