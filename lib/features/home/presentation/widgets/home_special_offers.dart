import 'package:flutter/material.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

/// Horizontal scrollable row of special offer cards.
class HomeSpecialOffers extends StatelessWidget {
  const HomeSpecialOffers({super.key});

  static const List<_Offer> _offers = [
    _Offer(
      emoji: '🎁',
      title: 'Free Broth Upgrade',
      subtitle: 'Orders above Rp 150k',
      tag: 'LIMITED',
    ),
    _Offer(
      emoji: '👨‍👩‍👧‍👦',
      title: 'Family Set 4 Pax',
      subtitle: 'Save Rp 80.000',
      tag: 'BUNDLE',
    ),
    _Offer(
      emoji: '⏰',
      title: 'Happy Hour 2–5PM',
      subtitle: '20% off all drinks',
      tag: 'TODAY',
    ),
    _Offer(
      emoji: '🏆',
      title: 'Loyalty Points x2',
      subtitle: 'Every Friday',
      tag: 'MEMBER',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Special Offers',
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
          SizedBox(
            height: 110,
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _offers.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) => _OfferCard(offer: _offers[i]),
          ),
        ),
      ],
    );
  }
}

class _Offer {
  final String emoji;
  final String title;
  final String subtitle;
  final String tag;

  const _Offer({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.tag,
  });
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.offer});
  final _Offer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(offer.emoji, style: const TextStyle(fontSize: 22)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBg,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                      color: AppColors.secondary.withValues(alpha: 0.5)),
                ),
                child: Text(
                  offer.tag,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryActive,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            offer.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            offer.subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
