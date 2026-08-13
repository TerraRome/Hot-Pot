import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

extension SpacingX on num {
  SizedBox get verticalSpace => SizedBox(height: toDouble());
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}

extension StringX on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
