import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/auth/view%20model/auth_provider.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthProvider? authProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authProvider = context.read<AuthProvider>();
    authProvider?.getBranchFn();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GlassContainer(
        height: Responsive.height * 50,
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizeBoxH(Responsive.height * 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizeBoxV(10),
                    const commonTextWidget(
                      color: AppConstants.white,
                      text: "Login",
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
                SizeBoxH(Responsive.height * 1.5),
                Consumer<AuthProvider>(
                  builder: (context, value, child) => DropdownButtonFormField(
                    dropdownColor: AppConstants.drawerBgColor,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppConstants.textFieldTextColor,
                    ),
                    hint: commonTextWidget(
                      text: "Select Branch",
                      color: AppConstants.textFieldTextColor,
                      fontSize: Responsive.text * 1.6,
                    ),
                    decoration: InputDecoration(
                      fillColor: AppConstants.drawerBgColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        color: AppConstants.textFieldTextColor,
                      ),
                    ),
                    items: authProvider?.branchDataList
                        .map(
                          (label) => DropdownMenuItem(
                            value: label,
                            child: commonTextWidget(
                                text: label.branchName ?? "",
                                color: AppConstants.white,
                                fontSize: Responsive.text * 1.6),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      authProvider?.selectBranchFn(branch: value!.id!);
                    },
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                CommonTextFormField(
                  controller: authProvider?.userNameController,
                  bgColor: AppConstants.drawerBgColor,
                  hintText: 'Username',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    } else {
                      return null;
                    }
                  },
                ),
                SizeBoxH(Responsive.height * 2),
                Selector<AuthProvider, bool>(
                  selector: (p0, p1) => p1.isSignInhiddenPassword,
                  builder: (context, value, child) => CommonTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else {
                        return null;
                      }
                    },
                    obscureText: authProvider?.isSignInhiddenPassword ?? true,
                    controller: authProvider?.passWordController,
                    bgColor: AppConstants.drawerBgColor,
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () => authProvider?.signPasswordVisibility(),
                      icon: value
                          ? const Icon(
                              Icons.visibility_off,
                              color: AppConstants.textFieldTextColor,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: AppConstants.textFieldTextColor,
                            ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizeBoxH(Responsive.height * 3),
                CommonButton(
                  width: Responsive.width * 100,
                  height: Responsive.height * 6.5,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (authProvider?.selectedBranch != '') {
                        authProvider?.loginFun(context);
                      }
                    }
                  },
                  text: "Login",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const commonTextWidget(
                      color: AppConstants.white,
                      text: "Book Free Trial ?",
                      fontSize: 12,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const commonTextWidget(
                        text: 'Click here',
                        color: AppConstants.appPrimaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
