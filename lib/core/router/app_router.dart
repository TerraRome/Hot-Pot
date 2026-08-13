import 'package:go_router/go_router.dart';
import 'package:hot_pot/features/home/presentation/pages/home_page.dart';
import 'package:hot_pot/features/about/presentation/pages/about_page.dart';
import 'package:hot_pot/features/projects/presentation/pages/projects_page.dart';
import 'package:hot_pot/features/contact/presentation/pages/contact_page.dart';
import 'package:hot_pot/features/cart/presentation/pages/cart_page.dart';
import 'package:hot_pot/features/orders/presentation/pages/order_tracking_page.dart';
import 'package:hot_pot/features/menu/presentation/pages/product_detail_page.dart';
import 'package:hot_pot/features/checkout/presentation/pages/checkout_page.dart';

/// Named route constants.
abstract final class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String contact = '/contact';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String productDetail = '/product';
}

/// GoRouter instance untuk seluruh app.
final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: true,
  routes: [
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
  ],
);
