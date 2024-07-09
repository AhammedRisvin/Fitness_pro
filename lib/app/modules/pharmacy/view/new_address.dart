import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import 'view_model/pharmacy_provider.dart';

class NewAddressScreen extends StatelessWidget {
  const NewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        centerTitle: true,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: " New address",
          fontSize: 18,
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeBoxH(Responsive.height * 3),
            const commonTextWidget(
              color: AppConstants.white,
              text: " Personal Details",
              fontSize: 18,
            ),
            SizeBoxH(Responsive.height * 1.5),
            NewAddressTextField(
              textInputAction: TextInputAction.none,
              hintText: 'Full Name',
              keyboardType: TextInputType.name,
              controller: context.read<PharmacyProvider>().fullNameController,
            ),
            SizeBoxH(Responsive.height * 2),
            NewAddressTextField(
              textInputAction: TextInputAction.none,
              hintText: 'Phone Number',
              keyboardType: TextInputType.name,
              controller: context.read<PharmacyProvider>().phoneNumbeController,
            ),
            SizeBoxH(Responsive.height * 1),
            const commonTextWidget(
              color: AppConstants.appPrimaryColor,
              text: " + Add Alternate Phone Number",
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            SizeBoxH(Responsive.height * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Responsive.width * 44,
                  height: Responsive.height * 7,
                  child: NewAddressTextField(
                    textInputAction: TextInputAction.none,
                    hintText: 'Country',
                    keyboardType: TextInputType.name,
                    controller:
                        context.read<PharmacyProvider>().countryController,
                  ),
                ),
                SizedBox(
                  width: Responsive.width * 44,
                  height: Responsive.height * 7,
                  child: NewAddressTextField(
                    textInputAction: TextInputAction.none,
                    hintText: 'City',
                    keyboardType: TextInputType.name,
                    controller: context.read<PharmacyProvider>().cityController,
                  ),
                ),
              ],
            ),
            SizeBoxH(Responsive.height * 2),
            NewAddressTextField(
              textInputAction: TextInputAction.none,
              hintText: 'Phone Number',
              keyboardType: TextInputType.name,
              controller: context.read<PharmacyProvider>().fullNameController,
            ),
            SizeBoxH(Responsive.height * 2),
            NewAddressTextField(
              textInputAction: TextInputAction.none,
              hintText: 'Zip code',
              keyboardType: TextInputType.name,
              controller: context.read<PharmacyProvider>().fullNameController,
            ),
            SizeBoxH(Responsive.height * 15),
            CommonButton(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  // Routes.push(screen: const FavoritesScreen());
                },
                text: 'Add to cart',
                width: Responsive.width * 100,
                height: Responsive.height * 6),
          ],
        ),
      ),
    );
  }
}

class NewAddressTextField extends StatelessWidget {
  final String hintText;
  final Color hintTextColor;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final Widget? suffixIcon;
  const NewAddressTextField(
      {required this.hintText,
      this.hintTextColor = AppConstants.textFieldTextColor,
      required this.keyboardType,
      required this.textInputAction,
      this.validator,
      this.maxLength,
      required this.controller,
      this.contentPadding,
      this.obscureText = false,
      this.suffixIcon,
      this.maxLines = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: const TextStyle(
        color: AppConstants.white,
        fontSize: 14,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      maxLines: maxLines,
      decoration: InputDecoration(
        counterText: '',
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: AppConstants.white, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: AppConstants.white, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: AppConstants.white, width: 1),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppConstants.black,
        filled: true,
        labelText: hintText,
        labelStyle: const TextStyle(
          color: AppConstants.white,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      validator: validator,
      maxLength: maxLength,
      controller: controller,
    );
  }
}
