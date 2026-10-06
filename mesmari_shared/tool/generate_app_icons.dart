// Generates the launcher icon PNGs from the Mesmari nail mark.
// Run: flutter test tool/generate_app_icons.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> renderIcon({
  required String out,
  required Color background,
  required Color mark,
  double size = 1024,
}) async {
  final hex =
      '#${mark.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  final svg = File(
    'assets/icons/logo.svg',
  ).readAsStringSync().replaceAll('#004957', hex);

  final picture = await vg.loadPicture(SvgStringLoader(svg), null);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size, size));
  canvas.drawRect(Rect.fromLTWH(0, 0, size, size), Paint()..color = background);

  // the mark takes ~46% of the icon, centred
  final scale = (size * 0.46) / picture.size.height;
  canvas.save();
  canvas.translate(
    (size - picture.size.width * scale) / 2,
    (size - picture.size.height * scale) / 2,
  );
  canvas.scale(scale);
  canvas.drawPicture(picture.picture);
  canvas.restore();

  final image = await recorder.endRecording().toImage(
    size.toInt(),
    size.toInt(),
  );
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  File(out).writeAsBytesSync(bytes!.buffer.asUint8List());
  stdout.writeln('wrote $out');
}

void main() {
  testWidgets('generate launcher icons', (tester) async {
    await tester.runAsync(() async {
      await renderIcon(
        out: '/tmp/icon_student.png',
        background: const Color(0xFF004957),
        mark: const Color(0xFFECF5F7),
      );
      await renderIcon(
        out: '/tmp/icon_teacher.png',
        background: const Color(0xFF1B5F80),
        mark: const Color(0xFFECF5F7),
      );
    });
  });
}
