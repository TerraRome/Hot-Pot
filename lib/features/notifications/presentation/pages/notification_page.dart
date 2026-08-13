import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  static const _notifications = [
    _Notif(
      type: _NotifType.order,
      title: 'Order Confirmed!',
      body: 'Your order #CDH-20240813-0042 has been confirmed and is being prepared.',
      time: '2 min ago',
      isRead: false,
    ),
    _Notif(
      type: _NotifType.promo,
      title: '🔥 Flash Sale — 30% Off Wagyu',
      body: 'Limited time offer. Use code WAGYU30 at checkout. Valid until midnight.',
      time: '1 hr ago',
      isRead: false,
    ),
    _Notif(
      type: _NotifType.order,
      title: 'Rider On The Way',
      body: 'Ahmad is heading to your location. Estimated arrival in 12 minutes.',
      time: '1 hr ago',
      isRead: false,
    ),
    _Notif(
      type: _NotifType.promo,
      title: 'New Menu Alert 🍜',
      body: 'Hand-pulled Noodles are back! Order now before they sell out.',
      time: '3 hr ago',
      isRead: true,
    ),
    _Notif(
      type: _NotifType.system,
      title: 'Review Your Last Order',
      body: 'How was your experience? Share your feedback and earn 50 points.',
      time: 'Yesterday',
      isRead: true,
    ),
    _Notif(
      type: _NotifType.order,
      title: 'Order Delivered',
      body: 'Order #CDH-20240812-0031 has been delivered. Enjoy your meal!',
      time: 'Yesterday',
      isRead: true,
    ),
    _Notif(
      type: _NotifType.promo,
      title: 'Weekend Special 🐉',
      body: 'Get a complimentary dragon broth upgrade every Saturday & Sunday.',
      time: '2 days ago',
      isRead: true,
    ),
    _Notif(
      type: _NotifType.system,
      title: 'Points Earned',
      body: 'You earned 240 Dragon Points from your last order. Total: 12,000 pts.',
      time: '3 days ago',
      isRead: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  List<_Notif> _filtered(String tab) {
    switch (tab) {
      case 'Orders':
        return _notifications
            .where((n) => n.type == _NotifType.order)
            .toList();
      case 'Promos':
        return _notifications
            .where((n) => n.type == _NotifType.promo)
            .toList();
      default:
        return _notifications;
    }
  }

  int get _unreadCount =>
      _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _NotifHeader(unreadCount: _unreadCount),
          _TabRow(controller: _tabCtrl),
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              physics: const ClampingScrollPhysics(),
              children: ['All', 'Orders', 'Promos'].map((tab) {
                final items = _filtered(tab);
                if (items.isEmpty) return _EmptyState(tab: tab);
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  itemCount: items.length,
                  itemBuilder: (context, i) => _NotifCard(notif: items[i]),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _NotifHeader extends StatelessWidget {
  const _NotifHeader({required this.unreadCount});
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
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
              const Text('🔔', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              if (unreadCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$unreadCount unread',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Tab row ───────────────────────────────────────────────────────────────────

class _TabRow extends StatelessWidget {
  const _TabRow({required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: TabBar(
        controller: controller,
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Orders'),
          Tab(text: 'Promos'),
        ],
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        labelStyle: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.w400),
        indicatorColor: AppColors.secondary,
        indicatorWeight: 3,
        dividerColor: Colors.transparent,
      ),
    );
  }
}

// ── Notification card ─────────────────────────────────────────────────────────

class _NotifCard extends StatelessWidget {
  const _NotifCard({required this.notif});
  final _Notif notif;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: notif.isRead ? AppColors.surface : AppColors.primaryBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: notif.isRead
              ? AppColors.borderDivider
              : AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: notif.isRead
                  ? AppColors.background
                  : AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                notif.type.emoji,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notif.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: notif.isRead
                              ? FontWeight.w500
                              : FontWeight.w700,
                          color: AppColors.foreground,
                        ),
                      ),
                    ),
                    if (!notif.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notif.body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  notif.time,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
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

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.tab});
  final String tab;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔔', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            'No $tab notifications',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Check back later for updates',
            style: TextStyle(
                fontSize: 13, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

enum _NotifType {
  order,
  promo,
  system;

  String get emoji {
    switch (this) {
      case _NotifType.order:
        return '🛵';
      case _NotifType.promo:
        return '🎁';
      case _NotifType.system:
        return '⭐';
    }
  }
}

class _Notif {
  final _NotifType type;
  final String title;
  final String body;
  final String time;
  final bool isRead;

  const _Notif({
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });
}
