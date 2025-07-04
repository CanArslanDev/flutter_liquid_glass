import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/models/liquid_glass_config.dart';
import 'package:flutter_liquid_glass/src/painters/liquid_glass_painter.dart';

/// Applies the Liquid Glass effect to a child widget
class LiquidGlassEffect extends StatelessWidget {
  const LiquidGlassEffect({
    super.key,
    required this.child,
    required this.config,
    this.isPressed = false,
    this.isHovered = false,
    this.localPosition = Offset.zero,
    this.hoverAnimation = 0.0,
  });
  final Widget child;
  final LiquidGlassConfig config;
  final bool isPressed;
  final bool isHovered;
  final Offset localPosition;
  final double hoverAnimation;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: config.borderRadius,
      child: Stack(
        children: [
          // Background blur layer
          if (config.blurAmount > 0)
            BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: config.blurAmount,
                sigmaY: config.blurAmount,
              ),
              child: Container(),
            ),

          // Frost effect layer
          if (config.frostIntensity > 0)
            BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: config.blurAmount * (1 + config.frostIntensity),
                sigmaY: config.blurAmount * (1 + config.frostIntensity),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white
                          .withValues(alpha: config.frostIntensity * 0.1),
                      Colors.white
                          .withValues(alpha: config.frostIntensity * 0.05),
                    ],
                  ),
                ),
              ),
            ),

          // Glass layer with custom painter
          CustomPaint(
            painter: LiquidGlassPainter(
              config: config,
              isPressed: isPressed,
              isHovered: isHovered,
              localPosition: localPosition,
              hoverAnimation: hoverAnimation,
            ),
            child: Container(),
          ),

          // Content
          child,

          // Specular highlight overlay
          if (config.enableSpecularHighlight)
            IgnorePointer(
              child: CustomPaint(
                painter: SpecularHighlightPainter(
                  config: config,
                  isPressed: isPressed,
                  isHovered: isHovered,
                  localPosition: localPosition,
                ),
                child: Container(),
              ),
            ),
        ],
      ),
    );
  }
}

/// Painter for specular highlights
class SpecularHighlightPainter extends CustomPainter {
  SpecularHighlightPainter({
    required this.config,
    required this.isPressed,
    required this.isHovered,
    required this.localPosition,
  });
  final LiquidGlassConfig config;
  final bool isPressed;
  final bool isHovered;
  final Offset localPosition;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: isPressed ? 0.3 : 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    final center = Offset(
      size.width * config.lightPosition.dx,
      size.height * config.lightPosition.dy,
    );

    final radius = size.shortestSide * 0.3;

    // Draw specular highlight
    canvas.drawCircle(center, radius, paint);

    // Draw secondary highlight if hovered
    if (isHovered && config.enableDynamicLight) {
      final hoverPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

      canvas.drawCircle(localPosition, radius * 0.5, hoverPaint);
    }
  }

  @override
  bool shouldRepaint(SpecularHighlightPainter oldDelegate) {
    return oldDelegate.isPressed != isPressed ||
        oldDelegate.isHovered != isHovered ||
        oldDelegate.localPosition != localPosition;
  }
}
