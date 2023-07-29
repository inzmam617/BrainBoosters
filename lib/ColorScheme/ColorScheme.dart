import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  static final regularTheme = ThemeData(
    // Define your regular theme colors here
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.light(primary: Colors.blue, secondary: Colors.green),
    // ... add other theme properties ...
  );

  static final colorBlindTheme = ThemeData(
    // Define your color-blind theme colors here
    primaryColor: Colors.amber,
    colorScheme: ColorScheme.light(primary: Colors.amber, secondary: Colors.purple),
    // ... add other theme properties ...
  );

  bool _colorBlindMode = false;

  bool get colorBlindMode => _colorBlindMode;

  void toggleColorBlindMode(bool isEnabled) {
    _colorBlindMode = isEnabled;
    notifyListeners();
  }
}
