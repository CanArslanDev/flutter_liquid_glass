import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/models/liquid_glass_config.dart';

/// Custom painter for specular highlights on the glass surface
class SpecularHighlightPainter extends CustomPainter {
  SpecularHighlightPainter({
    required this.config,
    required this.isPressed,
    required this.isHovered,
    required this.localPosition,
    this.animationProgress = 0.0,
  });
  final LiquidGlassConfig config;
  final bool isPressed;
  final bool isHovered;
  final Offset localPosition;
  final double animationProgress;

  @override
  void paint(Canvas canvas, Size size) {
    if (!config.enableSpecularHighlight) return;

    // Primary specular highlight
    _drawPrimaryHighlight(canvas, size);

    // Secondary interactive highlight
    if (isHovered || isPressed) {
      _drawInteractiveHighlight(canvas, size);
    }

    // Edge highlights for glass thickness effect
    if (config.glassThickness > 0) {
      _drawEdgeHighlights(canvas, size);
    }

    // Chromatic aberration effect
    if (config.enableChromaticAberration) {
      _drawChromaticAberration(canvas, size);
    }
  }

  void _drawPrimaryHighlight(Canvas canvas, Size size) {
    final center = Offset(
      size.width * config.lightPosition.dx,
      size.height * config.lightPosition.dy,
    );

    // Main highlight
    final highlightPaint = Paint()
      ..shader = ui.Gradient.radial(
        center,
        size.shortestSide * 0.3,
        [
          Colors.white.withValues(alpha: isPressed ? 0.4 : 0.2),
          Colors.white.withValues(alpha: isPressed ? 0.2 : 0.1),
          Colors.transparent,
        ],
        [0.0, 0.5, 1.0],
      )
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        isPressed ? 15 : 20,
      );

    canvas.drawCircle(
      center,
      size.shortestSide * 0.3,
      highlightPaint,
    );

    // Subtle secondary highlight
    final secondaryPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);

    canvas.drawCircle(
      Offset(center.dx + 20, center.dy + 20),
      size.shortestSide * 0.2,
      secondaryPaint,
    );
  }

  void _drawInteractiveHighlight(Canvas canvas, Size size) {
    final interactivePaint = Paint()
      ..shader = ui.Gradient.radial(
        localPosition,
        size.shortestSide * 0.25,
        [
          Colors.white.withValues(alpha: 0.15),
          Colors.white.withValues(alpha: 0.05),
          Colors.transparent,
        ],
        [0.0, 0.6, 1.0],
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    // Animate the highlight size
    final animatedRadius = size.shortestSide *
        0.25 *
        (1 + math.sin(animationProgress * 2 * math.pi) * 0.1);

    canvas.drawCircle(
      localPosition,
      animatedRadius,
      interactivePaint,
    );
  }

  void _drawEdgeHighlights(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = config.borderRadius.toRRect(rect);

    // Top edge highlight
    final topEdgePaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(0, config.glassThickness * 10),
        [
          Colors.white.withValues(alpha: 0.3 * config.glassThickness),
          Colors.transparent,
        ],
      )
      ..style = PaintingStyle.fill;

    final topPath = Path()
      ..addRRect(rrect)
      ..addRect(
        Rect.fromLTWH(
          0,
          config.glassThickness * 10,
          size.width,
          size.height,
        ),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(topPath, topEdgePaint);

    // Left edge highlight
    final leftEdgePaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(config.glassThickness * 10, 0),
        [
          Colors.white.withValues(alpha: 0.2 * config.glassThickness),
          Colors.transparent,
        ],
      )
      ..style = PaintingStyle.fill;

    final leftPath = Path()
      ..addRRect(rrect)
      ..addRect(
        Rect.fromLTWH(
          config.glassThickness * 10,
          0,
          size.width,
          size.height,
        ),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(leftPath, leftEdgePaint);
  }

  void _drawChromaticAberration(Canvas canvas, Size size) {
    final center = Offset(
      size.width * config.lightPosition.dx,
      size.height * config.lightPosition.dy,
    );

    // Red channel offset
    final redPaint = Paint()
      ..color = Colors.red.withValues(alpha: 0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
      ..blendMode = BlendMode.screen;

    canvas.drawCircle(
      center + const Offset(-2, 0),
      size.shortestSide * 0.15,
      redPaint,
    );

    // Blue channel offset
    final bluePaint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
      ..blendMode = BlendMode.screen;

    canvas.drawCircle(
      center + const Offset(2, 0),
      size.shortestSide * 0.15,
      bluePaint,
    );
  }

  @override
  bool shouldRepaint(SpecularHighlightPainter oldDelegate) {
    return oldDelegate.isPressed != isPressed ||
        oldDelegate.isHovered != isHovered ||
        oldDelegate.localPosition != localPosition ||
        oldDelegate.animationProgress != animationProgress ||
        oldDelegate.config != config;
  }
}
