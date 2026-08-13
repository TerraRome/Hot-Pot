import 'package:flutter/material.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

/// Search bar + delivery/dine-in toggle row di bawah header.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(Icons.search, color: AppColors.textSecondary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Search menu...',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

/// Delivery / Dine-in toggle pill.
class HomeOrderTypeToggle extends StatefulWidget {
  const HomeOrderTypeToggle({super.key});

  @override
  State<HomeOrderTypeToggle> createState() => _HomeOrderTypeToggleState();
}

class _HomeOrderTypeToggleState extends State<HomeOrderTypeToggle> {
  int _selected = 0;
  final _options = ['Delivery', 'Dine In', 'Takeaway'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primaryBg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_options.length, (i) {
            final active = i == _selected;
            return GestureDetector(
              onTap: () => setState(() => _selected = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _options[i],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: active ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
