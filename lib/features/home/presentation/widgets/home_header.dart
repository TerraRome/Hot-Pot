import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/router/app_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

/// Header merah crimson dengan logo naga, lokasi, notifikasi, dan cart badge.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      child: Stack(
        children: [
          // Wavy bottom divider
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: _WavyClipper(),
              child: Container(
                height: 24,
                color: AppColors.background,
              ),
            ),
          ),
          // Content
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Row(
                children: [
                  // Logo + title
                  const _LogoBlock(),
                  const Spacer(),
                  // Notification icon with badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _IconButton(
                        icon: Icons.notifications_outlined,
                        onTap: () => context.push(AppRoutes.notifications),
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  // Cart icon with badge — navigates to /cart
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _IconButton(
                        icon: Icons.shopping_bag_outlined,
                        onTap: () => context.push(AppRoutes.cart),
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '2',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoBlock extends StatelessWidget {
  const _LogoBlock();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Dragon emoji logo in white circle
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Text('🐉', style: TextStyle(fontSize: 20)),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '龙门火锅',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Crimson Dragon Hot Pot',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xCCFFFFFF),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

/// Custom wavy clipper for the header bottom divider.
class _WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.5);
    final w = size.width;
    final h = size.height;
    path.quadraticBezierTo(w * 0.25, 0, w * 0.5, h * 0.5);
    path.quadraticBezierTo(w * 0.75, h, w, h * 0.5);
    path.lineTo(w, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WavyClipper oldClipper) => false;
}
