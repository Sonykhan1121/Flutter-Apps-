import 'package:flutter/material.dart';

class ButtonProvider extends ChangeNotifier {
  String top = "_";
  String bottom = "0";

  void addButton(String buttonText) {
    top+=(buttonText);
    notifyListeners();
  }

  void clearButton() {
    top='_';
    bottom='0';
    notifyListeners();
  }
  void addresult(String res)
  {
    bottom=(res);
    notifyListeners();
  }
}
