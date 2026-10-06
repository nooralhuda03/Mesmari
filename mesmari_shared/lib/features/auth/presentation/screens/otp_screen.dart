import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/auth/presentation/widgets/auth_widgets.dart';

/// Figma 149 — enter verification code.
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone});

  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // The design draws 6 boxes (its copy says 4 digits).
  static const _length = 6;

  late final List<TextEditingController> _controllers = List.generate(
    _length,
    (_) => TextEditingController(),
  );
  late final List<FocusNode> _nodes = List.generate(
    _length,
    (_) => FocusNode(),
  );

  Timer? _timer;
  int _seconds = 41;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = 41);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds == 0) {
        t.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _onChanged(int i, String value) {
    if (value.isNotEmpty && i < _length - 1) {
      _nodes[i + 1].requestFocus();
    } else if (value.isEmpty && i > 0) {
      _nodes[i - 1].requestFocus();
    }
  }

  void _confirm() {
    if (_code.length < _length) {
      showSnack(context, tr('write_full_code'));
      return;
    }
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final timerText = '00:${_seconds.toString().padLeft(2, '0')}';
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 35),
              const Center(child: MesmariLogo()),
              const SizedBox(height: 37),
              AuthHeading(
                title: tr('otp_title'),
                body: '${tr('otp_body')} ${widget.phone}',
              ),
              const SizedBox(height: 26),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < _length; i++) ...[
                      if (i > 0) const SizedBox(width: 10),
                      _box(i),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: _seconds == 0 ? _startTimer : null,
                  child: Text(
                    _seconds == 0
                        ? tr('otp_resend')
                        : '${tr('otp_resend')} $timerText',
                    style: almarai(
                      13,
                      height: 1.7,
                      color: _seconds == 0
                          ? AppColors.primary
                          : const Color(0xFFA2A2A2),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              PrimaryButton(label: tr('otp_confirm'), onTap: _confirm),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box(int i) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0x75004957)),
    );
    return SizedBox(
      width: 39,
      height: 39,
      child: TextField(
        controller: _controllers[i],
        focusNode: _nodes[i],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: cairo(16, weight: bold, color: AppColors.primary),
        onChanged: (v) => _onChanged(i, v),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xA1FFFFFF),
          contentPadding: EdgeInsets.zero,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}

/// Route arguments for [OtpScreen].
class OtpArgs {
  const OtpArgs({required this.phone});

  final String phone;
}
