# 🍲 Crimson Dragon Hot Pot

A Flutter mobile app for a hot pot restaurant — built as a portfolio project using a custom Crimson Dragon design system with deep crimson red and gold accents on warm cream.

## Screenshots

| Home | Product Detail | Cart | Checkout | Order Tracking |
|------|---------------|------|----------|----------------|
| Menu grid, banner carousel, category chips | Hero section, spicy level selector, related items | Qty stepper, promo code, order summary | Delivery/pickup toggle, payment method, form | Live tracking, progress steps, history tab |

## Features

- **Home** — Banner carousel, category chips, menu grid with hot pot items
- **Product Detail** — Spicy level selector, heat indicator, qty stepper, related items
- **Cart** — Item management, promo code, special instructions, order summary
- **Checkout** — Delivery/pickup toggle, contact form, map preview, delivery time slots, payment method selection
- **Order Tracking** — Active orders with live progress steps, rider contact, order history with reorder

## Tech Stack

| Layer | Package |
|-------|---------|
| Framework | Flutter 3.41.3 / Dart 3.11.1 |
| Navigation | go_router ^17.5.0 |
| State Management | flutter_riverpod ^3.0.3 |
| Networking | dio ^5.11.0 |
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
│   ├── router/app_router.dart        # GoRouter routes
│   └── theme/
│       ├── app_colors.dart           # Design tokens
│       └── app_theme.dart            # MaterialTheme
└── features/
    ├── home/                         # Home page + widgets
    ├── menu/                         # Product detail page
    ├── cart/                         # Cart page
    ├── checkout/                     # Checkout form page
    └── orders/                       # Order tracking page
```

## Routes

| Path | Page |
|------|------|
| `/` | Home |
| `/product` | Product Detail |
| `/cart` | Cart |
| `/checkout` | Checkout |
| `/orders` | Order Tracking |

## Getting Started

### Prerequisites

- Flutter 3.41.3+ (via [FVM](https://fvm.app) recommended)
- Android emulator or iOS simulator

### Run

```bash
# Clone repo
git clone https://github.com/TengkuCode/Hot-Pot.git
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

## Development Notes

- `CardThemeData` (not `CardTheme`) required for Flutter 3.41.3
- Global overscroll stretch fix via `_NoStretchScrollBehavior` in `app.dart`
- All scroll views use `ClampingScrollPhysics`
- All pages use `SafeArea` with proper padding for notch/gesture bar devices

## License

MIT
