import 'package:flutter/material.dart';

import 'package:flutter_liquid_glass/src/models/liquid_glass_config.dart';
import 'package:flutter_liquid_glass/src/widgets/liquid_glass_container.dart';

/// A card widget with Liquid Glass effect
class LiquidGlassCard extends StatelessWidget {
  const LiquidGlassCard({
    super.key,
    required this.child,
    this.config = const LiquidGlassConfig(),
    this.elevation = 4.0,
    this.margin,
    this.onTap,
  });

  /// Child widget
  final Widget child;

  /// Configuration for the liquid glass effect
  final LiquidGlassConfig config;

  /// Card elevation effect
  final double elevation;

  /// Margin around the card
  final EdgeInsetsGeometry? margin;

  /// Whether the card is clickable
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cardConfig = config.copyWith(
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1 * elevation / 4),
          blurRadius: elevation * 2,
          offset: Offset(0, elevation),
        ),
      ],
    );

    return LiquidGlassContainer(
      config: cardConfig,
      margin: margin,
      onTap: onTap,
      child: child,
    );
  }
}
