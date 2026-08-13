import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';
import 'package:hot_pot/features/menu/presentation/pages/product_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchCtrl = TextEditingController();
  final _focusNode = FocusNode();
  String _query = '';
  String _activeFilter = 'All';

  static const _filters = ['All', 'Broth', 'Meat', 'Seafood', 'Veggie', 'Noodle'];

  static const _allItems = [
    _MenuItem(emoji: '🔥', name: 'Sichuan Spicy Broth', category: 'Broth', price: 65000, rating: 4.9, spicyLevel: 3, reviews: 312, desc: 'Numbing & fiery Sichuan peppercorn base'),
    _MenuItem(emoji: '🍲', name: 'Original Mild Broth', category: 'Broth', price: 55000, rating: 4.7, spicyLevel: 0, reviews: 204, desc: 'Light & comforting chicken bone broth'),
    _MenuItem(emoji: '🥩', name: 'Wagyu Beef Slices', category: 'Meat', price: 120000, rating: 4.9, spicyLevel: 0, reviews: 421, desc: 'Premium A5 wagyu, melt-in-your-mouth'),
    _MenuItem(emoji: '🐖', name: 'Pork Belly Rolls', category: 'Meat', price: 75000, rating: 4.6, spicyLevel: 0, reviews: 187, desc: 'Thinly sliced marbled pork belly'),
    _MenuItem(emoji: '🐑', name: 'Lamb Shoulder Slices', category: 'Meat', price: 95000, rating: 4.8, spicyLevel: 0, reviews: 263, desc: 'Tender Inner Mongolia lamb'),
    _MenuItem(emoji: '🦐', name: 'Tiger Prawn Set', category: 'Seafood', price: 95000, rating: 4.8, spicyLevel: 0, reviews: 298, desc: 'Head-on, 6 pieces per order'),
    _MenuItem(emoji: '🦑', name: 'Fresh Squid Rings', category: 'Seafood', price: 70000, rating: 4.5, spicyLevel: 0, reviews: 133, desc: 'Lightly scored for even cooking'),
    _MenuItem(emoji: '🐚', name: 'Clam & Mussel Mix', category: 'Seafood', price: 80000, rating: 4.6, spicyLevel: 0, reviews: 156, desc: 'Fresh daily from local market'),
    _MenuItem(emoji: '🥦', name: 'Garden Veggie Platter', category: 'Veggie', price: 45000, rating: 4.7, spicyLevel: 0, reviews: 211, desc: '12 seasonal vegetables'),
    _MenuItem(emoji: '🍄', name: 'Mushroom Trio', category: 'Veggie', price: 55000, rating: 4.8, spicyLevel: 0, reviews: 334, desc: 'Shiitake, enoki & king oyster'),
    _MenuItem(emoji: '🌿', name: 'Tofu & Yuba Set', category: 'Veggie', price: 50000, rating: 4.5, spicyLevel: 0, reviews: 122, desc: 'Silken tofu & beancurd skin'),
    _MenuItem(emoji: '🍜', name: 'Hand-pulled Noodles', category: 'Noodle', price: 35000, rating: 4.8, spicyLevel: 0, reviews: 276, desc: 'Freshly pulled to order'),
    _MenuItem(emoji: '🍝', name: 'Glass Noodle Bundle', category: 'Noodle', price: 25000, rating: 4.6, spicyLevel: 0, reviews: 165, desc: 'Sweet potato starch noodles'),
    _MenuItem(emoji: '🌾', name: 'Rice Cake Slices', category: 'Noodle', price: 30000, rating: 4.7, spicyLevel: 0, reviews: 203, desc: 'Chewy Korean-style tteok'),
  ];

  List<_MenuItem> get _filtered {
    final q = _query.toLowerCase();
    return _allItems.where((item) {
      final matchFilter = _activeFilter == 'All' || item.category == _activeFilter;
      final matchQuery = q.isEmpty ||
          item.name.toLowerCase().contains(q) ||
          item.category.toLowerCase().contains(q) ||
          item.desc.toLowerCase().contains(q);
      return matchFilter && matchQuery;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────
          _SearchHeader(
            controller: _searchCtrl,
            focusNode: _focusNode,
            onChanged: (v) => setState(() => _query = v),
            onClear: () {
              _searchCtrl.clear();
              setState(() => _query = '');
            },
          ),
          // ── Filter chips ─────────────────────────────────────────────
          _FilterChips(
            filters: _filters,
            active: _activeFilter,
            onSelected: (f) => setState(() => _activeFilter = f),
          ),
          // ── Results ──────────────────────────────────────────────────
          Expanded(
            child: results.isEmpty
                ? _EmptyState(query: _query)
                : CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                          child: Text(
                            '${results.length} item${results.length != 1 ? 's' : ''} found',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, i) => _ResultCard(
                              item: results[i],
                              onTap: () => context.push(
                                '/product',
                                extra: ProductDetailArgs(
                                  emoji: results[i].emoji,
                                  name: results[i].name,
                                  description: results[i].desc,
                                  price: results[i].price,
                                  spicyLevel: results[i].spicyLevel,
                                  rating: results[i].rating,
                                  reviews: results[i].reviews,
                                ),
                              ),
                            ),
                            childCount: results.length,
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

class _SearchHeader extends StatelessWidget {
  const _SearchHeader({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

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
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderDivider),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      const Icon(Icons.search,
                          size: 18, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onChanged: onChanged,
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.foreground),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Search menu, broth, ingredients…',
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      if (controller.text.isNotEmpty)
                        GestureDetector(
                          onTap: onClear,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(Icons.close,
                                size: 16,
                                color: AppColors.textSecondary
                                    .withValues(alpha: 0.7)),
                          ),
                        ),
                      const SizedBox(width: 4),
                    ],
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

// ── Filter chips ──────────────────────────────────────────────────────────────

class _FilterChips extends StatelessWidget {
  const _FilterChips({
    required this.filters,
    required this.active,
    required this.onSelected,
  });

  final List<String> filters;
  final String active;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: SizedBox(
        height: 34,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          itemCount: filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final f = filters[i];
            final selected = f == active;
            return GestureDetector(
              onTap: () => onSelected(f),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? AppColors.primary
                        : AppColors.borderDivider,
                  ),
                ),
                child: Text(
                  f,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Result card ───────────────────────────────────────────────────────────────

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.item, required this.onTap});
  final _MenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderDivider),
        ),
        child: Row(
          children: [
            // Emoji avatar
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primaryBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(item.emoji,
                    style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.foreground,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.category,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.desc,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        'Rp ${_fmt(item.price)}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_rounded,
                          size: 13, color: AppColors.secondary),
                      const SizedBox(width: 2),
                      Text(
                        item.rating.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.foreground,
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

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            query.isEmpty ? 'Start typing to search' : 'No results for "$query"',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try a different keyword or category',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────

class _MenuItem {
  final String emoji;
  final String name;
  final String category;
  final int price;
  final double rating;
  final int spicyLevel;
  final int reviews;
  final String desc;

  const _MenuItem({
    required this.emoji,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.spicyLevel,
    required this.reviews,
    required this.desc,
  });
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
