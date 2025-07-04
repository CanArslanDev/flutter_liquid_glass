import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/models/liquid_glass_config.dart';
import 'package:flutter_liquid_glass/src/widgets/liquid_glass_container.dart';

/// A button widget with Liquid Glass effect
class LiquidGlassButton extends StatelessWidget {
  const LiquidGlassButton({
    super.key,
    this.child,
    this.text,
    this.textStyle,
    this.icon,
    this.iconSize = 24.0,
    this.iconColor,
    this.config = const LiquidGlassConfig(),
    this.onPressed,
    this.onLongPressed,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.enableHapticFeedback = true,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = LiquidGlassButtonSize.medium,
  });

  factory LiquidGlassButton.icon({
    Key? key,
    required IconData icon,
    double iconSize = 24.0,
    Color? iconColor,
    LiquidGlassConfig config = const LiquidGlassConfig(),
    VoidCallback? onPressed,
    VoidCallback? onLongPressed,
    bool enableHapticFeedback = true,
    bool isLoading = false,
    bool isDisabled = false,
    LiquidGlassButtonSize size = LiquidGlassButtonSize.medium,
  }) {
    return LiquidGlassButton(
      key: key,
      icon: icon,
      iconSize: iconSize,
      iconColor: iconColor,
      config: config,
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      padding: EdgeInsets.all(_getPaddingForSize(size)),
      enableHapticFeedback: enableHapticFeedback,
      isLoading: isLoading,
      isDisabled: isDisabled,
      size: size,
    );
  }

  /// Button text or child widget
  final Widget? child;

  /// Button text (if child is not provided)
  final String? text;

  /// Text style
  final TextStyle? textStyle;

  /// Icon to display
  final IconData? icon;

  /// Icon size
  final double iconSize;

  /// Icon color
  final Color? iconColor;

  /// Configuration for the liquid glass effect
  final LiquidGlassConfig config;

  /// Callback when pressed
  final VoidCallback? onPressed;

  /// Callback when long pressed
  final VoidCallback? onLongPressed;

  /// Button width
  final double? width;

  /// Button height
  final double? height;

  /// Padding inside the button
  final EdgeInsetsGeometry padding;

  /// Enable haptic feedback
  final bool enableHapticFeedback;

  /// Loading state
  final bool isLoading;

  /// Disabled state
  final bool isDisabled;

  /// Button size preset
  final LiquidGlassButtonSize size;

  static double _getPaddingForSize(LiquidGlassButtonSize size) {
    switch (size) {
      case LiquidGlassButtonSize.small:
        return 8;
      case LiquidGlassButtonSize.medium:
        return 12;
      case LiquidGlassButtonSize.large:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTextStyle = textStyle ?? theme.textTheme.bodyLarge;
    final effectiveIconColor = iconColor ?? theme.iconTheme.color;

    Widget? content;

    if (isLoading) {
      content = SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            effectiveTextStyle?.color ?? theme.colorScheme.onSurface,
          ),
        ),
      );
    } else if (child != null) {
      content = child;
    } else if (text != null && icon != null) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: effectiveIconColor),
          const SizedBox(width: 8),
          Text(text!, style: effectiveTextStyle),
        ],
      );
    } else if (text != null) {
      content = Text(text!, style: effectiveTextStyle);
    } else if (icon != null) {
      content = Icon(icon, size: iconSize, color: effectiveIconColor);
    }

    final effectiveConfig = isDisabled
        ? config.copyWith(
            opacity: config.opacity * 0.5,
            enableSpecularHighlight: false,
            enableDynamicLight: false,
          )
        : config;

    return LiquidGlassContainer(
      config: effectiveConfig,
      width: width,
      height: height,
      padding: padding,
      onTap: isDisabled || isLoading ? null : onPressed,
      onLongPress: isDisabled || isLoading ? null : onLongPressed,
      enableHapticFeedback: enableHapticFeedback,
      child: content,
    );
  }
}

enum LiquidGlassButtonSize {
  small,
  medium,
  large,
}
