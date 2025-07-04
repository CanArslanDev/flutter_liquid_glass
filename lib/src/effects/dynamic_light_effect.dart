import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/models/liquid_glass_config.dart';

/// Dynamic light effect that responds to user interaction and device movement
class DynamicLightEffect extends StatefulWidget {
  const DynamicLightEffect({
    super.key,
    required this.child,
    required this.config,
    this.isActive = true,
    this.pointerPosition,
  });
  final Widget child;
  final LiquidGlassConfig config;
  final bool isActive;
  final Offset? pointerPosition;

  @override
  State<DynamicLightEffect> createState() => _DynamicLightEffectState();
}

class _DynamicLightEffectState extends State<DynamicLightEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _lightAnimation;
  Offset _lightPosition = const Offset(0.5, 0.3);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _lightAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    if (widget.isActive) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(DynamicLightEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.repeat();
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateLightPosition(Size size) {
    if (widget.pointerPosition != null) {
      setState(() {
        _lightPosition = Offset(
          widget.pointerPosition!.dx / size.width,
          widget.pointerPosition!.dy / size.height,
        );
      });
    } else if (widget.config.enableDynamicLight) {
      // Animate light position in a circular pattern
      final angle = _lightAnimation.value;
      const radius = 0.2;
      setState(() {
        _lightPosition = Offset(
          0.5 + radius * math.cos(angle),
          0.3 + radius * math.sin(angle),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _lightAnimation,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            _updateLightPosition(constraints.biggest);

            return CustomPaint(
              painter: DynamicLightPainter(
                config: widget.config,
                lightPosition: _lightPosition,
                animationValue: _lightAnimation.value,
              ),
              child: widget.child,
            );
          },
        );
      },
    );
  }
}

class DynamicLightPainter extends CustomPainter {
  DynamicLightPainter({
    required this.config,
    required this.lightPosition,
    required this.animationValue,
  });
  final LiquidGlassConfig config;
  final Offset lightPosition;
  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    if (!config.enableDynamicLight) return;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final center = Offset(
      size.width * lightPosition.dx,
      size.height * lightPosition.dy,
    );

    // Create dynamic gradient based on light position
    final gradient = RadialGradient(
      center: Alignment(
        lightPosition.dx * 2 - 1,
        lightPosition.dy * 2 - 1,
      ),
      radius: 1.5,
      colors: [
        Colors.white.withValues(alpha: 0.2),
        Colors.white.withValues(alpha: 0.1),
        Colors.transparent,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..blendMode = BlendMode.overlay;

    canvas.drawRect(rect, paint);

    // Add shimmer effect
    if (config.enableSpecularHighlight) {
      final shimmerPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.05)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

      final shimmerRadius = size.shortestSide * 0.2;
      final shimmerOffset = Offset(
        math.sin(animationValue) * 20,
        math.cos(animationValue) * 10,
      );

      canvas.drawCircle(
        center + shimmerOffset,
        shimmerRadius,
        shimmerPaint,
      );
    }

    // Add light rays effect
    if (config.refractionIntensity > 0.5) {
      _drawLightRays(canvas, size, center);
    }
  }

  void _drawLightRays(Canvas canvas, Size size, Offset center) {
    final rayPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    const rayCount = 6;
    final rayLength = size.longestSide * 0.3;

    for (var i = 0; i < rayCount; i++) {
      final angle = (2 * math.pi / rayCount) * i + animationValue * 0.5;
      final endPoint = Offset(
        center.dx + math.cos(angle) * rayLength,
        center.dy + math.sin(angle) * rayLength,
      );

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(endPoint.dx, endPoint.dy);

      canvas.drawPath(path, rayPaint);
    }
  }

  @override
  bool shouldRepaint(DynamicLightPainter oldDelegate) {
    return oldDelegate.lightPosition != lightPosition ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.config != config;
  }
}
