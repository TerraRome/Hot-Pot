// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Crimson Dragon Hot Pot';

  @override
  String get dragonMember => 'Dragon Member';

  @override
  String get onboardingWelcomeTitle => 'Welcome to\nCrimson Dragon';

  @override
  String get onboardingWelcomeSubtitle =>
      'Authentic hot pot experience delivered to your door — or dine with us in style.';

  @override
  String get onboardingCraftTitle => 'Craft Your\nPerfect Hot Pot';

  @override
  String get onboardingCraftSubtitle =>
      'Choose from 6 broth bases, premium meats, fresh seafood, and seasonal vegetables.';

  @override
  String get onboardingTrackTitle => 'Track Every\nStep, Live';

  @override
  String get onboardingTrackSubtitle =>
      'Real-time order tracking from kitchen to your table. Always fresh, always on time.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get signInSubtitle => 'Welcome back! Order your favourite hot pot.';

  @override
  String get emailPhoneLabel => 'Email / Phone number';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signInButton => 'Sign in';

  @override
  String get orSignInWith => 'or sign in with';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get register => 'Register';

  @override
  String get otpTitle => 'Check your Email';

  @override
  String get otpSubtitle =>
      'We\'ve sent a 6-digit confirmation code to your inbox. It expires in 10 minutes.';

  @override
  String otpCodeExpiresIn(Object seconds) {
    return 'Code expires in 0:$seconds';
  }

  @override
  String get otpCodeExpired => 'Code expired';

  @override
  String get otpVerify => 'Verify & Continue';

  @override
  String get otpResend => 'Resend code to email';

  @override
  String get otpSecure => 'Secure and encrypted verification';

  @override
  String get forgotTitle => 'Forgot Password?';

  @override
  String get forgotSubtitle =>
      'No worries! Enter your email below and we\'ll send you a link to reset your password.';

  @override
  String get emailAddressLabel => 'Email Address';

  @override
  String get forgotSend => 'Send Reset Link';

  @override
  String get forgotResetSent => 'Password reset link sent to your email';

  @override
  String get rememberedIt => 'Remembered it? ';

  @override
  String get backToSignIn => 'Back to Sign in';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerSubtitle =>
      'Join Crimson Dragon and enjoy hot pot delivered fast.';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameHint => 'Budi Santoso';

  @override
  String get phoneLabel => 'Phone Number';

  @override
  String get phoneHint => '+62 812-3456-7890';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get agreeTerms =>
      'I agree to the Terms & Conditions and Privacy Policy';

  @override
  String get createAccountButton => 'Create Account';

  @override
  String get alreadyAccount => 'Already have an account? ';

  @override
  String get signInLink => 'Sign in';

  @override
  String get agreeTermsRequired => 'Please agree to the Terms & Privacy Policy';

  @override
  String homeGreeting(Object timeOfDay) {
    return 'Good $timeOfDay';
  }

  @override
  String get homeSubtitle => 'Fresh hot pot at your door';

  @override
  String get searchHint => 'Search menu, broth, ingredients…';

  @override
  String get sectionAccount => 'Account';

  @override
  String get sectionOrders => 'Orders';

  @override
  String get sectionSupport => 'Support';

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionPreferences => 'Preferences';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get savedAddresses => 'Saved Addresses';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get promoVouchers => 'Promo & Vouchers';

  @override
  String get orderHistory => 'Order History';

  @override
  String get favouriteItems => 'Favourite Items';

  @override
  String get myReviews => 'My Reviews';

  @override
  String get loyaltyRewards => 'Loyalty & Rewards';

  @override
  String get helpFaq => 'Help & FAQ';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get aboutCrimson => 'About Crimson Dragon';

  @override
  String get settings => 'Settings';

  @override
  String get settingsNotifications => 'NOTIFICATIONS';

  @override
  String get settingsEmail => 'EMAIL';

  @override
  String get settingsPreferences => 'PREFERENCES';

  @override
  String get settingsPrivacy => 'PRIVACY';

  @override
  String get settingsAppearance => 'APPEARANCE';

  @override
  String get settingsAccount => 'ACCOUNT';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get darkModeSubtitle => 'Switch to a darker color theme';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get signOut => 'Sign Out';
}
