import 'package:flutter/material.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

/// Promo banner carousel.
class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key});

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  int _current = 0;
  final PageController _controller = PageController();

  final List<_BannerData> _banners = const [
    _BannerData(
      tag: 'SPECIAL OFFER',
      title: '30% OFF\nFirst Order',
      subtitle: 'Use code DRAGON30 at checkout',
      emoji: '🔥',
      gradient: [Color(0xFF9A0B17), Color(0xFFB31B27)],
    ),
    _BannerData(
      tag: 'NEW ARRIVAL',
      title: 'Sichuan\nSpicy Broth',
      subtitle: 'Authentic numbing spice blend',
      emoji: '🌶️',
      gradient: [Color(0xFFB08D1E), Color(0xFFD4AF37)],
    ),
    _BannerData(
      tag: 'WEEKEND DEAL',
      title: 'Free Dessert\nWith Set Menu',
      subtitle: 'Saturday & Sunday only',
      emoji: '🍮',
      gradient: [Color(0xFF7A050E), Color(0xFF9A0B17)],
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          SizedBox(
            height: 140,
            child: PageView.builder(
              physics: const ClampingScrollPhysics(),
              controller: _controller,
            onPageChanged: (i) => setState(() => _current = i),
            itemCount: _banners.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _BannerCard(data: _banners[i]),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == _current ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == _current
                    ? AppColors.primary
                    : AppColors.primaryMuted,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerData {
  final String tag;
  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> gradient;

  const _BannerData({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.gradient,
  });
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.data});
  final _BannerData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: data.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    data.tag,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryText,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          Text(data.emoji, style: const TextStyle(fontSize: 48)),
        ],
      ),
    );
  }
}
