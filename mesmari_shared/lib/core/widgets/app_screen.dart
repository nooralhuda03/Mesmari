import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/app_text.dart';
import 'package:mesmari_shared/core/widgets/circle_icon_button.dart';

/// Standard pushed page: title, close button, scrolling body and an
/// optional pinned footer.
class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.title,
    required this.content,
    this.subtitle,
    this.footer,
    this.padding = const EdgeInsets.fromLTRB(20, 16, 20, 24),
  });

  final String title;
  final String? subtitle;
  final List<Widget> content;
  final Widget? footer;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: cairo(
                            20,
                            weight: bold,
                            color: AppColors.primary,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: almarai(12, color: AppColors.muted),
                          ),
                        ],
                      ],
                    ),
                  ),
                  CircleIconButton(
                    icon: 't_close',
                    iconSize: 13,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(padding: padding, children: content),
            ),
            if (footer != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: footer!,
              ),
          ],
        ),
      ),
    );
  }
}

/// Heading above a group of cards.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: cairo(15, weight: bold)),
  );
}

/// White rounded card with the standard border.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: (color ?? AppColors.card),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Label (+ hint) with a switch, inside a card.
class SwitchTile extends StatelessWidget {
  const SwitchTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 6, 4),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: almarai(13, weight: bold, color: AppColors.text),
              ),
              if (subtitle != null)
                Text(subtitle!, style: almarai(11, color: AppColors.muted)),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    ),
  );
}
