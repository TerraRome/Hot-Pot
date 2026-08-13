/// Global app constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'Hot Pot';
  static const String appVersion = '1.0.0';

  // API
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // UI
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 2);
}
