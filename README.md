# 🍲 Crimson Dragon Hot Pot

A Flutter mobile app for a hot pot restaurant — built as a portfolio project using a custom Crimson Dragon design system with deep crimson red and gold accents on warm cream.

## Screenshots

| Splash | Sign In | OTP | Home | Product Detail |
|--------|---------|-----|------|----------------|
| Animated dragon logo | Email/social login | 6-box OTP input | Banner carousel, menu grid | Spicy selector, qty stepper |

| Search | Category Browse | Profile | Edit Profile | Cart |
|--------|----------------|---------|--------------|------|
| Live filter + results | 6-category grid | Stats, menu sections | Form fields, date picker | Qty stepper, promo code |

| Saved Addresses | Payment Methods | Favourites | My Reviews | Promo & Vouchers |
|----------------|-----------------|------------|------------|-----------------|
| Select default, edit, delete | Grouped by type, select default | Remove, add to cart | Rating summary, order items | 2-tab, code input, copy chip |

| Help & FAQ | Settings | Loyalty & Rewards |
|-----------|---------|------------------|
| Searchable accordion, contact card | Notification/privacy toggles, account actions | Tier progress, redeem rewards, points history |

## Features

### Phase 1 — Auth Flow
- **Splash** — Animated dragon logo, gold divider, loading dots, auto-navigate
- **Onboarding** — 3 animated slides, dots indicator, skip button, Get Started, localized (EN/ID)
- **Sign In** — Email/phone + password, social buttons (Google/Facebook/Apple SVG logos), remember me
- **Register** — Full name/email/phone/password/confirm fields, terms checkbox, social auth
- **Forgot Password** — Email input, send reset link, back to sign-in
- **OTP Verification** — 6-box masked input (password-style dots), blinking cursor, 60s countdown timer, auto-verify on complete

### Phase 2 — Search & Browse
- **Search** — Live filtering, category chips (All/Broth/Meat/Seafood/Veggie/Noodle), result list with emoji avatar + category badge, empty state
- **Category Browse** — 6-icon category grid (Broth/Meat/Seafood/Veggie/Noodle/Extras), animated selection, item grid with tag badges

### Phase 3 — Core Flow
- **Home** — Banner carousel, category chips, special offers, menu grid
- **Product Detail** — Spicy level selector, qty stepper, notes field, related items
- **Cart** — Item management, promo code, special instructions, order summary
- **Checkout** — Delivery/pickup toggle, contact form, map preview, delivery time slots (conditional), payment method

### Phase 4 — Orders & Tracking
- **Order Tracking** — Active orders tab with progress steps, rider contact, order history with reorder
- **Live Tracking** — Animated CustomPainter map, pulsing rider marker, LIVE badge header, status hero card, ETA chip, progress steps, rider contact card
- **Invoice** — Order info, items list, price summary, payment status badge, download & home actions

### Phase 5 — Profile
- **Profile** — Stats row (Orders/Reviews/Points), menu sections, settings shortcut, sign out
- **Edit Profile** — Full name, email, phone, birthday (date picker), gender picker, spice preference
- **Settings** — Notification/email/preferences/privacy toggles, dark mode, language switcher (EN/ID), account actions

### Phase 6 — Polish & UX
- **Notifications** — 3-tab view (All/Orders/Promos), unread badge counter, read/unread card states
- **Onboarding** — 3-slide welcome flow with animated dots, skip, and Get Started

## Tech Stack

| Layer | Package |
|-------|---------|
| Framework | Flutter 3.41.3 / Dart 3.11.1 |
| Navigation | go_router ^17.5.0 |
| State Management | flutter_riverpod ^3.0.3 |
| Networking | dio ^5.11.0 |
| Localization | flutter_localizations, intl, flutter gen-l10n |
| Vector Graphics | flutter_svg ^2.2.0 |
| Code Generation | freezed, json_serializable, riverpod_generator |
| Font | Inter (Regular, Medium, SemiBold, Bold) |

## Design System

**Crimson Dragon Hot Pot** — designed via [needmcp](https://needmcp.com) v2.4.0

| Token | Value |
|-------|-------|
| Primary (Crimson Red) | `#9A0B17` |
| Secondary (Gold) | `#D4AF37` |
| Background (Warm Cream) | `#F9F7F4` |
| Surface | `#FFFFFF` |
| Font | Inter |

## Project Structure

```
lib/
├── app.dart                          # Root app + scroll behavior
├── main.dart
├── core/
│   ├── router/app_router.dart        # GoRouter — 26 routes
│   └── theme/
│       ├── app_colors.dart           # Design tokens
│       └── app_theme.dart            # MaterialTheme
└── features/
    ├── auth/                         # Splash, Sign In, OTP
    ├── onboarding/                   # 3-slide onboarding
    ├── home/                         # Home page + widgets
    ├── search/                       # Search page
    ├── explore/                      # Category browse page
    ├── menu/                         # Product detail page
    ├── cart/                         # Cart page
    ├── checkout/                     # Checkout form page
    ├── orders/                       # Order tracking, live tracking, invoice
    ├── profile/                      # Profile, edit profile, addresses,
    │                                 # payment methods, favourites, reviews,
    │                                 # promos, faq, settings, loyalty
    └── notifications/                # Notification page
```

## Routes

| Path | Page |
|------|------|
| `/splash` | Splash Screen |
| `/onboarding` | Onboarding (3 slides) |
| `/signin` | Sign In |
| `/otp` | OTP Verification |
| `/forgot-password` | Forgot Password |
| `/register` | Register |
| `/` | Home |
| `/search` | Search |
| `/category` | Category Browse |
| `/product` | Product Detail |
| `/cart` | Cart |
| `/checkout` | Checkout |
| `/orders` | Order Tracking |
| `/live-tracking` | Live Tracking Map |
| `/invoice` | Invoice |
| `/profile` | Profile |
| `/edit-profile` | Edit Profile |
| `/notifications` | Notifications |
| `/addresses` | Saved Addresses |
| `/payment-methods` | Payment Methods |
| `/favourites` | Favourite Items |
| `/reviews` | My Reviews |
| `/promos` | Promo & Vouchers |
| `/faq` | Help & FAQ |
| `/settings` | Settings |
| `/loyalty` | Loyalty & Rewards |

## Roadmap

### Completed
- [x] Phase 1 — Auth Flow (Splash, Sign In, OTP)
- [x] Phase 2 — Search & Browse (Search, Category Browse)
- [x] Phase 3 — Core Flow (Home, Product Detail, Cart, Checkout)
- [x] Phase 4 — Orders & Tracking (Order Tracking, Live Tracking, Invoice)
- [x] Phase 5 — Profile (Profile, Edit Profile)
- [x] Phase 6 — Polish & UX (Notifications, Onboarding, notification badge)
- [x] Phase 7 — Profile Pages (Addresses, Payments, Favourites, Reviews, Promos, FAQ, Settings, Loyalty)
- [x] Phase 8 — Auth & Localization
  - [x] Forgot Password page + route
  - [x] Register page + route
  - [x] Social login SVG logos (Google/Facebook/Apple)
  - [x] OTP masked as password input
  - [x] All header bell icons navigate to Notifications
  - [x] Live Tracking UI polish (LIVE badge, status hero, larger step labels)
  - [x] Bilingual localization (English/Indonesian) via `flutter gen-l10n` + Riverpod locale switch

### In Progress
- [ ] Phase 9 — Full localization coverage: remaining 20+ pages still hardcoded English, being migrated to ARB keys incrementally

## Getting Started

### Prerequisites

- Flutter 3.41.3+ (via [FVM](https://fvm.app) recommended)
- Android emulator or iOS simulator

### Run

```bash
# Clone repo
git clone https://github.com/TerraRome/Hot-Pot.git
cd Hot-Pot

# Install dependencies
flutter pub get

# Run on emulator
flutter run
```

### Using FVM

```bash
fvm use stable
fvm flutter pub get
fvm flutter run -d <device-id>
```

## Business Flow

See [FLOW.md](./FLOW.md) for the full business process flow diagram.

## Development Notes

- `CardThemeData` (not `CardTheme`) required for Flutter 3.41.3
- Global overscroll stretch fix via `_NoStretchScrollBehavior` in `app.dart`
- All scroll views use `ClampingScrollPhysics`
- All pages use `SafeArea` with proper padding for notch/gesture bar devices
- `withValues(alpha:)` used instead of deprecated `withOpacity()`

## License

MIT
