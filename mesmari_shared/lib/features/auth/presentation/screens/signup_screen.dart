import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:mesmari_shared/features/profile/data/profile_controller.dart';

import 'otp_screen.dart';

/// Create a new account.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  void _create() {
    final name = _name.text.trim();
    final phone = _phone.text.trim();
    if (name.isEmpty) {
      showSnack(context, tr('write_full_name'));
      return;
    }
    if (phone.length < 10) {
      showSnack(context, tr('write_valid_phone'));
      return;
    }
    final controller = ProfileController.instance;
    controller.save(
      controller.profile.copyWith(
        name: name,
        phone: phone,
        address: _address.text.trim(),
      ),
    );
    Navigator.of(
      context,
    ).pushNamed(AppRoutes.otp, arguments: OtpArgs(phone: phone));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 10),
                  const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: LanguageToggle(),
                  ),
                  const SizedBox(height: 12),
                  const Center(child: MesmariLogo()),
                  const SizedBox(height: 25),
                  AuthHeading(
                    title: tr('signup_title'),
                    body: tr('signup_body'),
                  ),
                  const SizedBox(height: 16),
                  AuthField(hint: tr('your_full_name'), controller: _name),
                  const SizedBox(height: 10),
                  AuthField(
                    hint: '07XXXXXXXXX',
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    hintStyle: poppins(15, color: AppColors.hint, height: 1.7),
                  ),
                  const SizedBox(height: 10),
                  AuthField(hint: tr('your_address'), controller: _address),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  PrimaryButton(label: tr('signup_button'), onTap: _create),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr('have_account'),
                        style: almarai(12.5, color: AppColors.muted),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          tr('sign_in_link'),
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
          ],
        ),
      ),
    );
  }
}
