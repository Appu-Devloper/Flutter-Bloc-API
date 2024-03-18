import 'package:flutter/material.dart';

class TranslationProvider with ChangeNotifier {
  bool _showTranslation = false;

  bool get showTranslation => _showTranslation;

  void toggleTranslation() {
    _showTranslation = !_showTranslation;
    notifyListeners();
  }
}
