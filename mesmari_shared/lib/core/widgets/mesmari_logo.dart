import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_text.dart';
import 'package:mesmari_shared/core/widgets/svg_icon.dart';

/// "مسماري" wordmark with the nail mark.
class MesmariLogo extends StatelessWidget {
  const MesmariLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 179,
      height: 73,
      child: Stack(
        textDirection: TextDirection.ltr,
        children: [
          Positioned(
            left: 0,
            top: 22,
            width: 178,
            height: 51,
            child: Text(
              'مسماري',
              textAlign: TextAlign.center,
              style: amiri(48, height: 35 / 48),
            ),
          ),
          const Positioned(
            left: 132,
            top: 0,
            child: SvgIcon('logo', width: 47, height: 50.5),
          ),
        ],
      ),
    );
  }
}
