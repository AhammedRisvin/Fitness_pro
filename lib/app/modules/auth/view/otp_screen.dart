import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/auth/view%20model/auth_provider.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthProvider? authProvider;

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
        height: Responsive.height * 40,
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
        // borderWidth: 1.5,
        elevation: 3.0,
        isFrostedGlass: true,
        // shadowColor: Colors.black.withOpacity(0.20),
        // alignment: Alignment.center,
        frostedOpacity: 0.12,
        // margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizeBoxH(Responsive.height * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizeBoxV(10),
                  const commonTextWidget(
                    color: AppConstants.white,
                    text: "ENTER OTP",
                    fontWeight: FontWeight.w700,
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
              commonTextWidget(
                color: AppConstants.white,
                text:
                    "Enter the verification code we just send\non your phonenumber ${authProvider?.decryptPhoneNumber(authProvider?.phoneNumber ?? "")}",
                fontSize: 16,
              ),
              TextButton(
                onPressed: () {},
                child: const commonTextWidget(
                  color: AppConstants.appPrimaryColor,
                  text: "Resend",
                  fontSize: 12,
                ),
              ),
              CommonTextFormField(
                controller: authProvider?.otpController,
                bgColor: AppConstants.drawerBgColor,
                hintText: 'Verification Code',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter otp';
                //   } else {
                //     return null;
                //   }
                // },
              ),
              SizeBoxH(Responsive.height * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonInkwell(
                    onTap: () {
                      Routes.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      height: Responsive.height * 7.5,
                      width: Responsive.width * 43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppConstants.black,
                        border: Border.all(
                          color: AppConstants.white,
                        ),
                      ),
                      child: const commonTextWidget(
                        color: AppConstants.white,
                        text: "Back",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  CommonInkwell(
                    onTap: () {
                      authProvider?.facilityRentalOtpVerificationFn(
                          context: context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      height: Responsive.height * 7.5,
                      width: Responsive.width * 43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppConstants.appPrimaryColor,
                        border: Border.all(
                          color: AppConstants.black,
                        ),
                      ),
                      child: const commonTextWidget(
                        color: AppConstants.black,
                        text: "Next",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
