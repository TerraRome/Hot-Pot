# Business Process Flow — Crimson Dragon Hot Pot

Dokumen ini menjelaskan seluruh alur bisnis aplikasi, dari pertama kali user membuka app sampai order selesai dan review diberikan.

---

## 1. First-Time User Flow

```
App Launch
    │
    ▼
[Splash Screen]  ──(2.5s auto)──►  [Onboarding Slide 1]
                                        │  "Welcome to Crimson Dragon"
                                        ▼
                                   [Onboarding Slide 2]
                                        │  "Craft Your Perfect Hot Pot"
                                        ▼
                                   [Onboarding Slide 3]
                                        │  "Track Every Step, Live"
                                        │
                                   [Get Started / Skip]
                                        │
                                        ▼
                                   [Sign In Page]
```

---

## 2. Authentication Flow

```
[Sign In Page]
    │
    ├── Email + Password ──► [OTP Verification]
    │                              │
    ├── Google / Facebook / Apple  │  6-digit masked input
    │   (Social Login)             │  60s countdown
    │                              │  Auto-verify on complete
    │                              ▼
    ├── Forgot Password? ──► [Forgot Password] ──► email reset link ──► back to Sign In
    │
    ├── Register (no account) ──► [Register] ── full name / email / phone /
    │                               password / confirm + terms checkbox
    │                               └──► [OTP Verification]
    │
    └─────────────────────────► [Home Page]
```

---

## 3. Browse & Discovery Flow

```
[Home Page]
    │
    ├── Search Bar tap ──────────────► [Search Page]
    │                                      │
    │                                      ├── Type query (live filter)
    │                                      ├── Filter chips: All/Broth/Meat/
    │                                      │   Seafood/Veggie/Noodle
    │                                      └── Tap result ──► [Product Detail]
    │
    ├── Filter (tune) icon ──────────► [Category Browse Page]
    │                                      │
    │                                      ├── Select category tab
    │                                      │   (Broth/Meat/Seafood/Veggie/
    │                                      │    Noodle/Extras)
    │                                      └── Tap item card ──► [Product Detail]
    │
    ├── Category chips (horizontal) ─► filtered menu grid
    │
    ├── Special Offers card ──────────► [Product Detail]
    │
    └── Menu Grid card ──────────────► [Product Detail]
```

---

## 4. Order Flow (Core)

```
[Product Detail]
    │
    ├── Select spicy level (Mild/Medium/Hot/Extra Hot)
    ├── Adjust quantity (+/-)
    ├── Add notes (optional)
    └── "Add to Cart" button
            │
            ▼
        [Cart Page]
            │
            ├── Adjust item quantities
            ├── Remove items
            ├── Enter promo code
            ├── Add special instructions
            ├── View order summary
            └── "Proceed to Checkout"
                    │
                    ▼
            [Checkout Page]
                    │
                    ├── Select delivery method
                    │       ├── Delivery ──► fill address + contact form
                    │       │               + map preview
                    │       │               + select delivery time slot
                    │       └── Pickup  ──► select pickup time slot
                    │
                    ├── Select payment method
                    │   (GoPay / OVO / Dana / Bank Transfer / COD)
                    │
                    └── "Place Order"
                            │
                            ▼
                    [Order Tracking Page]
```

---

## 5. Order Tracking Flow

```
[Order Tracking Page]
    │
    ├── Tab: Active Orders
    │       │
    │       ├── Live Tracking Card
    │       │       │
    │       │       ├── View progress steps:
    │       │       │   Confirmed → Preparing → On the Way → Delivered
    │       │       │
    │       │       ├── Contact Rider (phone / chat)
    │       │       │
    │       │       └── "Track Live" button
    │       │               │
    │       │               ▼
    │       │       [Live Tracking Page]
    │       │               │
    │       │               ├── Animated map (rider moves in real-time)
    │       │               ├── ETA chip ("12 min")
    │       │               ├── Rider card (name, rating, vehicle)
    │       │               ├── Progress steps
    │       │               ├── Order summary row
    │       │               └── "View Invoice" button
    │       │                       │
    │       │                       ▼
    │       │               [Invoice Page]
    │       │
    │       └── Active Order Card
    │               └── "View Invoice" button ──► [Invoice Page]
    │
    └── Tab: Order History
            │
            ├── Past orders list
            └── "Reorder" button ──► [Cart Page] (pre-filled)
```

---

## 6. Invoice Flow

```
[Invoice Page]
    │
    ├── Payment status badge (Paid / Pending)
    ├── Order details (ID, date, type, address)
    ├── Items ordered list with qty & subtotal
    ├── Price summary (subtotal + delivery - discount = total)
    ├── Payment method card
    │
    ├── "Download" button ──► save PDF (planned)
    └── "Back to Home" button ──► [Home Page]
```

---

## 7. Profile Flow

```
[Home Page] ──► Account tab (bottom nav) ──► [Profile Page]
    │
    ├── Stats row: Orders / Reviews / Points
    │
    ├── Account section
    │       ├── Edit Profile ──► [Edit Profile Page]
    │       │                       │
    │       │                       ├── Edit: name, email, phone, birthday
    │       │                       ├── Gender picker
    │       │                       ├── Preferences (spice, notif, language)
    │       │                       └── "Save Changes" ──► back to Profile
    │       │
    │       ├── Saved Addresses ──► [Saved Addresses Page]
    │       │                           ├── Select default (animated border)
    │       │                           ├── Edit / Delete per card
    │       │                           └── Add New Address button
    │       │
    │       ├── Payment Methods ──► [Payment Methods Page]
    │       │                           ├── Grouped: E-Wallet / Bank / Card / COD
    │       │                           ├── Select default (radio indicator)
    │       │                           └── Add Payment Method button
    │       │
    │       └── Promo & Vouchers ──► [Promo & Vouchers Page]
    │                                   ├── Tab: Available Promos
    │                                   │     ├── Promo code input + Apply
    │                                   │     └── Promo cards (color band, copy chip)
    │                                   └── Tab: My Vouchers
    │                                         └── Personal voucher cards
    │
    ├── Orders section
    │       ├── Order History ──► [Order Tracking Page]
    │       │
    │       ├── Favourite Items ──► [Favourites Page]
    │       │                           ├── Item cards (emoji, category, price)
    │       │                           ├── Remove from favourites
    │       │                           ├── Add to cart shortcut
    │       │                           └── Tap ──► [Product Detail]
    │       │
    │       ├── My Reviews ──► [My Reviews Page]
    │       │                     ├── Average rating summary
    │       │                     ├── Review cards (order ID, items, stars, comment)
    │       │                     └── Edit Review button
    │       │
    │       └── Loyalty & Rewards ──► [Loyalty Page]
    │                                    ├── Points card (tier, progress bar)
    │                                    ├── Redeem rewards (locked/unlocked)
    │                                    └── Points history (earn/redeem)
    │
    ├── Support section
    │       ├── Help & FAQ ──► [Help & FAQ Page]
    │       │                     ├── Search bar (live filter)
    │       │                     ├── Accordion grouped by category
    │       │                     │   (Orders / Delivery / Payment / Account)
    │       │                     └── Contact card: Live Chat + Email Us
    │       │
    │       ├── Contact Support
    │       └── About Crimson Dragon
    │
    ├── Preferences section
    │       ├── Notifications toggle ──► [Settings Page]
    │       ├── Dark Mode toggle ──► [Settings Page]
    │       └── Language selector ──► [Settings Page]
    │           │
    │           └── [Settings Page]
    │                   ├── Notification toggles (Orders, Promos, App Updates)
    │                   ├── Email toggles (Receipts, Newsletter)
    │                   ├── Preference toggles (History, Location)
    │                   ├── Privacy toggles (Analytics, Personalization)
    │                   └── Account actions (Download, Change Password, Delete)
    │
    └── Sign Out ──► [Sign In Page]
```

---

## 8. Notifications Flow

```
[Home Page]
    │
    └── Bell icon (badge: 3 unread) ──► [Notifications Page]
                                              │
                                              ├── Tab: All
                                              │     └── All notification cards
                                              │
                                              ├── Tab: Orders
                                              │     └── Order status updates
                                              │         (confirmed, preparing,
                                              │          on the way, delivered)
                                              │
                                              └── Tab: Promos
                                                    └── Flash sales, new menu,
                                                        weekend specials
```

---

## 9. Bottom Navigation Map

```
Bottom Nav (4 tabs)
    │
    ├── 🏠 Home (index 0) ──────────────► [Home Page]
    │
    ├── 🔍 Explore (index 1) ───────────► [Category Browse Page]
    │
    ├── 🧾 Orders (index 2) ────────────► [Order Tracking Page]
    │
    └── 👤 Account (index 3) ───────────► [Profile Page]
```

---

## 10. Complete Route Map

```
/splash
  └──► /onboarding (first launch)
         └──► /signin
                └──► /otp
                       └──► / (Home)
                              ├──► /search
                              │      └──► /product
                              │             └──► /cart
                              │                    └──► /checkout
                              │                           └──► /orders
                              │                                  ├──► /live-tracking
                              │                                  │      └──► /invoice
                              │                                  └──► /invoice
                              │
                              ├──► /category
                              │      └──► /product (same flow as above)
                              │
                              ├──► /notifications
                              │
                              ├──► /profile
                              │      ├──► /edit-profile
                              │      ├──► /addresses
                              │      ├──► /payment-methods
                              │      ├──► /promos
                              │      ├──► /orders
                              │      ├──► /favourites
                              │      │      └──► /product
                              │      ├──► /reviews
                              │      ├──► /loyalty
                              │      ├──► /faq
                              │      └──► /settings
                              │
                              └──► /cart (from header icon)
```

---

## 11. Data Flow Summary

| Aksi User | Dari | Ke | Data yang Dikirim |
|-----------|------|----|-------------------|
| Tap menu item | Home / Search / Category / Favourites | Product Detail | `ProductDetailArgs` (emoji, name, desc, price, spicyLevel, rating, reviews) |
| Add to cart | Product Detail | Cart | item + qty + notes |
| Checkout | Cart | Checkout | cart items + promo |
| Place order | Checkout | Order Tracking | delivery method + address + payment |
| Track live | Order Tracking | Live Tracking | order ID |
| View invoice | Live Tracking / Order Tracking | Invoice | `InvoiceArgs` (orderId, items, fees) |
| Apply promo | Promo & Vouchers / Checkout | — | promo code string |
| Select address | Saved Addresses | — | address index (default) |
| Select payment | Payment Methods | — | payment method index (default) |
| Redeem reward | Loyalty | — | reward points cost |
| Sign out | Profile | Sign In | — |
