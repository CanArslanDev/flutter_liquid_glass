import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/models/liquid_glass_config.dart';

/// Custom painter for the Liquid Glass effect
class LiquidGlassPainter extends CustomPainter {
  LiquidGlassPainter({
    required this.config,
    required this.isPressed,
    required this.isHovered,
    required this.localPosition,
    required this.hoverAnimation,
  });
  final LiquidGlassConfig config;
  final bool isPressed;
  final bool isHovered;
  final Offset localPosition;
  final double hoverAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = config.borderRadius.toRRect(rect);

    // Base glass layer
    final glassPaint = Paint()
      ..color =
          (config.baseColor ?? Colors.white).withValues(alpha: config.opacity)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(rrect, glassPaint);

    // Gradient overlay
    if (config.gradient != null) {
      final gradientPaint = Paint()
        ..shader = config.gradient!.createShader(rect)
        ..blendMode = BlendMode.overlay;

      canvas.drawRRect(rrect, gradientPaint);
    }

    // Dynamic color adaptation effect
    if (config.adaptToContent && isHovered) {
      final adaptivePaint = Paint()
        ..color = Colors.blue.withValues(alpha: 0.05 * hoverAnimation)
        ..style = PaintingStyle.fill;

      canvas.drawRRect(rrect, adaptivePaint);
    }

    // Refraction effect
    if (config.refractionIntensity > 0) {
      _drawRefractionEffect(canvas, size, rrect);
    }

    // Border
    if (config.border != null) {
      final borderPaint = Paint()
        ..color = config.border!.top.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = config.border!.top.width;

      canvas.drawRRect(rrect, borderPaint);
    }

    // Morphing effect when pressed
    if (config.enableMorphing && isPressed) {
      _drawMorphingEffect(canvas, size, rrect);
    }
  }

  void _drawRefractionEffect(Canvas canvas, Size size, RRect rrect) {
    final refractionPaint = Paint()
      ..color = Colors.white.withValues(alpha: config.refractionIntensity * 0.1)
      ..maskFilter =
          MaskFilter.blur(BlurStyle.normal, 10 * config.glassThickness);

    // Top edge refraction
    final topPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - 10, 10)
      ..lineTo(10, 10)
      ..close();

    canvas.drawPath(topPath, refractionPaint);

    // Left edge refraction
    final leftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(10, size.height - 10)
      ..lineTo(10, 10)
      ..close();

    canvas.drawPath(leftPath, refractionPaint);
  }

  void _drawMorphingEffect(Canvas canvas, Size size, RRect rrect) {
    final morphPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    // Create a slightly distorted shape
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    for (var i = 0; i < 360; i += 10) {
      final angle = i * math.pi / 180;
      final distortion = math.sin(angle * 3) * config.distortionAmount * 10;
      final x = center.dx + (radius + distortion) * math.cos(angle);
      final y = center.dy + (radius + distortion) * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, morphPaint);
  }

  @override
  bool shouldRepaint(LiquidGlassPainter oldDelegate) {
    return oldDelegate.isPressed != isPressed ||
        oldDelegate.isHovered != isHovered ||
        oldDelegate.localPosition != localPosition ||
        oldDelegate.hoverAnimation != hoverAnimation ||
        oldDelegate.config != config;
  }
}
