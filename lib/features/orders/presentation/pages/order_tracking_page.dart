import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Header ───────────────────────────────────────────────────
          _OrderHeader(tabController: _tabController),
          // ── Tab content ───────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const ClampingScrollPhysics(),
              children: const [
                _ActiveOrdersTab(),
                _OrderHistoryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Container(height: 20, color: AppColors.background),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 16),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        '🐉',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Orders',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Track your hot pot journey',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xCCFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_outlined,
                            color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ),
                // Tab bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: TabBar(
                      controller: tabController,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: Colors.white,
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(text: 'Active Orders'),
                        Tab(text: 'History'),
                      ],
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

// ── Active Orders Tab ─────────────────────────────────────────────────────────

class _ActiveOrdersTab extends StatelessWidget {
  const _ActiveOrdersTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      children: const [
        // Live tracking card
        _LiveTrackingCard(),
        SizedBox(height: 16),
        // Active order card
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _ActiveOrderCard(
            orderId: '#HP-2408-0042',
            status: _OrderStatus.preparing,
            items: ['Sichuan Spicy Broth x1', 'Wagyu Beef Slices x2'],
            total: 'Rp 305.000',
            estimatedTime: '15-20 min',
            placedTime: '14:32',
          ),
        ),
      ],
    );
  }
}

// ── Live Tracking Card ────────────────────────────────────────────────────────

class _LiveTrackingCard extends StatelessWidget {
  const _LiveTrackingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9A0B17), Color(0xFFB31B27)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order in Progress',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '#HP-2408-0042',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xCCFFFFFF),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 12, color: AppColors.secondaryText),
                    SizedBox(width: 4),
                    Text(
                      '15-20 min',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Progress steps
          _OrderProgressSteps(),
          const SizedBox(height: 20),
          // Contact rider
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('🏍️', style: TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Budi Santoso',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Your delivery rider',
                        style: TextStyle(
                            fontSize: 11, color: Color(0xCCFFFFFF)),
                      ),
                    ],
                  ),
                ),
                _ContactButton(
                    icon: Icons.phone_outlined, onTap: () {}),
                const SizedBox(width: 8),
                _ContactButton(
                    icon: Icons.chat_bubble_outline, onTap: () {}),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Track live button
          GestureDetector(
            onTap: () => context.push('/live-tracking'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.my_location_rounded,
                      size: 15, color: AppColors.primary),
                  SizedBox(width: 6),
                  Text(
                    'Track Live',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
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

class _ContactButton extends StatelessWidget {
  const _ContactButton({required this.icon, required this.onTap});
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
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

// ── Order Progress Steps ──────────────────────────────────────────────────────

class _OrderProgressSteps extends StatelessWidget {
  final List<_ProgressStep> _steps = const [
    _ProgressStep(
        icon: '✅', label: 'Confirmed', sublabel: '14:32', done: true),
    _ProgressStep(
        icon: '🍳', label: 'Preparing', sublabel: '~15 min', done: true, active: true),
    _ProgressStep(
        icon: '🏍️', label: 'On the Way', sublabel: 'Soon', done: false),
    _ProgressStep(
        icon: '🏠', label: 'Delivered', sublabel: '--:--', done: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          final stepIndex = i ~/ 2;
          final isDone = _steps[stepIndex].done;
          return Expanded(
            child: Container(
              height: 2,
              color: isDone
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.3),
            ),
          );
        }
        final step = _steps[i ~/ 2];
        return _ProgressStepItem(step: step);
      }),
    );
  }
}

class _ProgressStep {
  final String icon;
  final String label;
  final String sublabel;
  final bool done;
  final bool active;

  const _ProgressStep({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.done,
    this.active = false,
  });
}

class _ProgressStepItem extends StatelessWidget {
  const _ProgressStepItem({required this.step});
  final _ProgressStep step;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: step.done
                ? Colors.white
                : Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: step.active
                ? Border.all(color: AppColors.secondary, width: 2)
                : null,
          ),
          child: Center(
            child: Text(step.icon, style: const TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          step.label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color:
                step.done ? Colors.white : Colors.white.withValues(alpha: 0.6),
          ),
        ),
        Text(
          step.sublabel,
          style: TextStyle(
            fontSize: 8,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

// ── Active Order Card ─────────────────────────────────────────────────────────

enum _OrderStatus { confirmed, preparing, onTheWay, delivered }

class _ActiveOrderCard extends StatelessWidget {
  const _ActiveOrderCard({
    required this.orderId,
    required this.status,
    required this.items,
    required this.total,
    required this.estimatedTime,
    required this.placedTime,
  });

  final String orderId;
  final _OrderStatus status;
  final List<String> items;
  final String total;
  final String estimatedTime;
  final String placedTime;

  String get _statusLabel => switch (status) {
        _OrderStatus.confirmed => 'Confirmed',
        _OrderStatus.preparing => 'Preparing',
        _OrderStatus.onTheWay => 'On the Way',
        _OrderStatus.delivered => 'Delivered',
      };

  Color get _statusColor => switch (status) {
        _OrderStatus.confirmed => AppColors.info,
        _OrderStatus.preparing => AppColors.warning,
        _OrderStatus.onTheWay => AppColors.success,
        _OrderStatus.delivered => AppColors.textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Header row
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderId,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.foreground,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _statusLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderDivider),
          // Items
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.fiber_manual_record,
                            size: 6, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.foreground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _InfoChip(
                      icon: Icons.access_time,
                      label: estimatedTime,
                    ),
                    const SizedBox(width: 8),
                    _InfoChip(
                      icon: Icons.schedule,
                      label: 'Placed $placedTime',
                    ),
                    const Spacer(),
                    Text(
                      total,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryBg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Icon(icon, size: 11, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Order History Tab ─────────────────────────────────────────────────────────

class _OrderHistoryTab extends StatelessWidget {
  const _OrderHistoryTab();

  static const List<_HistoryOrder> _orders = [
    _HistoryOrder(
      orderId: '#HP-2408-0038',
      date: 'Aug 12, 2026',
      items: ['Dragon Set Menu x1', 'Tiger Prawn Set x1'],
      total: 'Rp 394.000',
      rating: 5,
    ),
    _HistoryOrder(
      orderId: '#HP-2408-0031',
      date: 'Aug 10, 2026',
      items: ['Sichuan Spicy Broth x2', 'Garden Veggie Platter x1'],
      total: 'Rp 175.000',
      rating: 4,
    ),
    _HistoryOrder(
      orderId: '#HP-2407-0098',
      date: 'Jul 28, 2026',
      items: ['Mushroom Clear Broth x1', 'Wagyu Beef Slices x3'],
      total: 'Rp 415.000',
      rating: 5,
    ),
    _HistoryOrder(
      orderId: '#HP-2407-0076',
      date: 'Jul 20, 2026',
      items: ['Family Set 4 Pax x1'],
      total: 'Rp 520.000',
      rating: 4,
    ),
    _HistoryOrder(
      orderId: '#HP-2407-0054',
      date: 'Jul 14, 2026',
      items: ['Dragon Set Menu x2', 'Tiger Prawn Set x2'],
      total: 'Rp 788.000',
      rating: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: _orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _HistoryOrderCard(order: _orders[i]),
    );
  }
}

class _HistoryOrder {
  final String orderId;
  final String date;
  final List<String> items;
  final String total;
  final int rating;

  const _HistoryOrder({
    required this.orderId,
    required this.date,
    required this.items,
    required this.total,
    required this.rating,
  });
}

class _HistoryOrderCard extends StatelessWidget {
  const _HistoryOrderCard({required this.order});
  final _HistoryOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderDivider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderId,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.foreground,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order.date,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Delivered',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderDivider),
          // Items + actions
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...order.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: [
                        const Icon(Icons.fiber_manual_record,
                            size: 6, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.foreground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Star rating
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < order.rating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 14,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      order.total,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Reorder button
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.replay_rounded, size: 16),
                    label: const Text('Order Again'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
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

// ── Wavy clipper ──────────────────────────────────────────────────────────────

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
