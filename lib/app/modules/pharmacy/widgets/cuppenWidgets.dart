import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../../estore/view model/estore_provider.dart';

class CuppenWidgets extends StatelessWidget {
  const CuppenWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const commonTextWidget(
          color: AppConstants.white,
          text: 'Save on your order',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        SizeBoxH(Responsive.height * 2),
        Container(
          width: Responsive.width * 100,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF373737),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Center(
            child: TextField(
              controller: context.read<EstoreProvider>().serchingController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onChanged: (query) {
                context.read<EstoreProvider>().setSearchQuery(query);
                context.read<EstoreProvider>().eStoreSerchingFnc(query: query);
              },

              style: const TextStyle(
                color: AppConstants.white,
              ), // Customize text color
              decoration: InputDecoration(
                filled: true, //<-- SEE HERE
                fillColor: AppConstants.searchColor, //<-
                hintText: 'Enter voucher code',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintStyle: const TextStyle(
                  color: AppConstants.white,
                ), // Customize hint text color

                prefixIcon: Image.asset(AppImages.ticketdiscount,
                    color:
                        AppConstants.appPrimaryColor), // Customize prefix icon

                suffixIcon: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Submit',
                      style: TextStyle(
                        color: AppConstants.appPrimaryColor,
                        fontSize: 12,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w700,
                      )),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppConstants.searchColor,
                  ), // Customize border color
                  borderRadius:
                      BorderRadius.circular(10.0), // Customize border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppConstants.appPrimaryColor,
                  ), // Customize focused border color
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ), // Customize border radius
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
