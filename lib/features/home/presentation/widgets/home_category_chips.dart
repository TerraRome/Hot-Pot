import 'package:flutter/material.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

/// Horizontal scrollable category chips.
class HomeCategoryChips extends StatefulWidget {
  const HomeCategoryChips({super.key});

  @override
  State<HomeCategoryChips> createState() => _HomeCategoryChipsState();
}

class _HomeCategoryChipsState extends State<HomeCategoryChips> {
  int _selected = 0;

  final List<_Category> _categories = const [
    _Category(emoji: '🍲', label: 'All'),
    _Category(emoji: '🔥', label: 'Spicy Broth'),
    _Category(emoji: '🥩', label: 'Meat'),
    _Category(emoji: '🥦', label: 'Vegetables'),
    _Category(emoji: '🦐', label: 'Seafood'),
    _Category(emoji: '🍜', label: 'Noodles'),
    _Category(emoji: '🧧', label: 'Set Menu'),
    _Category(emoji: '🍵', label: 'Drinks'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.foreground,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
          SizedBox(
            height: 44,
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final active = i == _selected;
              final cat = _categories[i];
              return GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color:
                          active ? AppColors.primary : AppColors.borderDivider,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(cat.emoji,
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        cat.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: active ? Colors.white : AppColors.foreground,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Category {
  final String emoji;
  final String label;
  const _Category({required this.emoji, required this.label});
}
