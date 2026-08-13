import 'package:flutter/material.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

/// Location pill shown below the header.
class HomeLocationBar extends StatelessWidget {
  const HomeLocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.primary, size: 16),
          const SizedBox(width: 4),
          const Expanded(
            child: Text(
              'Jl. Sudirman No. 45, Jakarta Pusat',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.foreground,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down,
              color: AppColors.primary, size: 18),
        ],
      ),
    );
  }
}
