import 'package:flutter/material.dart';

/// Configuration class for Liquid Glass appearance
class LiquidGlassConfig {

  const LiquidGlassConfig({
    this.baseColor,
    this.opacity = 0.1,
    this.blurAmount = 10.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.enableSpecularHighlight = true,
    this.refractionIntensity = 0.5,
    this.adaptToContent = true,
    this.shadows,
    this.border,
    this.gradient,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOutCubic,
    this.enableParallax = true,
    this.parallaxIntensity = 0.1,
    this.enableCustomShader = false,
    this.distortionAmount = 0.05,
    this.enableDynamicLight = true,
    this.lightPosition = const Offset(0.5, 0.3),
    this.enableMorphing = true,
    this.glassThickness = 1.0,
    this.enableChromaticAberration = false,
    this.frostIntensity = 0.0,
  });

  /// Factory constructor for simple usage
  factory LiquidGlassConfig.simple() {
    return const LiquidGlassConfig();
  }

  /// Factory constructor for dark mode
  factory LiquidGlassConfig.dark() {
    return const LiquidGlassConfig(
      baseColor: Colors.black,
      opacity: 0.2,
      blurAmount: 15,
      refractionIntensity: 0.7,
    );
  }

  /// Factory constructor for vibrant effect
  factory LiquidGlassConfig.vibrant() {
    return const LiquidGlassConfig(
      opacity: 0.15,
      blurAmount: 20,
      refractionIntensity: 0.8,
      enableChromaticAberration: true,
      distortionAmount: 0.08,
    );
  }

  /// Factory constructor for subtle effect
  factory LiquidGlassConfig.subtle() {
    return const LiquidGlassConfig(
      opacity: 0.05,
      blurAmount: 5,
      enableSpecularHighlight: false,
      refractionIntensity: 0.2,
      enableParallax: false,
    );
  }

  /// Factory constructor for frosted glass
  factory LiquidGlassConfig.frosted() {
    return const LiquidGlassConfig(
      opacity: 0.3,
      blurAmount: 25,
      frostIntensity: 0.8,
      refractionIntensity: 0.3,
    );
  }
  /// Base color of the glass. If null, adapts to content
  final Color? baseColor;

  /// Transparency level (0.0 - 1.0)
  final double opacity;

  /// Blur intensity for background
  final double blurAmount;

  /// Border radius
  final BorderRadius borderRadius;

  /// Enable/disable specular highlights
  final bool enableSpecularHighlight;

  /// Intensity of light refraction effect
  final double refractionIntensity;

  /// Enable dynamic color adaptation from content
  final bool adaptToContent;

  /// Shadow configuration
  final List<BoxShadow>? shadows;

  /// Border configuration
  final Border? border;

  /// Gradient overlay
  final Gradient? gradient;

  /// Animation duration for state changes
  final Duration animationDuration;

  /// Animation curve
  final Curve animationCurve;

  /// Enable parallax effect on movement
  final bool enableParallax;

  /// Parallax intensity
  final double parallaxIntensity;

  /// Custom shader effect
  final bool enableCustomShader;

  /// Distortion amount for glass effect
  final double distortionAmount;

  /// Enable dynamic light response
  final bool enableDynamicLight;

  /// Light source position (for specular highlights)
  final Offset lightPosition;

  /// Enable morphing animations
  final bool enableMorphing;

  /// Thickness appearance of the glass
  final double glassThickness;

  /// Chromatic aberration effect
  final bool enableChromaticAberration;

  /// Frosted glass effect intensity
  final double frostIntensity;

  LiquidGlassConfig copyWith({
    Color? baseColor,
    double? opacity,
    double? blurAmount,
    BorderRadius? borderRadius,
    bool? enableSpecularHighlight,
    double? refractionIntensity,
    bool? adaptToContent,
    List<BoxShadow>? shadows,
    Border? border,
    Gradient? gradient,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? enableParallax,
    double? parallaxIntensity,
    bool? enableCustomShader,
    double? distortionAmount,
    bool? enableDynamicLight,
    Offset? lightPosition,
    bool? enableMorphing,
    double? glassThickness,
    bool? enableChromaticAberration,
    double? frostIntensity,
  }) {
    return LiquidGlassConfig(
      baseColor: baseColor ?? this.baseColor,
      opacity: opacity ?? this.opacity,
      blurAmount: blurAmount ?? this.blurAmount,
      borderRadius: borderRadius ?? this.borderRadius,
      enableSpecularHighlight:
          enableSpecularHighlight ?? this.enableSpecularHighlight,
      refractionIntensity: refractionIntensity ?? this.refractionIntensity,
      adaptToContent: adaptToContent ?? this.adaptToContent,
      shadows: shadows ?? this.shadows,
      border: border ?? this.border,
      gradient: gradient ?? this.gradient,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      enableParallax: enableParallax ?? this.enableParallax,
      parallaxIntensity: parallaxIntensity ?? this.parallaxIntensity,
      enableCustomShader: enableCustomShader ?? this.enableCustomShader,
      distortionAmount: distortionAmount ?? this.distortionAmount,
      enableDynamicLight: enableDynamicLight ?? this.enableDynamicLight,
      lightPosition: lightPosition ?? this.lightPosition,
      enableMorphing: enableMorphing ?? this.enableMorphing,
      glassThickness: glassThickness ?? this.glassThickness,
      enableChromaticAberration:
          enableChromaticAberration ?? this.enableChromaticAberration,
      frostIntensity: frostIntensity ?? this.frostIntensity,
    );
  }
}
