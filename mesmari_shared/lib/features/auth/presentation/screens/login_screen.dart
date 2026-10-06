import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:mesmari_shared/features/profile/data/profile_controller.dart';

import 'otp_screen.dart';

/// Sign in with an existing account.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phone = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  void _submit() {
    final phone = _phone.text.trim();
    if (phone.length < 10) {
      showSnack(context, tr('write_valid_phone'));
      return;
    }
    ProfileController.instance.setPhone(phone);
    Navigator.of(
      context,
    ).pushNamed(AppRoutes.otp, arguments: OtpArgs(phone: phone));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 22),
              const Center(child: MesmariLogo()),
              const SizedBox(height: 37),
              AuthHeading(title: tr('login'), body: tr('login_body')),
              const SizedBox(height: 16),
              AuthField(
                hint: '07XXXXXXXXX',
                controller: _phone,
                keyboardType: TextInputType.phone,
                hintStyle: poppins(15, color: AppColors.hint, height: 1.7),
              ),
              const Spacer(),
              PrimaryButton(label: tr('login'), onTap: _submit),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr('no_account'),
                    style: almarai(12.5, color: AppColors.muted),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.signup),
                    child: Text(
                      tr('create_new_account'),
                      style: almarai(
                        12.5,
                        weight: bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
