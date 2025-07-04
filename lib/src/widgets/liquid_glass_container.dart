import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_liquid_glass/src/effects/liquid_glass_effect.dart';
import 'package:flutter_liquid_glass/src/models/liquid_glass_config.dart';

/// A container widget with Liquid Glass effect
class LiquidGlassContainer extends StatefulWidget {
  const LiquidGlassContainer({
    super.key,
    this.child,
    this.config = const LiquidGlassConfig(),
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment,
    this.constraints,
    this.onTap,
    this.onLongPress,
    this.enableHapticFeedback = true,
    this.backgroundDecoration,
  });

  /// Child widget
  final Widget? child;

  /// Configuration for the liquid glass effect
  final LiquidGlassConfig config;

  /// Width of the container
  final double? width;

  /// Height of the container
  final double? height;

  /// Padding inside the container
  final EdgeInsetsGeometry? padding;

  /// Margin outside the container
  final EdgeInsetsGeometry? margin;

  /// Alignment of child
  final AlignmentGeometry? alignment;

  /// Constraints
  final BoxConstraints? constraints;

  /// Callback when tapped
  final VoidCallback? onTap;

  /// Callback when long pressed
  final VoidCallback? onLongPress;

  /// Enable haptic feedback
  final bool enableHapticFeedback;

  /// Custom decoration behind the glass
  final Decoration? backgroundDecoration;

  @override
  State<LiquidGlassContainer> createState() => _LiquidGlassContainerState();
}

class _LiquidGlassContainerState extends State<LiquidGlassContainer>
    with TickerProviderStateMixin {
  late AnimationController _pressController;
  late AnimationController _hoverController;
  late AnimationController _parallaxController;

  late Animation<double> _pressAnimation;
  late Animation<double> _hoverAnimation;

  bool _isPressed = false;
  bool _isHovered = false;
  Offset _localPosition = Offset.zero;

  @override
  void initState() {
    super.initState();

    _pressController = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );

    _hoverController = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );

    _parallaxController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _pressAnimation = Tween<double>(
      begin: 1,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _pressController,
        curve: widget.config.animationCurve,
      ),
    );

    _hoverAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: widget.config.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    _hoverController.dispose();
    _parallaxController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    setState(() {
      _isPressed = true;
      _localPosition = details.localPosition;
    });
    _pressController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _pressController.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _pressController.reverse();
  }

  void _handleHover(PointerEvent event) {
    if (widget.config.enableParallax) {
      setState(() {
        _localPosition = event.localPosition;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      onHover: _handleHover,
      child: GestureDetector(
        onTapDown: widget.onTap != null ? _handleTapDown : null,
        onTapUp: widget.onTap != null ? _handleTapUp : null,
        onTapCancel: widget.onTap != null ? _handleTapCancel : null,
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _pressAnimation,
            _hoverAnimation,
          ]),
          builder: (context, child) {
            return Transform.scale(
              scale: _pressAnimation.value,
              child: Container(
                width: widget.width,
                height: widget.height,
                margin: widget.margin,
                constraints: widget.constraints,
                child: LiquidGlassEffect(
                  config: widget.config,
                  isPressed: _isPressed,
                  isHovered: _isHovered,
                  localPosition: _localPosition,
                  hoverAnimation: _hoverAnimation.value,
                  child: Container(
                    padding: widget.padding,
                    alignment: widget.alignment,
                    decoration: widget.backgroundDecoration,
                    child: widget.child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
