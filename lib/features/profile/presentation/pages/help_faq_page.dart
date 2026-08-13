import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

class HelpFaqPage extends StatefulWidget {
  const HelpFaqPage({super.key});

  @override
  State<HelpFaqPage> createState() => _HelpFaqPageState();
}

class _HelpFaqPageState extends State<HelpFaqPage> {
  int? _expanded;
  String _search = '';

  static const _faqs = [
    _Faq(
      category: 'Orders',
      question: 'How do I place an order?',
      answer:
          'Browse our menu, tap on any item to view details, then tap "Add to Cart". When ready, go to your cart and tap "Checkout". Fill in your delivery details and payment method, then confirm your order.',
    ),
    _Faq(
      category: 'Orders',
      question: 'Can I modify my order after placing it?',
      answer:
          'Orders can only be modified within 2 minutes of placing them. After that, the kitchen begins preparation. Contact support immediately if you need to make changes.',
    ),
    _Faq(
      category: 'Orders',
      question: 'How do I cancel an order?',
      answer:
          'Go to Orders, select the order you want to cancel, and tap "Cancel Order". Cancellation is only possible before the order is confirmed by the restaurant. Refunds are processed within 1-3 business days.',
    ),
    _Faq(
      category: 'Delivery',
      question: 'What are the delivery hours?',
      answer:
          'We deliver daily from 11:00 AM to 10:00 PM. Last orders are accepted at 9:30 PM. Delivery times may vary depending on your location and order volume.',
    ),
    _Faq(
      category: 'Delivery',
      question: 'How long does delivery take?',
      answer:
          'Average delivery time is 30-45 minutes depending on your location and current order volume. You can track your order in real-time from the Orders page.',
    ),
    _Faq(
      category: 'Delivery',
      question: 'Is there a minimum order for delivery?',
      answer:
          'Yes, the minimum order for delivery is Rp 80.000. Orders below this amount may incur an additional small order fee.',
    ),
    _Faq(
      category: 'Payment',
      question: 'What payment methods are accepted?',
      answer:
          'We accept GoPay, OVO, Dana, bank transfer (BCA, Mandiri, BNI, BRI), credit/debit cards (Visa, Mastercard), and Cash on Delivery.',
    ),
    _Faq(
      category: 'Payment',
      question: 'How do I use a promo code?',
      answer:
          'During checkout, tap "Add Promo Code" and enter your code. Valid codes will show the discount applied to your order. One promo code can be used per order.',
    ),
    _Faq(
      category: 'Account',
      question: 'How do I reset my password?',
      answer:
          'On the Sign In page, tap "Forgot Password". Enter your registered email or phone number and we will send an OTP code to reset your password.',
    ),
    _Faq(
      category: 'Account',
      question: 'How do I earn loyalty points?',
      answer:
          'You earn 1 point for every Rp 1.000 spent. Points can be redeemed for vouchers, free items, or discounts. Check your points balance in the Loyalty & Rewards section of your profile.',
    ),
  ];

  List<_Faq> get _filtered {
    if (_search.isEmpty) return _faqs;
    final q = _search.toLowerCase();
    return _faqs
        .where((f) =>
            f.question.toLowerCase().contains(q) ||
            f.answer.toLowerCase().contains(q))
        .toList();
  }

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
    final filtered = _filtered;
    final categories = filtered.map((f) => f.category).toSet().toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _PageHeader(title: 'Help & FAQ', icon: '❓'),
          // Search bar
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              decoration: InputDecoration(
                hintText: 'Search questions...',
                hintStyle: const TextStyle(
                    fontSize: 13, color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.search_rounded,
                    size: 18, color: AppColors.textSecondary),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderDivider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderDivider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                filled: true,
                fillColor: AppColors.background,
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                if (filtered.isEmpty)
                  const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('🔍',
                              style: TextStyle(fontSize: 40)),
                          SizedBox(height: 12),
                          Text('No results found',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  )
                else
                  ...categories.expand((cat) {
                    final items =
                        filtered.where((f) => f.category == cat).toList();
                    return [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            cat.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textSecondary,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, i) {
                              final faq = items[i];
                              final idx = _faqs.indexOf(faq);
                              return _FaqTile(
                                faq: faq,
                                isExpanded: _expanded == idx,
                                onTap: () => setState(() =>
                                    _expanded = _expanded == idx ? null : idx),
                              );
                            },
                            childCount: items.length,
                          ),
                        ),
                      ),
                    ];
                  }),
                // Contact support
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Still need help?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.foreground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Our support team is available 9AM–9PM daily.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.chat_outlined,
                                      size: 14, color: AppColors.primary),
                                  label: const Text('Live Chat',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary)),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: AppColors.primary),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.email_outlined,
                                      size: 14, color: Colors.white),
                                  label: const Text('Email Us',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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

class _FaqTile extends StatelessWidget {
  const _FaqTile({
    required this.faq,
    required this.isExpanded,
    required this.onTap,
  });

  final _Faq faq;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isExpanded ? AppColors.primary : AppColors.borderDivider,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      faq.question,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isExpanded
                            ? AppColors.primary
                            : AppColors.foreground,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: isExpanded
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ],
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: Text(
                  faq.answer,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Faq {
  final String category;
  final String question;
  final String answer;

  const _Faq({
    required this.category,
    required this.question,
    required this.answer,
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
