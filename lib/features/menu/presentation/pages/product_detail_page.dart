import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

/// Data model for a menu product passed via route extra.
class ProductDetailArgs {
  final String emoji;
  final String name;
  final String description;
  final int price;
  final int spicyLevel; // 0-3
  final double rating;
  final int reviews;
  final String? badge;

  const ProductDetailArgs({
    required this.emoji,
    required this.name,
    required this.description,
    required this.price,
    required this.spicyLevel,
    required this.rating,
    required this.reviews,
    this.badge,
  });
}

class ProductDetailPage extends StatefulWidget {
  final ProductDetailArgs args;
  const ProductDetailPage({super.key, required this.args});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _qty = 1;
  bool _isFavorite = false;
  int _spicySelected = 1; // 0=mild 1=medium 2=hot
  final TextEditingController _notesController = TextEditingController();

  int get _totalPrice => widget.args.price * _qty;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = widget.args;

    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── Scrollable content ──────────────────────────────────────
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero image area ─────────────────────────────────
                _HeroSection(
                  emoji: args.emoji,
                  badge: args.badge,
                  isFavorite: _isFavorite,
                  onFavoriteTap: () =>
                      setState(() => _isFavorite = !_isFavorite),
                ),
                // ── Content card pulled up over hero ─────────────────
                Transform.translate(
                  offset: const Offset(0, -24),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title + rating row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                args.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.foreground,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryBg,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                    color: AppColors.secondary
                                        .withValues(alpha: 0.4)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star_rounded,
                                      size: 14, color: AppColors.secondary),
                                  const SizedBox(width: 3),
                                  Text(
                                    args.rating.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.foreground,
                                    ),
                                  ),
                                  Text(
                                    ' (${_fmtReviews(args.reviews)})',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Price
                        Text(
                          'Rp ${_fmt(args.price)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Description
                        Text(
                          args.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                            height: 1, color: AppColors.borderDivider),
                        const SizedBox(height: 20),

                        // ── Spicy level ───────────────────────────────
                        _SectionLabel(label: 'Spicy Level'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _SpicyOption(
                              label: 'Mild',
                              emoji: '🌿',
                              level: 0,
                              selected: _spicySelected == 0,
                              onTap: () =>
                                  setState(() => _spicySelected = 0),
                            ),
                            const SizedBox(width: 8),
                            _SpicyOption(
                              label: 'Medium',
                              emoji: '🌶️',
                              level: 1,
                              selected: _spicySelected == 1,
                              onTap: () =>
                                  setState(() => _spicySelected = 1),
                            ),
                            const SizedBox(width: 8),
                            _SpicyOption(
                              label: 'Hot',
                              emoji: '🔥',
                              level: 2,
                              selected: _spicySelected == 2,
                              onTap: () =>
                                  setState(() => _spicySelected = 2),
                            ),
                            const SizedBox(width: 8),
                            _SpicyOption(
                              label: 'Extra',
                              emoji: '💀',
                              level: 3,
                              selected: _spicySelected == 3,
                              onTap: () =>
                                  setState(() => _spicySelected = 3),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                            height: 1, color: AppColors.borderDivider),
                        const SizedBox(height: 20),

                        // ── Spicy indicator flames ────────────────────
                        Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'Heat Level',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.foreground,
                                ),
                              ),
                            ),
                            ...List.generate(
                              3,
                              (i) => Icon(
                                Icons.local_fire_department_rounded,
                                size: 22,
                                color: i < args.spicyLevel
                                    ? AppColors.danger
                                    : const Color(0xFFD1D5DB),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                            height: 1, color: AppColors.borderDivider),
                        const SizedBox(height: 20),

                        // ── Notes ─────────────────────────────────────
                        _SectionLabel(label: 'Notes (Optional)'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _notesController,
                          decoration: InputDecoration(
                            hintText:
                                'e.g., no spice, less oil, extra napkins...',
                            hintStyle: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF9FAFB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColors.border),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColors.primary, width: 1.5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                          ),
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.foreground),
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                            height: 1, color: AppColors.borderDivider),
                        const SizedBox(height: 20),

                        // ── Quantity ──────────────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _SectionLabel(label: 'Quantity'),
                            _QtyStepper(
                              qty: _qty,
                              onDecrement: () {
                                if (_qty > 1) {
                                  setState(() => _qty--);
                                }
                              },
                              onIncrement: () => setState(() => _qty++),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                            height: 1, color: AppColors.borderDivider),
                        const SizedBox(height: 20),

                        // ── Related items ─────────────────────────────
                        const _RelatedItems(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Floating back + favorite buttons ───────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FloatBtn(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => context.pop(),
                  ),
                  _FloatBtn(
                    icon: _isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    iconColor:
                        _isFavorite ? AppColors.danger : AppColors.foreground,
                    onTap: () =>
                        setState(() => _isFavorite = !_isFavorite),
                  ),
                ],
              ),
            ),
          ),

          // ── Sticky Add to Cart footer ───────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _AddToCartBar(
              qty: _qty,
              totalPrice: _totalPrice,
              onTap: () => context.push('/cart'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero Section ──────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.emoji,
    required this.badge,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  final String emoji;
  final String? badge;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 288,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFECEC), Color(0xFFF9F7F4)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Emoji centered
          Center(
            child: Text(emoji, style: const TextStyle(fontSize: 120)),
          ),
          // Badge
          if (badge != null)
            Positioned(
              top: 100,
              left: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          // Bottom gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 96,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Float Button ──────────────────────────────────────────────────────────────

class _FloatBtn extends StatelessWidget {
  const _FloatBtn({
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.foreground,
  });
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.foreground,
      ),
    );
  }
}

// ── Spicy option pill ─────────────────────────────────────────────────────────

class _SpicyOption extends StatelessWidget {
  const _SpicyOption({
    required this.label,
    required this.emoji,
    required this.level,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String emoji;
  final int level;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  selected ? AppColors.primary : AppColors.borderDivider,
            ),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : AppColors.foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Qty stepper ───────────────────────────────────────────────────────────────

class _QtyStepper extends StatelessWidget {
  const _QtyStepper({
    required this.qty,
    required this.onDecrement,
    required this.onIncrement,
  });
  final int qty;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          _StepBtn(icon: Icons.remove, onTap: onDecrement),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$qty',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.foreground,
              ),
            ),
          ),
          _StepBtn(icon: Icons.add, onTap: onIncrement, filled: true),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({
    required this.icon,
    required this.onTap,
    this.filled = false,
  });
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 16,
          color: filled ? Colors.white : AppColors.foreground,
        ),
      ),
    );
  }
}

// ── Related items ─────────────────────────────────────────────────────────────

class _RelatedItems extends StatelessWidget {
  const _RelatedItems();

  static const List<_RelatedItem> _items = [
    _RelatedItem(emoji: '🍲', name: 'Mushroom Clear Broth', price: 55000),
    _RelatedItem(emoji: '🦐', name: 'Tiger Prawn Set', price: 95000),
    _RelatedItem(emoji: '🧧', name: 'Dragon Set Menu', price: 299000),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You Might Also Like',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.foreground,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          _items.length,
          (i) => _RelatedItemRow(item: _items[i]),
        ),
      ],
    );
  }
}

class _RelatedItem {
  final String emoji;
  final String name;
  final int price;
  const _RelatedItem(
      {required this.emoji, required this.name, required this.price});
}

class _RelatedItemRow extends StatelessWidget {
  const _RelatedItemRow({required this.item});
  final _RelatedItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderDivider),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child:
                  Text(item.emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.foreground,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Rp ${_fmt(item.price)}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Add to cart bar ───────────────────────────────────────────────────────────

class _AddToCartBar extends StatelessWidget {
  const _AddToCartBar({
    required this.qty,
    required this.totalPrice,
    required this.onTap,
  });
  final int qty;
  final int totalPrice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add $qty to Cart',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Rp ${_fmt(totalPrice)}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
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
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

String _fmt(int value) {
  final s = value.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return buf.toString();
}

String _fmtReviews(int reviews) {
  if (reviews >= 1000) {
    return '${(reviews / 1000).toStringAsFixed(1)}k';
  }
  return '$reviews';
}
