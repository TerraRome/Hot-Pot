import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

class PromoVouchersPage extends StatefulWidget {
  const PromoVouchersPage({super.key});

  @override
  State<PromoVouchersPage> createState() => _PromoVouchersPageState();
}

class _PromoVouchersPageState extends State<PromoVouchersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  static const _promos = [
    _Promo(
      code: 'DRAGON50',
      title: '50% Off First Order',
      desc: 'Get 50% discount on your first order. Max discount Rp 75.000.',
      expiry: '31 Aug 2026',
      color: Color(0xFF9A0B17),
      emoji: '🔥',
      minOrder: 100000,
      maxDiscount: 75000,
      isPercent: true,
      value: 50,
    ),
    _Promo(
      code: 'WAGYU25',
      title: '25% Off Wagyu Items',
      desc: 'Valid for all wagyu beef selections. Min. order Rp 150.000.',
      expiry: '15 Sep 2026',
      color: Color(0xFFD4AF37),
      emoji: '🥩',
      minOrder: 150000,
      maxDiscount: 50000,
      isPercent: true,
      value: 25,
    ),
    _Promo(
      code: 'FREEDELIVERY',
      title: 'Free Delivery',
      desc: 'Free delivery for orders above Rp 80.000.',
      expiry: '30 Sep 2026',
      color: Color(0xFF059669),
      emoji: '🛵',
      minOrder: 80000,
      maxDiscount: 20000,
      isPercent: false,
      value: 20000,
    ),
  ];

  static const _vouchers = [
    _Promo(
      code: 'BIRTHDAY20',
      title: 'Birthday Voucher',
      desc: 'Happy Birthday! Enjoy 20% off any order this month.',
      expiry: '31 Aug 2026',
      color: Color(0xFF7C3AED),
      emoji: '🎂',
      minOrder: 50000,
      maxDiscount: 30000,
      isPercent: true,
      value: 20,
    ),
    _Promo(
      code: 'LOYALTY10K',
      title: 'Loyalty Reward',
      desc: 'Redeemed from 500 loyalty points. Rp 10.000 cashback.',
      expiry: '14 Sep 2026',
      color: Color(0xFFD97706),
      emoji: '⭐',
      minOrder: 0,
      maxDiscount: 10000,
      isPercent: false,
      value: 10000,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _PageHeader(title: 'Promo & Vouchers', icon: '🎟️'),
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tab,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 2.5,
              labelStyle: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700),
              tabs: const [
                Tab(text: 'Promos'),
                Tab(text: 'My Vouchers'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _PromoList(items: _promos),
                _PromoList(items: _vouchers, isVoucher: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoList extends StatelessWidget {
  const _PromoList({required this.items, this.isVoucher = false});
  final List<_Promo> items;
  final bool isVoucher;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        if (!isVoucher)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter promo code',
                        hintStyle: const TextStyle(
                            fontSize: 13, color: AppColors.textSecondary),
                        prefixIcon: const Icon(Icons.confirmation_number_outlined,
                            size: 18, color: AppColors.textSecondary),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.borderDivider),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.borderDivider),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.primary),
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Apply',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => _PromoCard(promo: items[i]),
              childCount: items.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({required this.promo});
  final _Promo promo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderDivider),
      ),
      child: Column(
        children: [
          // Header band
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: promo.color.withValues(alpha: 0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Text(promo.emoji,
                    style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promo.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: promo.color,
                        ),
                      ),
                      Text(
                        'Expires ${promo.expiry}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: promo.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    promo.isPercent
                        ? '${promo.value.toInt()}% OFF'
                        : 'Rp ${_fmt(promo.value.toInt())}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promo.desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (promo.minOrder > 0) ...[
                      const Icon(Icons.shopping_bag_outlined,
                          size: 12, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        'Min. Rp ${_fmt(promo.minOrder)}',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textSecondary),
                      ),
                      const SizedBox(width: 12),
                    ],
                    const Icon(Icons.discount_outlined,
                        size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      'Max Rp ${_fmt(promo.maxDiscount)}',
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const Spacer(),
                    // Code chip
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              promo.code,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.copy_outlined,
                                size: 11, color: AppColors.primary),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Promo {
  final String code;
  final String title;
  final String desc;
  final String expiry;
  final Color color;
  final String emoji;
  final int minOrder;
  final int maxDiscount;
  final bool isPercent;
  final double value;

  const _Promo({
    required this.code,
    required this.title,
    required this.desc,
    required this.expiry,
    required this.color,
    required this.emoji,
    required this.minOrder,
    required this.maxDiscount,
    required this.isPercent,
    required this.value,
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

String _fmt(int value) {
  final s = value.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return buf.toString();
}
