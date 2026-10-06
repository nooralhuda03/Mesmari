import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders an icon exported from Figma (`assets/icons/<name>.svg`).
class SvgIcon extends StatelessWidget {
  const SvgIcon(
    this.name, {
    super.key,
    this.size = 20,
    this.width,
    this.height,
    this.color,
  });

  final String name;
  final double size;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      package: 'mesmari_shared',
      width: width ?? size,
      height: height ?? size,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}
