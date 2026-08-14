// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Crimson Dragon Hot Pot';

  @override
  String get dragonMember => 'Anggota Dragon';

  @override
  String get onboardingWelcomeTitle => 'Selamat Datang di\nCrimson Dragon';

  @override
  String get onboardingWelcomeSubtitle =>
      'Pengalaman hot pot autentik diantar ke pintu Anda — atau nikmati makan di tempat bersama kami.';

  @override
  String get onboardingCraftTitle => 'Racik Hot Pot\nSempurna Anda';

  @override
  String get onboardingCraftSubtitle =>
      'Pilih dari 6 kuah kaldu, daging premium, seafood segar, dan sayuran musiman.';

  @override
  String get onboardingTrackTitle => 'Lacak Setiap\nLangkah, Langsung';

  @override
  String get onboardingTrackSubtitle =>
      'Pelacakan pesanan real-time dari dapur hingga meja Anda. Selalu segar, selalu tepat waktu.';

  @override
  String get onboardingSkip => 'Lewati';

  @override
  String get onboardingNext => 'Lanjut';

  @override
  String get onboardingGetStarted => 'Mulai Sekarang';

  @override
  String get signInTitle => 'Masuk';

  @override
  String get signInSubtitle =>
      'Selamat datang kembali! Pesan hot pot favorit Anda.';

  @override
  String get emailPhoneLabel => 'Email / No. HP';

  @override
  String get emailHint => 'anda@contoh.com';

  @override
  String get passwordLabel => 'Kata Sandi';

  @override
  String get rememberMe => 'Ingat saya';

  @override
  String get forgotPassword => 'Lupa kata sandi?';

  @override
  String get signInButton => 'Masuk';

  @override
  String get orSignInWith => 'atau masuk dengan';

  @override
  String get noAccount => 'Belum punya akun? ';

  @override
  String get register => 'Daftar';

  @override
  String get otpTitle => 'Cek Email Anda';

  @override
  String get otpSubtitle =>
      'Kami telah mengirim kode verifikasi 6 digit ke inbox Anda. Berlaku selama 10 menit.';

  @override
  String otpCodeExpiresIn(Object seconds) {
    return 'Kode berlaku 0:$seconds';
  }

  @override
  String get otpCodeExpired => 'Kode kedaluwarsa';

  @override
  String get otpVerify => 'Verifikasi & Lanjutkan';

  @override
  String get otpResend => 'Kirim ulang kode ke email';

  @override
  String get otpSecure => 'Verifikasi aman dan terenkripsi';

  @override
  String get forgotTitle => 'Lupa Kata Sandi?';

  @override
  String get forgotSubtitle =>
      'Tenang! Masukkan email Anda di bawah dan kami akan mengirimkan tautan untuk mereset kata sandi Anda.';

  @override
  String get emailAddressLabel => 'Alamat Email';

  @override
  String get forgotSend => 'Kirim Tautan Reset';

  @override
  String get forgotResetSent =>
      'Tautan reset kata sandi telah dikirim ke email Anda';

  @override
  String get rememberedIt => 'Sudah ingat? ';

  @override
  String get backToSignIn => 'Kembali ke Masuk';

  @override
  String get registerTitle => 'Buat Akun';

  @override
  String get registerSubtitle =>
      'Bergabunglah dengan Crimson Dragon dan nikmati hot pot diantar cepat.';

  @override
  String get fullNameLabel => 'Nama Lengkap';

  @override
  String get fullNameHint => 'Budi Santoso';

  @override
  String get phoneLabel => 'No. Telepon';

  @override
  String get phoneHint => '+62 812-3456-7890';

  @override
  String get confirmPasswordLabel => 'Konfirmasi Kata Sandi';

  @override
  String get agreeTerms =>
      'Saya setuju dengan Syarat & Ketentuan dan Kebijakan Privasi';

  @override
  String get createAccountButton => 'Buat Akun';

  @override
  String get alreadyAccount => 'Sudah punya akun? ';

  @override
  String get signInLink => 'Masuk';

  @override
  String get agreeTermsRequired => 'Harap setujui Syarat & Kebijakan Privasi';

  @override
  String homeGreeting(Object timeOfDay) {
    return 'Selamat $timeOfDay';
  }

  @override
  String get homeSubtitle => 'Hot pot segar di depan pintu Anda';

  @override
  String get searchHint => 'Cari menu, kuah, bahan…';

  @override
  String get sectionAccount => 'Akun';

  @override
  String get sectionOrders => 'Pesanan';

  @override
  String get sectionSupport => 'Bantuan';

  @override
  String get sectionGeneral => 'Umum';

  @override
  String get sectionPreferences => 'Preferensi';

  @override
  String get editProfile => 'Edit Profil';

  @override
  String get savedAddresses => 'Alamat Tersimpan';

  @override
  String get paymentMethods => 'Metode Pembayaran';

  @override
  String get promoVouchers => 'Promo & Voucher';

  @override
  String get orderHistory => 'Riwayat Pesanan';

  @override
  String get favouriteItems => 'Item Favorit';

  @override
  String get myReviews => 'Ulasan Saya';

  @override
  String get loyaltyRewards => 'Loyalitas & Hadiah';

  @override
  String get helpFaq => 'Bantuan & FAQ';

  @override
  String get contactSupport => 'Hubungi Bantuan';

  @override
  String get aboutCrimson => 'Tentang Crimson Dragon';

  @override
  String get settings => 'Pengaturan';

  @override
  String get settingsNotifications => 'NOTIFIKASI';

  @override
  String get settingsEmail => 'EMAIL';

  @override
  String get settingsPreferences => 'PREFERENSI';

  @override
  String get settingsPrivacy => 'PRIVASI';

  @override
  String get settingsAppearance => 'TAMPILAN';

  @override
  String get settingsAccount => 'AKUN';

  @override
  String get darkMode => 'Mode Gelap';

  @override
  String get darkModeSubtitle => 'Beralih ke tema warna yang lebih gelap';

  @override
  String get language => 'Bahasa';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get signOut => 'Keluar';
}
