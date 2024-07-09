import 'package:flutter/material.dart';

class PharmaProvider extends ChangeNotifier {
  double ratinglenght = 0.0;

  ratingLengthFun(double value) {
    ratinglenght = value;
    notifyListeners();
  }

  List<String> selectedOptions = []; // Add this line

  void toggleOption(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
    notifyListeners();
  }

  List reviewsBad = [
    'Location awareness',
    'Rider behavior',
    'Rider hygiene',
    'Delivery time',
    'Excessive calling',
    'Delivery instruction ignored',
    'Spilled or damged item',
  ];
}
