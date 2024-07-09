import 'package:flutter/material.dart';

class PharmacyProvider extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumbeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  int cusrrentIndex = 0;
  currentIndexFnc({int? index}) {
    cusrrentIndex = index ?? 0;
    notifyListeners();
  }
}
