import 'package:flutter/material.dart';

/// Palet warna Crimson Dragon Hot Pot — deep crimson red brand with gold accents on warm cream.
/// Source: needmcp / crimson-dragon-hot-pot design token v2.4.0
abstract final class AppColors {
  // ── Brand Primary (Crimson Red) ──────────────────────────────────────
  static const Color primary = Color(0xFF9A0B17);
  static const Color primaryHover = Color(0xFFB31B27);
  static const Color primaryActive = Color(0xFF7A050E);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color primaryBg = Color(0x199A0B17); // 10% opacity
  static const Color primarySubtle = Color(0x0F9A0B17); // 6% opacity
  static const Color primaryMuted = Color(0x339A0B17); // 20% opacity

  // ── Brand Secondary (Gold) ───────────────────────────────────────────
  static const Color secondary = Color(0xFFD4AF37);
  static const Color secondaryHover = Color(0xFFC49E2C);
  static const Color secondaryActive = Color(0xFFB08D1E);
  static const Color secondaryText = Color(0xFF1A1A1A);
  static const Color secondaryBg = Color(0x1AD4AF37); // 10% opacity

  // ── Neutral / Background ─────────────────────────────────────────────
  static const Color background = Color(0xFFF9F7F4); // warm cream
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // ── Text ─────────────────────────────────────────────────────────────
  static const Color foreground = Color(0xFF1A1A1A);
  static const Color foregroundDark = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textSecondaryDark = Color(0xFFAAAAAA);

  // ── Border ───────────────────────────────────────────────────────────
  static const Color border = Color(0xFFE5E5E5);
  static const Color borderDivider = Color(0xFFE0E0E0);
  static const Color borderDividerDark = Color(0xFF2E2E2E);

  // ── Status ───────────────────────────────────────────────────────────
  static const Color success = Color(0xFF2B9A66);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFDC2626);
  static const Color info = Color(0xFF3B82F6);

  // ── Convenience aliases (backward-compat) ────────────────────────────
  static const Color backgroundLight = background;
  static const Color surfaceLight = surface;
  static const Color textPrimaryLight = foreground;
  static const Color textPrimaryDark = foregroundDark;
  static const Color textSecondaryLight = textSecondary;
  static const Color error = danger;
}
