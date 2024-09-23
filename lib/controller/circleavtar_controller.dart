import 'package:flutter/material.dart';

class CircularProgressIndicatorController extends ChangeNotifier {
  bool _loding = false;
  bool get loding => _loding;
  setloding(bool select) {
    _loding = select;
    notifyListeners();
  }
}
