import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/router/app_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';
import 'package:hot_pot/features/menu/presentation/pages/product_detail_page.dart';

/// Grid of menu item cards with rating, price, and add-to-cart button.
class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({super.key});

  static const List<_MenuItem> _items = [
    _MenuItem(
      emoji: '🔥',
      name: 'Sichuan Spicy Broth',
      description:
          'Authentic Sichuan numbing spice blend with dried chilies, Sichuan peppercorn, and aromatic herbs. A bold, fiery broth that tingles your lips and warms your soul.',
      price: 'Rp 65.000',
      priceRaw: 65000,
      rating: '4.9',
      ratingRaw: 4.9,
      reviews: '2.3k',
      reviewsCount: 2300,
      spicyLevel: 3,
      badge: 'BEST SELLER',
      badgeColor: Color(0xFF9A0B17),
    ),
    _MenuItem(
      emoji: '🍲',
      name: 'Mushroom Clear Broth',
      description:
          'Light and delicate broth made from premium shiitake, king oyster, and enoki mushrooms. Perfect for a clean, healthy hot pot experience.',
      price: 'Rp 55.000',
      priceRaw: 55000,
      rating: '4.7',
      ratingRaw: 4.7,
      reviews: '1.1k',
      reviewsCount: 1100,
      spicyLevel: 0,
      badge: 'POPULAR',
      badgeColor: Color(0xFF2B9A66),
    ),
    _MenuItem(
      emoji: '🥩',
      name: 'Wagyu Beef Slices',
      description:
          'Premium A5 Japanese wagyu, hand-sliced paper-thin for the perfect melt-in-your-mouth experience. Rich marbling, exceptional flavor.',
      price: 'Rp 120.000',
      priceRaw: 120000,
      rating: '4.8',
      ratingRaw: 4.8,
      reviews: '890',
      reviewsCount: 890,
      spicyLevel: 0,
      badge: 'PREMIUM',
      badgeColor: Color(0xFFD4AF37),
    ),
    _MenuItem(
      emoji: '🦐',
      name: 'Tiger Prawn Set',
      description:
          'Fresh tiger prawns served head-on, 6 pieces per serving. Sweet and juicy, perfect for the hot pot broth.',
      price: 'Rp 95.000',
      priceRaw: 95000,
      rating: '4.6',
      ratingRaw: 4.6,
      reviews: '540',
      reviewsCount: 540,
      spicyLevel: 1,
      badge: null,
      badgeColor: null,
    ),
    _MenuItem(
      emoji: '🧧',
      name: 'Dragon Set Menu',
      description:
          'Our signature complete set — choose your broth, 5 premium proteins, seasonal vegetables, noodles, and dipping sauces. The full Crimson Dragon experience.',
      price: 'Rp 299.000',
      priceRaw: 299000,
      rating: '4.9',
      ratingRaw: 4.9,
      reviews: '3.1k',
      reviewsCount: 3100,
      spicyLevel: 2,
      badge: 'SET MEAL',
      badgeColor: Color(0xFF9A0B17),
    ),
    _MenuItem(
      emoji: '🥦',
      name: 'Garden Veggie Platter',
      description:
          '12 varieties of seasonal farm-fresh vegetables, including baby bok choy, lotus root, corn, tofu, and more. Light and nutritious.',
      price: 'Rp 45.000',
      priceRaw: 45000,
      rating: '4.5',
      ratingRaw: 4.5,
      reviews: '320',
      reviewsCount: 320,
      spicyLevel: 0,
      badge: null,
      badgeColor: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.foreground,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: _items.length,
            itemBuilder: (context, i) => _MenuCard(item: _items[i]),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final String emoji;
  final String name;
  final String description;
  final String price;
  final int priceRaw;
  final String rating;
  final double ratingRaw;
  final String reviews;
  final int reviewsCount;
  final int spicyLevel;
  final String? badge;
  final Color? badgeColor;

  const _MenuItem({
    required this.emoji,
    required this.name,
    required this.description,
    required this.price,
    required this.priceRaw,
    required this.rating,
    required this.ratingRaw,
    required this.reviews,
    required this.reviewsCount,
    required this.spicyLevel,
    required this.badge,
    required this.badgeColor,
  });
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.item});
  final _MenuItem item;

  void _openDetail(BuildContext context) {
    context.push(
      AppRoutes.productDetail,
      extra: ProductDetailArgs(
        emoji: item.emoji,
        name: item.name,
        description: item.description,
        price: item.priceRaw,
        spicyLevel: item.spicyLevel,
        rating: item.ratingRaw,
        reviews: item.reviewsCount,
        badge: item.badge,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetail(context),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderDivider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Stack(
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBg,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      item.emoji,
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                ),
                if (item.badge != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: item.badgeColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.badge!,
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: item.badgeColor == AppColors.secondary
                              ? AppColors.secondaryText
                              : Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.foreground,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 13, color: AppColors.secondary),
                      const SizedBox(width: 2),
                      Text(
                        item.rating,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.foreground,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '(${item.reviews})',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.price,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
