import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  static const int _otpLength = 6;
  static const int _resendSeconds = 60;

  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  int _countdown = _resendSeconds;
  Timer? _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    _startTimer();
    _ctrl.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _countdown = _resendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_countdown <= 0) {
        t.cancel();
      } else {
        setState(() => _countdown--);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (value.length == _otpLength) {
      _onVerify();
    }
  }

  void _onVerify() async {
    if (_isVerifying) return;
    setState(() => _isVerifying = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) {
      setState(() => _isVerifying = false);
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // ── Back button ──────────────────────────────────────
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.borderDivider),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                            color: AppColors.foreground,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ── Card ─────────────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 40),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Mail icon
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryBg,
                              border: Border.all(
                                  color: AppColors.primaryMuted, width: 1.5),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.mark_email_read_outlined,
                                size: 32,
                                color: AppColors.primary,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            'Check your Email',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.foreground,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "We've sent a 6-digit confirmation code to your inbox. It expires in 10 minutes.",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 32),

                          // ── OTP input (hidden) + box overlay ───────────
                          _OtpInputField(
                            controller: _ctrl,
                            focusNode: _focusNode,
                            length: _otpLength,
                            onChanged: _onChanged,
                          ),

                          const SizedBox(height: 12),

                          // ── Timer ─────────────────────────────────────
                          Text(
                            _countdown > 0
                                ? 'Code expires in 0:${_countdown.toString().padLeft(2, '0')}'
                                : 'Code expired',
                            style: TextStyle(
                              fontSize: 12,
                              color: _countdown > 0
                                  ? AppColors.textSecondary
                                  : AppColors.danger,
                            ),
                          ),

                          const SizedBox(height: 28),

                          // ── Verify button ──────────────────────────────
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isVerifying ||
                                      _ctrl.text.length < _otpLength
                                  ? null
                                  : _onVerify,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(52),
                                disabledBackgroundColor: AppColors.primaryMuted,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: _isVerifying
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : const Text(
                                      'Verify & Continue',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // ── Resend link ────────────────────────────────
                          GestureDetector(
                            onTap: _countdown <= 0 ? _startTimer : null,
                            child: Text(
                              'Resend code to email',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _countdown <= 0
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                decoration: _countdown <= 0
                                    ? TextDecoration.underline
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // ── Security note ──────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline,
                            size: 12,
                            color: AppColors.textSecondary.withValues(alpha: 0.7),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Secure and encrypted verification',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── OTP Input Field ───────────────────────────────────────────────────────────
// Satu TextField tersembunyi, 6 box overlay yang membaca teks dari controller.

class _OtpInputField extends StatefulWidget {
  const _OtpInputField({
    required this.controller,
    required this.focusNode,
    required this.length,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;
  final ValueChanged<String> onChanged;

  @override
  State<_OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<_OtpInputField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final code = widget.controller.text;
    final focused = widget.focusNode.hasFocus;

    return GestureDetector(
      onTap: () => widget.focusNode.requestFocus(),
      child: Stack(
        children: [
          // Hidden TextField — menangkap semua keyboard input
          Opacity(
            opacity: 0,
            child: SizedBox(
              height: 0,
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: TextInputType.number,
                maxLength: widget.length,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(counterText: ''),
                onChanged: widget.onChanged,
              ),
            ),
          ),

          // Box overlay — 6 box visual
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.length, (i) {
              final hasDigit = i < code.length;
              final isActive = focused && i == code.length;
              final isPast = focused && i < code.length;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 46,
                height: 56,
                decoration: BoxDecoration(
                  color: hasDigit
                      ? AppColors.primaryBg
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive
                        ? AppColors.primary
                        : isPast
                            ? AppColors.primaryMuted
                            : AppColors.borderDivider,
                    width: isActive ? 2 : 1.5,
                  ),
                ),
                child: Center(
                  child: hasDigit
                      ? Text(
                          code[i],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            height: 1.0,
                          ),
                        )
                      : isActive
                          ? _BlinkingCursor()
                          : const SizedBox.shrink(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ── Blinking cursor ───────────────────────────────────────────────────────────

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 2,
        height: 24,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}
