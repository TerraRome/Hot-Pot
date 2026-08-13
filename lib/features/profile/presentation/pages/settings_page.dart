import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Notifications
  bool _pushOrders = true;
  bool _pushPromos = true;
  bool _pushUpdates = false;
  bool _emailReceipts = true;
  bool _emailNewsletter = false;

  // Preferences
  bool _saveHistory = true;
  bool _locationAlways = false;

  // Privacy
  bool _analytics = true;
  bool _personalized = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _PageHeader(title: 'Settings', icon: '⚙️'),
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                // Notifications
                _SectionHeader(label: 'NOTIFICATIONS'),
                _ToggleSection(children: [
                  _ToggleTile(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Order Updates',
                    subtitle: 'Confirmation, tracking & delivery alerts',
                    value: _pushOrders,
                    onChanged: (v) => setState(() => _pushOrders = v),
                  ),
                  _ToggleTile(
                    icon: Icons.local_offer_outlined,
                    title: 'Promos & Offers',
                    subtitle: 'Exclusive deals and new vouchers',
                    value: _pushPromos,
                    onChanged: (v) => setState(() => _pushPromos = v),
                  ),
                  _ToggleTile(
                    icon: Icons.campaign_outlined,
                    title: 'App Updates',
                    subtitle: 'New features and announcements',
                    value: _pushUpdates,
                    onChanged: (v) => setState(() => _pushUpdates = v),
                  ),
                ]),

                // Email
                _SectionHeader(label: 'EMAIL'),
                _ToggleSection(children: [
                  _ToggleTile(
                    icon: Icons.receipt_outlined,
                    title: 'Order Receipts',
                    subtitle: 'Invoice sent to your email after each order',
                    value: _emailReceipts,
                    onChanged: (v) => setState(() => _emailReceipts = v),
                  ),
                  _ToggleTile(
                    icon: Icons.mail_outline_rounded,
                    title: 'Newsletter',
                    subtitle: 'Weekly menu highlights and recipes',
                    value: _emailNewsletter,
                    onChanged: (v) => setState(() => _emailNewsletter = v),
                  ),
                ]),

                // Preferences
                _SectionHeader(label: 'PREFERENCES'),
                _ToggleSection(children: [
                  _ToggleTile(
                    icon: Icons.history_rounded,
                    title: 'Save Order History',
                    subtitle: 'Remember past orders for quick reorder',
                    value: _saveHistory,
                    onChanged: (v) => setState(() => _saveHistory = v),
                  ),
                  _ToggleTile(
                    icon: Icons.location_on_outlined,
                    title: 'Always-on Location',
                    subtitle: 'Allow location access in background',
                    value: _locationAlways,
                    onChanged: (v) => setState(() => _locationAlways = v),
                  ),
                ]),

                // Privacy
                _SectionHeader(label: 'PRIVACY'),
                _ToggleSection(children: [
                  _ToggleTile(
                    icon: Icons.bar_chart_rounded,
                    title: 'Usage Analytics',
                    subtitle: 'Help improve the app with anonymous data',
                    value: _analytics,
                    onChanged: (v) => setState(() => _analytics = v),
                  ),
                  _ToggleTile(
                    icon: Icons.tune_rounded,
                    title: 'Personalized Experience',
                    subtitle: 'Recommendations based on your preferences',
                    value: _personalized,
                    onChanged: (v) => setState(() => _personalized = v),
                  ),
                ]),

                // Account actions
                _SectionHeader(label: 'ACCOUNT'),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _ActionTile(
                          icon: Icons.download_outlined,
                          title: 'Download My Data',
                          subtitle: 'Export all your account data',
                          onTap: () {},
                          color: AppColors.foreground,
                        ),
                        const SizedBox(height: 8),
                        _ActionTile(
                          icon: Icons.lock_reset_outlined,
                          title: 'Change Password',
                          subtitle: 'Update your account password',
                          onTap: () {},
                          color: AppColors.foreground,
                        ),
                        const SizedBox(height: 8),
                        _ActionTile(
                          icon: Icons.delete_forever_outlined,
                          title: 'Delete Account',
                          subtitle: 'Permanently remove your account',
                          onTap: () => _confirmDelete(context),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),

                // Version
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 32),
                    child: Column(
                      children: const [
                        Text(
                          'Crimson Dragon Hot Pot',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Version 1.0.0 (Build 7)',
                          style: TextStyle(
                              fontSize: 11, color: AppColors.textSecondary),
                        ),
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

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
            'This will permanently delete your account and all data. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/signin');
            },
            child: const Text('Delete',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class _ToggleSection extends StatelessWidget {
  const _ToggleSection({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderDivider),
          ),
          child: Column(
            children: children
                .expand((w) => [
                      w,
                      if (w != children.last)
                        const Divider(
                            height: 1,
                            indent: 56,
                            color: AppColors.borderDivider),
                    ])
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primaryBg,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
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
                color: color == Colors.red
                    ? const Color(0xFFFEE2E2)
                    : AppColors.primaryBg,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
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
