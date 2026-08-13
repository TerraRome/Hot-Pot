import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

class MyReviewsPage extends StatelessWidget {
  const MyReviewsPage({super.key});

  static const _reviews = [
    _Review(
      orderId: 'CDH-20240812-0031',
      date: '12 Aug 2024',
      items: ['🔥 Sichuan Spicy Broth', '🥩 Wagyu Beef Slices', '🦐 Tiger Prawn Set'],
      rating: 5,
      comment: 'Absolutely amazing! The wagyu was melt-in-your-mouth and the spicy broth had just the right kick. Delivery was fast and everything arrived hot.',
    ),
    _Review(
      orderId: 'CDH-20240805-0018',
      date: '5 Aug 2024',
      items: ['🍲 Original Mild Broth', '🍄 Mushroom Trio', '🍜 Hand-pulled Noodles'],
      rating: 4,
      comment: 'Great flavor and fresh ingredients. The noodles were perfectly chewy. Only minor issue was the delivery took a bit longer than expected.',
    ),
    _Review(
      orderId: 'CDH-20240728-0009',
      date: '28 Jul 2024',
      items: ['🥛 Creamy Coconut Broth', '🐑 Lamb Shoulder Slices'],
      rating: 5,
      comment: 'The coconut broth was a revelation — creamy, fragrant, and perfectly balanced. The lamb was tender and delicious. Will definitely order again!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _PageHeader(title: 'My Reviews', icon: '⭐'),
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                    child: Row(
                      children: [
                        Text(
                          '${_reviews.length} reviews',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        _RatingSummary(reviews: _reviews),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _ReviewCard(review: _reviews[i]),
                      childCount: _reviews.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingSummary extends StatelessWidget {
  const _RatingSummary({required this.reviews});
  final List<_Review> reviews;

  double get avg =>
      reviews.fold(0.0, (s, r) => s + r.rating) / reviews.length;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          avg.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.foreground,
          ),
        ),
        const SizedBox(width: 4),
        ...List.generate(
          5,
          (i) => Icon(
            i < avg.round() ? Icons.star_rounded : Icons.star_outline_rounded,
            size: 14,
            color: AppColors.secondary,
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          'avg',
          style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final _Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID + date
          Row(
            children: [
              Expanded(
                child: Text(
                  review.orderId,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Text(
                review.date,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Items
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: review.items
                .map((item) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          // Stars
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                i < review.rating
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                size: 18,
                color: AppColors.secondary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Comment
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.foreground,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          // Edit button
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.edit_outlined,
                    size: 13, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                const Text(
                  'Edit Review',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Review {
  final String orderId;
  final String date;
  final List<String> items;
  final int rating;
  final String comment;

  const _Review({
    required this.orderId,
    required this.date,
    required this.items,
    required this.rating,
    required this.comment,
  });
}

// ── Shared header ─────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title, required this.icon});
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.borderDivider),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      size: 16, color: AppColors.foreground),
                ),
              ),
              const SizedBox(width: 12),
              Text(icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
