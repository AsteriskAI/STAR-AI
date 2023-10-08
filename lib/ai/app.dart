import 'package:flutter/material.dart';

class AppConfig {
  static const String backgroundImage = 'assets/background.png';
  static const String nasaStandardsUrl =
      'https://standards.nasa.gov/all-standards?page=0?target=_blank';
}

class AppColors {
  static const Color primaryColor = Color(0xff7CC4F1);
  static Color buttonBackgroundColor = Colors.black.withOpacity(0.2);
  static Color containerTextColor = const Color(0xff7CC4F1).withOpacity(0.2);
}

class AppFonts {
  static const double titleSize = 40;
  static const double buttonTextSize = 24;
  static const double containerTextSize = 20;
}

class AppDimensions {
  static const double containerWidth = 390;
}
