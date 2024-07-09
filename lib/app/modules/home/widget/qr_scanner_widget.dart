// Update this with the correct path

import 'package:flutter/material.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/extensions.dart';

// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/app_router.dart';
// Update this with the correct path

// Update this with the correct path

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // QRView(
          //   key: GlobalKey(debugLabel: 'QR'),
          //   onQRViewCreated:
          //       Provider.of<HomeScreenProvider>(context, listen: false)
          //           .onQRViewCreated,
          //   overlay: QrScannerOverlayShape(
          //     borderColor: AppConstants.appPrimaryColor,
          //     borderRadius: 10,
          //     borderLength: 30,
          //     borderWidth: 10,
          //     cutOutSize: 300,
          //   ),
          // ),
          Positioned(
            top: Responsive.height * 2.5,
            left: Responsive.width * 2,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Routes.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppConstants.white,
                    size: 25,
                  ),
                ),
                SizeBoxV(Responsive.width * 3),
                const commonTextWidget(
                  color: AppConstants.white,
                  text: "Scan",
                  fontSize: 20,
                )
              ],
            ),
          ),
          Positioned(
            top: Responsive.height * 20,
            left: Responsive.width * 33,
            child: const commonTextWidget(
              color: AppConstants.white,
              text: "Scan QR code",
              fontSize: 20,
            ),
          ),
          Positioned(
            top: Responsive.height * 80,
            left: Responsive.width * 18,
            child: const commonTextWidget(
              color: AppConstants.white,
              text: "Place a bar code inside the viewfinder\n to scan it",
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
