import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

class LoyaltyPage extends StatelessWidget {
  const LoyaltyPage({super.key});

  static const int _points = 1250;
  static const int _nextTier = 2000;
  static const String _tier = 'Gold';
  static const String _nextTierName = 'Platinum';

  static const _history = [
    _PointEntry(type: 'earn', label: 'Order CDH-20240812-0031', points: 185, date: '12 Aug 2026'),
    _PointEntry(type: 'earn', label: 'Order CDH-20240805-0018', points: 120, date: '5 Aug 2026'),
    _PointEntry(type: 'redeem', label: 'Redeemed: LOYALTY10K voucher', points: -500, date: '1 Aug 2026'),
    _PointEntry(type: 'earn', label: 'Order CDH-20240728-0009', points: 210, date: '28 Jul 2026'),
    _PointEntry(type: 'earn', label: 'Birthday bonus', points: 200, date: '15 Jul 2026'),
    _PointEntry(type: 'redeem', label: 'Redeemed: Free Delivery voucher', points: -300, date: '10 Jul 2026'),
  ];

  static const _rewards = [
    _Reward(emoji: '🎟️', title: 'Rp 10.000 Cashback', points: 500, available: true),
    _Reward(emoji: '🛵', title: 'Free Delivery', points: 300, available: true),
    _Reward(emoji: '🥩', title: 'Free Wagyu Upgrade', points: 800, available: false),
    _Reward(emoji: '🎂', title: 'Free Birthday Dessert', points: 1000, available: false),
    _Reward(emoji: '👑', title: 'VIP Table Reservation', points: 2000, available: false),
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
          _PageHeader(title: 'Loyalty & Rewards', icon: '👑'),
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                // Points card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: _PointsCard(
                      points: _points,
                      tier: _tier,
                      nextTier: _nextTierName,
                      nextTierPoints: _nextTier,
                    ),
                  ),
                ),

                // Rewards header
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(
                      'REDEEM REWARDS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textSecondary,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                // Rewards list
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _RewardCard(
                        reward: _rewards[i],
                        userPoints: _points,
                      ),
                      childCount: _rewards.length,
                    ),
                  ),
                ),

                // History header
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(
                      'POINTS HISTORY',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textSecondary,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                // History list
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _HistoryTile(entry: _history[i]),
                      childCount: _history.length,
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

class _PointsCard extends StatelessWidget {
  const _PointsCard({
    required this.points,
    required this.tier,
    required this.nextTier,
    required this.nextTierPoints,
  });

  final int points;
  final String tier;
  final String nextTier;
  final int nextTierPoints;

  double get _progress => points / nextTierPoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9A0B17), Color(0xFFD4AF37)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('👑', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                '$tier Member',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Budi Santoso',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '$points pts',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${nextTierPoints - points} pts to $nextTier',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$tier',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              Text(
                '$nextTier ($nextTierPoints pts)',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({required this.reward, required this.userPoints});
  final _Reward reward;
  final int userPoints;

  bool get _canRedeem => userPoints >= reward.points;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderDivider),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _canRedeem ? AppColors.primaryBg : AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(reward.emoji,
                  style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _canRedeem
                        ? AppColors.foreground
                        : AppColors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.stars_rounded,
                        size: 12, color: AppColors.secondary),
                    const SizedBox(width: 3),
                    Text(
                      '${reward.points} pts',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _canRedeem ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _canRedeem ? AppColors.primary : AppColors.borderDivider,
              disabledBackgroundColor: AppColors.borderDivider,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              _canRedeem ? 'Redeem' : 'Locked',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _canRedeem ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.entry});
  final _PointEntry entry;

  @override
  Widget build(BuildContext context) {
    final isEarn = entry.type == 'earn';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDivider),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isEarn
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isEarn ? Icons.add_rounded : Icons.remove_rounded,
              size: 18,
              color: isEarn ? const Color(0xFF059669) : Colors.red,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.foreground,
                  ),
                ),
                Text(
                  entry.date,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isEarn ? '+' : ''}${entry.points} pts',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isEarn ? const Color(0xFF059669) : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _Reward {
  final String emoji;
  final String title;
  final int points;
  final bool available;

  const _Reward({
    required this.emoji,
    required this.title,
    required this.points,
    required this.available,
  });
}

class _PointEntry {
  final String type;
  final String label;
  final int points;
  final String date;

  const _PointEntry({
    required this.type,
    required this.label,
    required this.points,
    required this.date,
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
