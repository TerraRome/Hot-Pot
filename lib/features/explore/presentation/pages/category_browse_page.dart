import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';
import 'package:hot_pot/features/menu/presentation/pages/product_detail_page.dart';

class CategoryBrowsePage extends StatefulWidget {
  const CategoryBrowsePage({super.key});

  @override
  State<CategoryBrowsePage> createState() => _CategoryBrowsePageState();
}

class _CategoryBrowsePageState extends State<CategoryBrowsePage> {
  String _selectedCategory = 'Broth';

  static const _categories = [
    _Category(emoji: '🔥', label: 'Broth', color: Color(0xFFFF6B35)),
    _Category(emoji: '🥩', label: 'Meat', color: Color(0xFFDC2626)),
    _Category(emoji: '🦐', label: 'Seafood', color: Color(0xFF0EA5E9)),
    _Category(emoji: '🥦', label: 'Veggie', color: Color(0xFF16A34A)),
    _Category(emoji: '🍜', label: 'Noodle', color: Color(0xFFD97706)),
    _Category(emoji: '🥚', label: 'Extras', color: Color(0xFF7C3AED)),
  ];

  static const _items = {
    'Broth': [
      _Item(emoji: '🔥', name: 'Sichuan Spicy Broth', desc: 'Numbing & fiery Sichuan peppercorn base', price: 65000, rating: 4.9, spicyLevel: 3, reviews: 312, tag: 'Best Seller'),
      _Item(emoji: '🍲', name: 'Original Mild Broth', desc: 'Light & comforting chicken bone broth', price: 55000, rating: 4.7, spicyLevel: 0, reviews: 204, tag: null),
      _Item(emoji: '🌿', name: 'Herbal Mushroom Broth', desc: 'Earthy blend of shiitake & goji berries', price: 60000, rating: 4.6, spicyLevel: 0, reviews: 178, tag: 'Vegetarian'),
      _Item(emoji: '🥛', name: 'Creamy Coconut Broth', desc: 'Rich coconut milk with lemongrass', price: 70000, rating: 4.5, spicyLevel: 1, reviews: 95, tag: 'New'),
    ],
    'Meat': [
      _Item(emoji: '🥩', name: 'Wagyu Beef Slices', desc: 'Premium A5 wagyu, melt-in-your-mouth', price: 120000, rating: 4.9, spicyLevel: 0, reviews: 421, tag: 'Premium'),
      _Item(emoji: '🐖', name: 'Pork Belly Rolls', desc: 'Thinly sliced marbled pork belly', price: 75000, rating: 4.6, spicyLevel: 0, reviews: 187, tag: null),
      _Item(emoji: '🐑', name: 'Lamb Shoulder Slices', desc: 'Tender Inner Mongolia lamb', price: 95000, rating: 4.8, spicyLevel: 0, reviews: 263, tag: 'Popular'),
      _Item(emoji: '🍗', name: 'Chicken Thigh Slices', desc: 'Juicy boneless thigh, thinly cut', price: 65000, rating: 4.5, spicyLevel: 0, reviews: 142, tag: null),
    ],
    'Seafood': [
      _Item(emoji: '🦐', name: 'Tiger Prawn Set', desc: 'Head-on, 6 pieces per order', price: 95000, rating: 4.8, spicyLevel: 0, reviews: 298, tag: 'Fresh'),
      _Item(emoji: '🦑', name: 'Fresh Squid Rings', desc: 'Lightly scored for even cooking', price: 70000, rating: 4.5, spicyLevel: 0, reviews: 133, tag: null),
      _Item(emoji: '🐚', name: 'Clam & Mussel Mix', desc: 'Fresh daily from local market', price: 80000, rating: 4.6, spicyLevel: 0, reviews: 156, tag: null),
      _Item(emoji: '🐟', name: 'Sliced Fish Fillet', desc: 'Tilapia fillet, paper-thin slices', price: 75000, rating: 4.7, spicyLevel: 0, reviews: 189, tag: null),
    ],
    'Veggie': [
      _Item(emoji: '🥦', name: 'Garden Veggie Platter', desc: '12 seasonal vegetables', price: 45000, rating: 4.7, spicyLevel: 0, reviews: 211, tag: 'Vegan'),
      _Item(emoji: '🍄', name: 'Mushroom Trio', desc: 'Shiitake, enoki & king oyster', price: 55000, rating: 4.8, spicyLevel: 0, reviews: 334, tag: 'Popular'),
      _Item(emoji: '🌿', name: 'Tofu & Yuba Set', desc: 'Silken tofu & beancurd skin', price: 50000, rating: 4.5, spicyLevel: 0, reviews: 122, tag: null),
      _Item(emoji: '🌽', name: 'Corn & Lotus Root', desc: 'Sweet corn cobs & crunchy lotus slices', price: 40000, rating: 4.4, spicyLevel: 0, reviews: 98, tag: null),
    ],
    'Noodle': [
      _Item(emoji: '🍜', name: 'Hand-pulled Noodles', desc: 'Freshly pulled to order', price: 35000, rating: 4.8, spicyLevel: 0, reviews: 276, tag: 'Chef Special'),
      _Item(emoji: '🍝', name: 'Glass Noodle Bundle', desc: 'Sweet potato starch noodles', price: 25000, rating: 4.6, spicyLevel: 0, reviews: 165, tag: null),
      _Item(emoji: '🌾', name: 'Rice Cake Slices', desc: 'Chewy Korean-style tteok', price: 30000, rating: 4.7, spicyLevel: 0, reviews: 203, tag: null),
      _Item(emoji: '🍥', name: 'Udon Noodle Pack', desc: 'Thick wheat noodles, soft texture', price: 32000, rating: 4.5, spicyLevel: 0, reviews: 117, tag: null),
    ],
    'Extras': [
      _Item(emoji: '🥚', name: 'Quail Eggs (10 pcs)', desc: 'Soft-boiled & ready to dip', price: 25000, rating: 4.6, spicyLevel: 0, reviews: 88, tag: null),
      _Item(emoji: '🧄', name: 'Garlic & Sesame Dip', desc: 'House-made dipping sauce', price: 15000, rating: 4.8, spicyLevel: 0, reviews: 310, tag: 'Must Try'),
      _Item(emoji: '🌶', name: 'Chili Oil Drizzle', desc: 'Fragrant toasted chili oil', price: 12000, rating: 4.7, spicyLevel: 2, reviews: 245, tag: null),
      _Item(emoji: '🥜', name: 'Peanut Satay Sauce', desc: 'Creamy roasted peanut blend', price: 15000, rating: 4.5, spicyLevel: 0, reviews: 134, tag: null),
    ],
  };

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
    final items = _items[_selectedCategory] ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Header ────────────────────────────────────────────────
          _BrowseHeader(),
          // ── Category grid ─────────────────────────────────────────
          _CategoryGrid(
            categories: _categories,
            selected: _selectedCategory,
            onSelected: (c) => setState(() => _selectedCategory = c),
          ),
          // ── Items list ────────────────────────────────────────────
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedCategory,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.foreground,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.tune,
                                size: 16, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            const Text(
                              'Filter',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.82,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _ItemCard(
                        item: items[i],
                        onTap: () => context.push(
                          '/product',
                          extra: ProductDetailArgs(
                            emoji: items[i].emoji,
                            name: items[i].name,
                            description: items[i].desc,
                            price: items[i].price,
                            spicyLevel: items[i].spicyLevel,
                            rating: items[i].rating,
                            reviews: items[i].reviews,
                          ),
                        ),
                      ),
                      childCount: items.length,
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

// ── Header ────────────────────────────────────────────────────────────────────

class _BrowseHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Stack(
        children: [
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
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
                  const Text('🐉', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Browse Menu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/search'),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.search,
                          color: Colors.white, size: 20),
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

// ── Category grid ─────────────────────────────────────────────────────────────

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<_Category> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 0,
        childAspectRatio: 0.8,
        children: categories.map((cat) {
          final active = cat.label == selected;
          return GestureDetector(
            onTap: () => onSelected(cat.label),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active
                        ? AppColors.primary
                        : AppColors.background,
                    border: Border.all(
                      color: active
                          ? AppColors.primary
                          : AppColors.borderDivider,
                      width: active ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(cat.emoji,
                        style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cat.label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight:
                        active ? FontWeight.w700 : FontWeight.w400,
                    color: active
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Item card ─────────────────────────────────────────────────────────────────

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item, required this.onTap});
  final _Item item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBg,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15)),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(item.emoji,
                          style: const TextStyle(fontSize: 48)),
                    ),
                    if (item.tag != null)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.tag!,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.foreground,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Rp ${_fmt(item.price)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const Icon(Icons.star_rounded,
                          size: 12, color: AppColors.secondary),
                      const SizedBox(width: 2),
                      Text(
                        item.rating.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _Category {
  final String emoji;
  final String label;
  final Color color;

  const _Category(
      {required this.emoji, required this.label, required this.color});
}

class _Item {
  final String emoji;
  final String name;
  final String desc;
  final int price;
  final double rating;
  final int spicyLevel;
  final int reviews;
  final String? tag;

  const _Item({
    required this.emoji,
    required this.name,
    required this.desc,
    required this.price,
    required this.rating,
    required this.spicyLevel,
    required this.reviews,
    required this.tag,
  });
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
  bool shouldReclip(_WavyClipper old) => false;
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
