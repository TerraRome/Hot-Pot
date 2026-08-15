import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

class LiveTrackingPage extends StatefulWidget {
  const LiveTrackingPage({super.key});

  @override
  State<LiveTrackingPage> createState() => _LiveTrackingPageState();
}

class _LiveTrackingPageState extends State<LiveTrackingPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _riderCtrl;
  late Animation<double> _pulseAnim;
  late Animation<double> _riderAnim;

  int get _currentStep {
    final t = _riderAnim.value;
    if (t < 0.25) return 0;
    if (t < 0.5) return 1;
    if (t < 1.0) return 2;
    return 3; // Delivered only once the rider reaches the destination
  }

  int get _etaMinutes {
    final t = _riderAnim.value;
    final m = 12 - (t * 12).floor();
    return m < 1 ? 1 : m;
  }

  // Rider only starts moving once the order is "On the Way" (step 2),
  // so the marker stays at the restaurant during confirmed/preparing.
  double get _riderRouteProgress {
    final t = _riderAnim.value;
    final p = (t - 0.5) / 0.5;
    return p.clamp(0.0, 0.96);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    _riderCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..forward();
    _riderAnim = Tween<double>(begin: 0.0, end: 1.0).animate(_riderCtrl);
    _riderCtrl.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _riderCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Map area ──────────────────────────────────────────────────
          Expanded(
            flex: 5,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = Size(constraints.maxWidth, constraints.maxHeight);
                final metrics = _routePath(size).computeMetrics().first;
                final pos = metrics
                    .getTangentForOffset(
                        metrics.length * _riderRouteProgress)
                    ?.position;
                final delivered = _currentStep >= 3;
                return Stack(
                  children: [
                    // Map background
                    Positioned.fill(
                      child: CustomPaint(painter: _MapPainter()),
                    ),
                    // Back button + status header
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => context.pop(),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.15),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.arrow_back_ios_new,
                                    size: 16, color: AppColors.foreground),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Live Tracking',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.foreground,
                                        ),
                                      ),
                                    ),
                                    if (delivered)
                                      const _LiveBadge(
                                          label: 'COMPLETED', isLive: false)
                                    else
                                      AnimatedBuilder(
                                        animation: _pulseAnim,
                                        builder: (context, _) => _LiveBadge(
                                          label: 'LIVE',
                                          isLive: true,
                                          pulseAnim: _pulseAnim,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Animated rider marker following the route
                    if (pos != null)
                      Positioned(
                        left: pos.dx - 24,
                        top: pos.dy - 24,
                        child: _RiderMarker(pulseAnim: _pulseAnim),
                      ),
                    // Destination marker — center aligns exactly with the route end
                    Positioned(
                      left: size.width * 0.85 - 20,
                      top: size.height * 0.33 - 20,
                      child: const _DestinationMarker(),
                    ),
                    // ETA chip
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: _EtaChip(
                        step: _currentStep,
                        minutes: _etaMinutes,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // ── Bottom sheet ───────────────────────────────────────────────
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 20,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Center(
                          child: Container(
                            width: 36,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.borderDivider,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _StatusHero(
                          pulseAnim: _pulseAnim,
                          step: _currentStep,
                          minutes: _etaMinutes,
                        ),
                        const SizedBox(height: 16),
                        _RiderCard(),
                        const SizedBox(height: 16),
                        _ProgressBar(currentStep: _currentStep),
                        const SizedBox(height: 16),
                        _OrderSummaryRow(),
                        const SizedBox(height: 16),
                        _InvoiceButton(),
                        const SizedBox(height: 24),
                      ],
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

// ── Map painter ───────────────────────────────────────────────────────────────

Path _routePath(Size size) => Path()
  ..moveTo(size.width * 0.22, size.height * 0.68)
  ..cubicTo(
    size.width * 0.45,
    size.height * 0.5,
    size.width * 0.62,
    size.height * 0.55,
    size.width * 0.85,
    size.height * 0.33,
  );

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFE8F0E8);
    canvas.drawRect(Offset.zero & size, bgPaint);

    // Roads
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.4), roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.4, 0), Offset(size.width * 0.5, size.height), roadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.65), Offset(size.width, size.height * 0.6), roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.15, 0), Offset(size.width * 0.2, size.height), roadPaint);

    // Road outlines
    final outlinePaint = Paint()
      ..color = const Color(0xFFCDD8CD)
      ..strokeWidth = 11
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
        Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.4), outlinePaint);
    canvas.drawLine(
        Offset(size.width * 0.4, 0), Offset(size.width * 0.5, size.height), outlinePaint);

    // Blocks
    final blockPaint = Paint()..color = const Color(0xFFD4E8D4);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width * 0.05, size.height * 0.05,
                size.width * 0.28, size.height * 0.2),
            const Radius.circular(8)),
        blockPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width * 0.55, size.height * 0.1,
                size.width * 0.35, size.height * 0.15),
            const Radius.circular(8)),
        blockPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width * 0.05, size.height * 0.45,
                size.width * 0.25, size.height * 0.25),
            const Radius.circular(8)),
        blockPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width * 0.6, size.height * 0.45,
                size.width * 0.32, size.height * 0.28),
            const Radius.circular(8)),
        blockPaint);

    // Route path
    final routePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.7)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(_routePath(size), routePaint);
  }

  @override
  bool shouldRepaint(_MapPainter old) => false;
}

// ── Live badge ────────────────────────────────────────────────────────────────

class _LiveBadge extends StatelessWidget {
  const _LiveBadge({
    required this.label,
    required this.isLive,
    this.pulseAnim,
  });

  final String label;
  final bool isLive;
  final Animation<double>? pulseAnim;

  @override
  Widget build(BuildContext context) {
    final color = isLive ? Colors.red : const Color(0xFF2E7D32);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: pulseAnim == null
            ? null
            : [
                BoxShadow(
                  color: color.withValues(alpha: 0.3 + pulseAnim!.value * 0.2),
                  blurRadius: 4 + pulseAnim!.value * 4,
                ),
              ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Status hero ────────────────────────────────────────────────────────────────

class _StatusHero extends StatelessWidget {
  const _StatusHero({
    required this.pulseAnim,
    required this.step,
    required this.minutes,
  });

  final Animation<double> pulseAnim;
  final int step;
  final int minutes;

  static const _emoji = ['✅', '🍳', '🛵', '🏠'];
  static const _titles = [
    'Your order has been confirmed',
    'Preparing your hot pot',
    'Your order is on the way!',
    'Order delivered',
  ];
  static const _subtitles = [
    'Restaurant is confirming your order',
    'Chef is preparing your hot pot',
    'Ahmad is riding to you',
    'Enjoy your meal!',
  ];

  @override
  Widget build(BuildContext context) {
    final delivered = step >= 3;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryHover],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Pulsing status icon
          AnimatedBuilder(
            animation: pulseAnim,
            builder: (context, _) => Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2 + (pulseAnim.value - 0.85) * 1.5),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(_emoji[step], style: const TextStyle(fontSize: 26)),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _titles[step],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _subtitles[step],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xE6FFFFFF),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      delivered
                          ? Icons.check_circle_rounded
                          : Icons.access_time_rounded,
                      size: 13,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      delivered
                          ? 'Delivered • Enjoy!'
                          : step == 0
                              ? 'Estimated ~$minutes min'
                              : 'Arriving in ~$minutes min',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Rider marker ──────────────────────────────────────────────────────────────

class _RiderMarker extends StatelessWidget {
  const _RiderMarker({required this.pulseAnim});
  final Animation<double> pulseAnim;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: pulseAnim,
          builder: (_, _) => Transform.scale(
            scale: pulseAnim.value,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Center(
            child: Text('🛵', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }
}

// ── Destination marker ────────────────────────────────────────────────────────

class _DestinationMarker extends StatelessWidget {
  const _DestinationMarker();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary,
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withValues(alpha: 0.4),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Center(
            child: Text('🏠', style: TextStyle(fontSize: 20)),
          ),
        ),
        const CustomPaint(
          size: Size(12, 8),
          painter: _PinTailPainter(color: AppColors.secondary),
        ),
      ],
    );
  }
}

class _PinTailPainter extends CustomPainter {
  const _PinTailPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_PinTailPainter old) => old.color != color;
}

// ── ETA chip ──────────────────────────────────────────────────────────────────

class _EtaChip extends StatelessWidget {
  const _EtaChip({required this.step, required this.minutes});

  final int step;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    final delivered = step >= 3;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            delivered ? Icons.check_circle_rounded : Icons.access_time_rounded,
            size: 16,
            color: delivered ? AppColors.secondary : AppColors.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              delivered ? 'Order delivered' : 'Estimated arrival',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            delivered ? 'Done' : '$minutes min',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: delivered ? AppColors.secondary : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Rider card ────────────────────────────────────────────────────────────────

class _RiderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderDivider),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBg,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: const Center(
                child: Text('👨', style: TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ahmad Rider',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.foreground,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_rounded,
                          size: 13, color: AppColors.secondary),
                      SizedBox(width: 3),
                      Text(
                        '4.9  •  Honda Vario  •  B 1234 XYZ',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _ContactBtn(
                  icon: Icons.phone_outlined,
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                _ContactBtn(
                  icon: Icons.chat_bubble_outline_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactBtn extends StatelessWidget {
  const _ContactBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primaryBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}

// ── Progress bar ──────────────────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.currentStep});
  final int currentStep;

  static const _steps = [
    _Step(icon: '✅', label: 'Confirmed'),
    _Step(icon: '🍳', label: 'Preparing'),
    _Step(icon: '🛵', label: 'On the Way'),
    _Step(icon: '🏠', label: 'Delivered'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(_steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // connector line
            final stepIndex = i ~/ 2;
            final done = stepIndex < currentStep;
            return Expanded(
              child: Container(
                height: 2,
                color: done ? AppColors.primary : AppColors.borderDivider,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final done = stepIndex <= currentStep;
          final active = stepIndex == currentStep;
          return SizedBox(
            width: 52,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: active ? 40 : 34,
                  height: active ? 40 : 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done ? AppColors.primary : AppColors.background,
                    border: Border.all(
                      color: done
                          ? AppColors.primary
                          : AppColors.borderDivider,
                      width: active ? 2 : 1,
                    ),
                    boxShadow: active
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      _steps[stepIndex].icon,
                      style: TextStyle(fontSize: active ? 18 : 14),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _steps[stepIndex].label,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.2,
                    fontWeight:
                        active ? FontWeight.w700 : FontWeight.w500,
                    color: done
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _Step {
  final String icon;
  final String label;
  const _Step({required this.icon, required this.label});
}

// ── Order summary row ─────────────────────────────────────────────────────────

class _OrderSummaryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderDivider),
        ),
        child: Row(
          children: [
            const Text('🔥🥩🦐', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CDH-20240813-0042',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.foreground,
                    ),
                  ),
                  Text(
                    '5 items  •  Rp 505.000',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => context.push('/invoice'),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Invoice',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Invoice button ────────────────────────────────────────────────────────────

class _InvoiceButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 4),
        child: ElevatedButton.icon(
          onPressed: () => context.push('/invoice'),
          icon: const Icon(Icons.receipt_long_outlined,
              size: 16, color: Colors.white),
          label: const Text(
            'View Invoice',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
