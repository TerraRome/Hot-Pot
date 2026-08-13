import 'package:go_router/go_router.dart';
import 'package:hot_pot/features/home/presentation/pages/home_page.dart';
import 'package:hot_pot/features/about/presentation/pages/about_page.dart';
import 'package:hot_pot/features/projects/presentation/pages/projects_page.dart';
import 'package:hot_pot/features/contact/presentation/pages/contact_page.dart';
import 'package:hot_pot/features/cart/presentation/pages/cart_page.dart';
import 'package:hot_pot/features/orders/presentation/pages/order_tracking_page.dart';
import 'package:hot_pot/features/menu/presentation/pages/product_detail_page.dart';
import 'package:hot_pot/features/checkout/presentation/pages/checkout_page.dart';
import 'package:hot_pot/features/auth/presentation/pages/splash_page.dart';
import 'package:hot_pot/features/auth/presentation/pages/sign_in_page.dart';
import 'package:hot_pot/features/auth/presentation/pages/otp_page.dart';
import 'package:hot_pot/features/search/presentation/pages/search_page.dart';
import 'package:hot_pot/features/explore/presentation/pages/category_browse_page.dart';
import 'package:hot_pot/features/profile/presentation/pages/profile_page.dart';
import 'package:hot_pot/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:hot_pot/features/orders/presentation/pages/invoice_page.dart';
import 'package:hot_pot/features/orders/presentation/pages/live_tracking_page.dart';
import 'package:hot_pot/features/notifications/presentation/pages/notification_page.dart';
import 'package:hot_pot/features/onboarding/presentation/pages/onboarding_page.dart';

/// Named route constants.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String signIn = '/signin';
  static const String otp = '/otp';
  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String contact = '/contact';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String productDetail = '/product';
  static const String search = '/search';
  static const String category = '/category';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String invoice = '/invoice';
  static const String liveTracking = '/live-tracking';
  static const String notifications = '/notifications';
  static const String onboarding = '/onboarding';
}

/// GoRouter instance untuk seluruh app.
final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      name: 'signin',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoutes.otp,
      name: 'otp',
      builder: (context, state) => const OtpPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.about,
      name: 'about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: AppRoutes.projects,
      name: 'projects',
      builder: (context, state) => const ProjectsPage(),
    ),
    GoRoute(
      path: AppRoutes.contact,
      name: 'contact',
      builder: (context, state) => const ContactPage(),
    ),
    GoRoute(
      path: AppRoutes.cart,
      name: 'cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: AppRoutes.checkout,
      name: 'checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
    GoRoute(
      path: AppRoutes.orders,
      name: 'orders',
      builder: (context, state) => const OrderTrackingPage(),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      name: 'product',
      builder: (context, state) {
        final args = state.extra as ProductDetailArgs;
        return ProductDetailPage(args: args);
      },
    ),
    GoRoute(
      path: AppRoutes.search,
      name: 'search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: AppRoutes.category,
      name: 'category',
      builder: (context, state) => const CategoryBrowsePage(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.editProfile,
      name: 'edit-profile',
      builder: (context, state) => const EditProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.invoice,
      name: 'invoice',
      builder: (context, state) {
        final args = state.extra as InvoiceArgs?;
        return InvoicePage(args: args);
      },
    ),
    GoRoute(
      path: AppRoutes.liveTracking,
      name: 'live-tracking',
      builder: (context, state) => const LiveTrackingPage(),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      name: 'notifications',
      builder: (context, state) => const NotificationPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
  ],
);

