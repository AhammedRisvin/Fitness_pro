import 'dart:developer';
import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TelemedicineProvider extends ChangeNotifier {
  String selectedFilter = '';
  void selectTimeForSort(String value) {
    selectedFilter = value.toString();
    log(selectedFilter);
    notifyListeners();
  }

  bool selectedMale = false;
  bool selectedFemale = false;
  String ismale = '';
  String isFemale = '';
  void selectMaleGender() {
    selectedMale = !selectedMale;
    if (selectedMale) {
      ismale = "male";
    }
    notifyListeners();
  }

  void selectFemaleGender() {
    selectedFemale = !selectedFemale;
    if (selectedFemale) {
      isFemale = "female";
    }
    notifyListeners();
  }

//Doctors sort select experience fun

  double startExperience = 0.0;
  double endExperience = 100.0;
  void selectExperienceRange(RangeValues rangeValues) {
    // Simply converting to an integer
    int start = rangeValues.start.toInt() ~/ 1;
    int end = rangeValues.end.toInt() ~/ 1;
    startExperience = start.toDouble();
    endExperience = end.toDouble();
    log(startExperience.toString());
    log(endExperience.toString());
    notifyListeners();
  }

  File? thumbnailImage;
  Future addPatientPrescription(bool isGallery) async {
    try {
      final image = await ImagePicker().pickImage(
          source: isGallery ? ImageSource.gallery : ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);

      thumbnailImage = imageTemporary;
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

//payment selection
  String selectedpayment = '';
  void selectPaymentForBooking(String value) {
    selectedpayment = value.toString();
    log(selectedpayment);
    notifyListeners();
  }

  Future<void> checkIfAppInstalled({required String link}) async {
    var h = await LaunchApp.isAppInstalled(
      androidPackageName: 'us.zoom.videomeetings',
      iosUrlScheme: 'pulsesecure://id546505307',

      // openStore: false
    );
    if (h == true) {
      await launchUrlString('zoomus://zoom.us/join?confno=$link',
          mode: LaunchMode.externalNonBrowserApplication);
    } else {
      const String androidZoomUrl =
          "https://play.google.com/store/apps/details?id=us.zoom.videomeetings";
      const String iosZoomUrl =
          "https://apps.apple.com/us/app/zoom-cloud-meetings/id546505307";

      if (await canLaunch(androidZoomUrl)) {
        await launch(androidZoomUrl);
      } else if (await canLaunch(iosZoomUrl)) {
        await launch(iosZoomUrl);
      } else {
        throw 'Could not launch Zoom app store URL';
      }
    }

    print(h);
  }

  String trimZoomUrl(String url) {
    String prefixToRemove = "https://us05web.zoom.us/j/";

    if (url.startsWith(prefixToRemove)) {
      print(url.substring(prefixToRemove.length));
      return url.substring(prefixToRemove.length);
    } else {
      return url;
    }
  }
}
