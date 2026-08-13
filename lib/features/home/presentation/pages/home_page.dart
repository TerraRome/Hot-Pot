import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/router/app_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';
import 'package:hot_pot/features/home/presentation/widgets/home_banner_carousel.dart';
import 'package:hot_pot/features/home/presentation/widgets/home_category_chips.dart';
import 'package:hot_pot/features/home/presentation/widgets/home_header.dart';
import 'package:hot_pot/features/home/presentation/widgets/home_location_bar.dart';
import 'package:hot_pot/features/home/presentation/widgets/home_menu_grid.dart';
import 'package:hot_pot/features/home/presentation/widgets/home_search_bar.dart';
import 'package:hot_pot/features/home/presentation/widgets/home_special_offers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    // Transparent status bar so header bleeds into it
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          // ── Sticky crimson header ─────────────────────────────────────
          SliverToBoxAdapter(child: HomeHeader()),

          // ── Location bar ─────────────────────────────────────────────
          const SliverToBoxAdapter(child: HomeLocationBar()),

          // ── Search + order type toggle ────────────────────────────────
          const SliverToBoxAdapter(child: HomeSearchBar()),
          const SliverToBoxAdapter(child: HomeOrderTypeToggle()),

          // ── Promo banner carousel ─────────────────────────────────────
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: HomeBannerCarousel(),
            ),
          ),

          // ── Category chips ────────────────────────────────────────────
          const SliverToBoxAdapter(child: HomeCategoryChips()),

          // ── Special offers ────────────────────────────────────────────
          const SliverToBoxAdapter(child: HomeSpecialOffers()),

          // ── Popular menu grid ─────────────────────────────────────────
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 4, bottom: 24),
              child: HomeMenuGrid(),
            ),
          ),
        ],
      ),
      // ── Bottom nav bar ──────────────────────────────────────────────
      bottomNavigationBar: _BottomNav(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                active: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: Icons.explore_outlined,
                label: 'Explore',
                active: currentIndex == 1,
                onTap: () {
                  onTap(1);
                  context.push(AppRoutes.category);
                },
              ),
              _NavItem(
                icon: Icons.receipt_long_outlined,
                label: 'Orders',
                active: currentIndex == 2,
                onTap: () {
                  onTap(2);
                  context.push(AppRoutes.orders);
                },
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                label: 'Account',
                active: currentIndex == 3,
                onTap: () {
                  onTap(3);
                  context.push(AppRoutes.profile);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: active ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight:
                    active ? FontWeight.w600 : FontWeight.w400,
                color: active ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
